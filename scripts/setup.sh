#!/usr/bin/env bash
# Create the MySQL database (first-time setup only)
set -euo pipefail

DB_NAME="${DB_NAME:-noortime}"
DB_USER="${DB_USER:-root}"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-3306}"

echo "Creating database '$DB_NAME' on $DB_HOST:$DB_PORT..."
mysql --host="$DB_HOST" --port="$DB_PORT" --user="$DB_USER" -p \
  -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "Done. Run scripts/migrate.sh (with DATABASE_URL set) to apply migrations."
