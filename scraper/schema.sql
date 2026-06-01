-- ============================================================
-- schema.sql — NAVTTC Database Structure
-- Option 1: stipend_eligible + hostel_available flat columns
--            on course_offerings for fast, JOIN-free lookups.
-- ============================================================

DROP TABLE IF EXISTS course_offerings;
DROP TABLE IF EXISTS institutes;
DROP TABLE IF EXISTS trades;
DROP TABLE IF EXISTS districts;
DROP TABLE IF EXISTS sectors;
DROP TABLE IF EXISTS programs;

CREATE TABLE programs (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT    NOT NULL UNIQUE
);

CREATE TABLE sectors (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT    NOT NULL UNIQUE
);

CREATE TABLE districts (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT    NOT NULL UNIQUE
);

CREATE TABLE trades (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT    NOT NULL UNIQUE
);

CREATE TABLE institutes (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    address     TEXT,
    district_id INTEGER,
    FOREIGN KEY (district_id) REFERENCES districts(id)
);

-- ▼ ONLY THIS TABLE CHANGED — two new columns added at the end ▼
CREATE TABLE course_offerings (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id        INTEGER,
    sector_id         INTEGER,
    trade_id          INTEGER,
    institute_id      INTEGER,
    stipend_eligible  INTEGER NOT NULL DEFAULT 0, -- 1 = Yes, 0 = No
    hostel_available  INTEGER NOT NULL DEFAULT 0, -- 1 = Yes, 0 = No
    FOREIGN KEY (program_id)   REFERENCES programs(id),
    FOREIGN KEY (sector_id)    REFERENCES sectors(id),
    FOREIGN KEY (trade_id)     REFERENCES trades(id),
    FOREIGN KEY (institute_id) REFERENCES institutes(id)
);
