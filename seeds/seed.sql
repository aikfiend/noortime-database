-- Development seed data only — never run in production
-- Creates a test user with default location (Mecca) and preferences

INSERT IGNORE INTO users (google_id, email, name, avatar_url)
VALUES ('test_google_id_12345', 'testuser@clips4sale.com', 'Test User', NULL);

INSERT IGNORE INTO user_locations (user_id, city, country, latitude, longitude, timezone)
SELECT id, 'Mecca', 'Saudi Arabia', 21.3891, 39.8579, 'Asia/Riyadh'
FROM users WHERE google_id = 'test_google_id_12345';

INSERT IGNORE INTO user_preferences (user_id, calculation_method, madhab, time_format)
SELECT id, 4, 0, '24h'
FROM users WHERE google_id = 'test_google_id_12345';
