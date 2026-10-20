-- Жатақхана бөлмелерін брондау жүйесі: дерекқор құрылымы (MySQL)
CREATE DATABASE IF NOT EXISTS dorm_booking CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dorm_booking;

CREATE TABLE users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    gender        ENUM('male','female') NOT NULL,
    role          ENUM('student','admin') NOT NULL DEFAULT 'student',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dormitories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    address     VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE rooms (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    dormitory_id    INT NOT NULL,
    room_number     VARCHAR(10) NOT NULL,
    floor           TINYINT NOT NULL,
    capacity        TINYINT NOT NULL,
    gender_type     ENUM('male','female') NOT NULL,
    price_per_month DECIMAL(10,2) NOT NULL,
    description     TEXT,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE (dormitory_id, room_number),
    FOREIGN KEY (dormitory_id) REFERENCES dormitories(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    room_id    INT NOT NULL,
    check_in   DATE NOT NULL,
    check_out  DATE NOT NULL,
    status     ENUM('pending','approved','rejected','cancelled') NOT NULL DEFAULT 'pending',
    comment    VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);
