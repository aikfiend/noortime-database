-- calculation_method values map to AlAdhan API method IDs (0–23)
-- madhab: 0 = Shafi/Hanbali/Maliki, 1 = Hanafi
CREATE TABLE IF NOT EXISTS user_preferences (
  id                 BIGINT      NOT NULL AUTO_INCREMENT,
  user_id            BIGINT      NOT NULL,
  calculation_method SMALLINT    NOT NULL DEFAULT 2,
  madhab             SMALLINT    NOT NULL DEFAULT 0,
  time_format        VARCHAR(5)  NOT NULL DEFAULT '24h',
  updated_at         DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_user_preferences_user_id (user_id),
  CONSTRAINT chk_time_format CHECK (time_format IN ('12h', '24h')),
  CONSTRAINT fk_user_preferences_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
