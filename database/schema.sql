-- Fit Club: фитнес-клуб абонемент және жаттығуға жазылу жүйесі (MySQL)
CREATE DATABASE IF NOT EXISTS fit_club CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE fit_club;

CREATE TABLE users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    role          ENUM('member','admin') NOT NULL DEFAULT 'member',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE membership_plans (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(80) NOT NULL,
    duration_days INT NOT NULL,
    price         DECIMAL(10,2) NOT NULL,
    description   TEXT,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE memberships (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    plan_id    INT NOT NULL,
    start_date DATE NOT NULL,
    end_date   DATE NOT NULL,
    status     ENUM('active','expired','cancelled') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES membership_plans(id)
);

CREATE TABLE trainers (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    full_name        VARCHAR(100) NOT NULL,
    specialization   VARCHAR(100) NOT NULL,
    experience_years TINYINT NOT NULL DEFAULT 0,
    bio              TEXT
);

CREATE TABLE classes (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id   INT NOT NULL,
    title        VARCHAR(100) NOT NULL,
    description  TEXT,
    category     VARCHAR(50) NOT NULL,
    start_time   DATETIME NOT NULL,
    duration_min SMALLINT NOT NULL DEFAULT 60,
    capacity     TINYINT NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES trainers(id)
);

CREATE TABLE class_bookings (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    class_id   INT NOT NULL,
    status     ENUM('booked','cancelled') NOT NULL DEFAULT 'booked',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, class_id),
    FOREIGN KEY (user_id)  REFERENCES users(id)   ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
);

-- Бастапқы тест деректері
INSERT INTO membership_plans (name, duration_days, price, description) VALUES
('Айлық', 30, 15000, 'Клубқа 30 күнге қолжетімділік'),
('Тоқсандық', 90, 38000, 'Клубқа 90 күнге қолжетімділік'),
('Жылдық', 365, 130000, 'Клубқа 1 жылға қолжетімділік');

INSERT INTO trainers (full_name, specialization, experience_years, bio) VALUES
('Асхат Нұрланов', 'Күш жаттығулары', 8, 'Жаттықтырушы, бодибилдинг бойынша спорт шебері'),
('Айгерім Сәрсенова', 'Йога', 5, 'Сертификатталған йога нұсқаушысы'),
('Дәурен Қасымов', 'Кроссфит', 6, 'Кроссфит бойынша жаттықтырушы');ES rooms(id) ON DELETE CASCADE
);
