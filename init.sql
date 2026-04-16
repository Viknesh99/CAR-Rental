-- PostgreSQL seed data for rentacar
-- Converted from the original MySQL dump (rentacar_db.sql)
-- This runs once when the PostgreSQL volume is first created.

-- Tables are created by Hibernate (ddl-auto=update), but we create them here
-- so seed data can be inserted immediately at DB init time (before backend starts).

-- ── Users ────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id         BIGSERIAL    PRIMARY KEY,
    email      VARCHAR(255),
    name       VARCHAR(255),
    password   VARCHAR(255),
    user_role  SMALLINT
);

INSERT INTO users (id, email, name, password, user_role) VALUES
(1, 'admin@test.com',              'Admin',    '$2a$10$fpz0J0u6uzpQgmTJZflnpu2Q3NIrrWyQQWc/X6MrU414t4Pv8FhtW', 0),
(2, 'yuwantha@gmail.com',          'Yuwantha', '$2a$10$h5mD/AmO0w8pGxZbq3m6G.v0OiObT0IohC8K2X8YeCpmbhCQ1o2em', 1),
(3, 'shamila@gmail.com',           'Shamila',  '$2a$10$2WrFo/iLCr9/Lz93IdiIH.tHX5JPlxoJHwM4IjMKEsD8QysHz8HF6', 1),
(4, 'nuwan@gmail.com',             'Nuwan',    '$2a$10$VzX1o2J4VXYbXYR/EZOpTeRn6m9Z4Q3/IcwokdDMgP8kghPnb8W0a', 1),
(5, 'nuwan@test.com',              'Nuwan',    '$2a$10$IjBGTpqUxxVmbknmqFrRGe3Gq9qt2viemGTYgE3R0NjjM81pnu8bu', 1),
(6, 'shamila@test.com',            'shamila',  '$2a$10$Ur5aImFpFBZJDK8kmSJ7Xuw6WhO4D2bh6NYuOI0ol0AhlRjqlGKY2', 1),
(7, 'yuwantharavihara123@gmail.com','yuwantha','$2a$10$rW5ob2r/7oKP.OXgddHVhuBnvSwA3DWZ/I54gY4YZvKO7/OrmFYJ.', 1),
(8, 'shanuwan@gmail.com',          'Nuwan',    '$2a$10$Bopy.I3kJm6z4eMD2br1O.SRTwgifz2VA.k0kuk8dP08fzH4hH6ra', 1);

-- Reset the sequence so next INSERT gets id=9
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));

-- ── Cars ─────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS cars (
    id           BIGSERIAL    PRIMARY KEY,
    brand        VARCHAR(255),
    color        VARCHAR(255),
    description  VARCHAR(255),
    image        BYTEA,
    model_year   VARCHAR(255),
    name         VARCHAR(255),
    price        INTEGER,
    transmission VARCHAR(255),
    type         VARCHAR(255)
);

-- Original cars had large image blobs; inserting without images here.
-- Upload images via the Admin dashboard after deployment.
INSERT INTO cars (id, brand, color, description, image, model_year, name, price, transmission, type) VALUES
(7, 'Toyota', 'White', 'Reliable and fuel-efficient sedan with modern safety features.', NULL, '2021', 'Toyota Corolla', 30, 'Automatic', 'Sedan'),
(8, 'HONDA',  'Grey',  'Features a spacious interior with seating for five, a 2.0L engine, automatic transmission, and advanced safety features such as lane-keeping assist and adaptive cruise control.', NULL, 'Tue Nov 10 2020 13:59:35 GMT+0530 (India Standard Time)', 'Honda Civic', 40, 'Automatic', 'Hybrid');

SELECT setval('cars_id_seq', (SELECT MAX(id) FROM cars));

-- ── BookACar ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS bookacar (
    id              BIGSERIAL PRIMARY KEY,
    amount          BIGINT,
    book_car_status SMALLINT,
    days            BIGINT,
    from_date       TIMESTAMP(6),
    to_date         TIMESTAMP(6),
    car_id          BIGINT NOT NULL REFERENCES cars(id) ON DELETE CASCADE,
    user_id         BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO bookacar (id, amount, book_car_status, days, from_date, to_date, car_id, user_id) VALUES
(5, 60, 1, 2, '2024-11-04 14:59:26.062000', '2024-11-06 14:59:33.439000', 7, 8),
(6, 0,  0, 0, '2024-11-14 15:01:03.876000', '2024-11-14 15:01:07.569000', 8, 8),
(7, 30, 0, 1, '2024-11-10 15:34:18.692000', '2024-11-11 15:34:57.032000', 7, 2);

SELECT setval('bookacar_id_seq', (SELECT MAX(id) FROM bookacar));
