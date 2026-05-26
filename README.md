# NoorTime Database

Raw SQL migrations and seeds for the NoorTime MySQL schema.

## Schema

| Table               | Purpose                                                   |
|---------------------|-----------------------------------------------------------|
| `sessions`          | Server-side sessions (auto-created by express-mysql-session) |
| `users`             | Google OAuth user records                                 |
| `user_locations`    | Saved location for prayer time lookup                     |
| `user_preferences`  | Calculation method, madhab, time format                   |
| `prayer_marks`      | Daily prayer completion tracking                          |

## Setup

```bash
# 1. Create the database (first time only)
DB_NAME=noortime DB_USER=root DB_HOST=localhost bash scripts/setup.sh

# 2. Run all migrations
DATABASE_URL=mysql://user:pass@host:3306/noortime bash scripts/migrate.sh

# 3. (Dev only) Seed test data
mysql -h host -u user -p noortime < seeds/seed.sql
```

## Notes

- `updated_at` columns are managed automatically by MySQL via
  `DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` — no triggers needed.
- The `sessions` table is created automatically by `express-mysql-session`
  at app startup (`createDatabaseTable: true`). Migration 001 is reference-only.
- All tables use `utf8mb4` for full Unicode (emoji, Arabic) support.

## AlAdhan Calculation Methods

| ID | Method                                              |
|----|-----------------------------------------------------|
| 2  | Islamic Society of North America (ISNA)             |
| 3  | Muslim World League                                 |
| 4  | Umm Al-Qura University, Makkah                      |
| 5  | Egyptian General Authority of Survey                |
| 13 | Diyanet İşleri Başkanlığı                           |

See https://aladhan.com/calculation-methods for the full list.
