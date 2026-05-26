#!/usr/bin/env bash
# Run all migrations in order against DATABASE_URL (mysql://user:pass@host:port/dbname)
set -euo pipefail

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "ERROR: DATABASE_URL is not set" >&2
  exit 1
fi

# Parse the URL with Node.js (already on the server for the app)
eval "$(node -e "
const u = new URL(process.env.DATABASE_URL);
console.log('DB_HOST=' + u.hostname);
console.log('DB_PORT=' + (u.port || 3306));
console.log('DB_USER=' + u.username);
console.log('DB_PASS=' + decodeURIComponent(u.password));
console.log('DB_NAME=' + u.pathname.slice(1));
")"

# Write credentials to a temp file so the password never appears in the process list
MYCNF=$(mktemp)
trap 'rm -f "$MYCNF"' EXIT
chmod 600 "$MYCNF"

cat > "$MYCNF" << EOF
[client]
host=${DB_HOST}
port=${DB_PORT}
user=${DB_USER}
password=${DB_PASS}
database=${DB_NAME}
EOF

MIGRATIONS_DIR="$(cd "$(dirname "$0")/../migrations" && pwd)"
echo "Running migrations from $MIGRATIONS_DIR against $DB_NAME@$DB_HOST"

for file in "$MIGRATIONS_DIR"/*.sql; do
  echo "  → $(basename "$file")"
  mysql --defaults-file="$MYCNF" < "$file"
done

echo "Migrations complete."
