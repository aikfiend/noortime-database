CREATE TABLE IF NOT EXISTS prayer_marks (
  id           BIGINT      NOT NULL AUTO_INCREMENT,
  user_id      BIGINT      NOT NULL,
  prayer_date  DATE        NOT NULL,
  prayer_name  VARCHAR(20) NOT NULL,
  completed_at DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_prayer_marks_user_date_prayer (user_id, prayer_date, prayer_name),
  KEY idx_prayer_marks_user_date (user_id, prayer_date),
  CONSTRAINT chk_prayer_name CHECK (prayer_name IN ('Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha')),
  CONSTRAINT fk_prayer_marks_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
