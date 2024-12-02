DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS contact_person CASCADE;
DROP TABLE IF EXISTS student_lessons CASCADE;
DROP TABLE IF EXISTS student_payment CASCADE;
DROP TABLE IF EXISTS sibling CASCADE;
DROP TABLE IF EXISTS discount CASCADE;
DROP TABLE IF EXISTS instrument_rental CASCADE;
DROP TABLE IF EXISTS rental_price_history CASCADE;
DROP TABLE IF EXISTS instrument CASCADE;
DROP TABLE IF EXISTS lesson_price_history CASCADE;
DROP TABLE IF EXISTS individual_lesson CASCADE;
DROP TABLE IF EXISTS group_lesson CASCADE;
DROP TABLE IF EXISTS ensembles_lesson CASCADE;
DROP TABLE IF EXISTS lesson CASCADE;
DROP TABLE IF EXISTS person_phone CASCADE;
DROP TABLE IF EXISTS phone CASCADE;
DROP TABLE IF EXISTS person_email CASCADE;
DROP TABLE IF EXISTS email CASCADE;
DROP TABLE IF EXISTS person_address CASCADE;
DROP TABLE IF EXISTS address_info CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS instructor_salary CASCADE;
DROP TABLE IF EXISTS instructor CASCADE;
DROP TABLE IF EXISTS system_config CASCADE;
DROP TABLE IF EXISTS historical_lessons CASCADE;
DROP TYPE IF EXISTS difficulty CASCADE;
DROP TABLE IF EXISTS history_lesson CASCADE;

-- Skapa ENUM-typen för difficultyLevel
CREATE TYPE difficulty AS ENUM ('beginner', 'intermediate', 'advanced');

-- Create the person table
CREATE TABLE person (
    person_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    person_number CHAR(12) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Create the email table
CREATE TABLE email (
    email_id CHAR(10) NOT NULL PRIMARY KEY,
    email VARCHAR(200) NOT NULL UNIQUE
);

-- Create the person_email table
CREATE TABLE person_email (
    person_id INT NOT NULL,
    email_id CHAR(10) NOT NULL,
    PRIMARY KEY (person_id, email_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (email_id) REFERENCES email(email_id) ON DELETE CASCADE
);

-- Create the phone table
CREATE TABLE phone (
    phone_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    phone_no VARCHAR(200) NOT NULL UNIQUE
);

-- Create the person_phone table
CREATE TABLE person_phone (
    person_id INT NOT NULL,
    phone_id INT NOT NULL,
    PRIMARY KEY (person_id, phone_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (phone_id) REFERENCES phone(phone_id) ON DELETE CASCADE
);
-- Create the address_info table
CREATE TABLE address_info (
    address_id VARCHAR(100) NOT NULL PRIMARY KEY,
    zip CHAR(5) NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

-- Create the person_address table
CREATE TABLE person_address (
    person_id INT NOT NULL,
    address_id VARCHAR(100) NOT NULL,
    PRIMARY KEY (person_id, address_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE, 
    FOREIGN KEY (address_id) REFERENCES address_info(address_id)
);

CREATE TABLE student (
    student_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    person_id INT NOT NULL,
    skill_level VARCHAR(100),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

-- Create the contact_person table
CREATE TABLE contact_person (
    contact_person_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    person_id INT NOT NULL,
    student_id INT NOT NULL,
    relation VARCHAR(100) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);

-- Create the sibling table
CREATE TABLE sibling (
    student_id INT NOT NULL,
    sibling_id INT NOT NULL,
    PRIMARY KEY (student_id, sibling_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (sibling_id) REFERENCES student(student_id) ON DELETE CASCADE
);

ALTER TABLE sibling ADD CONSTRAINT chk_not_self CHECK (student_id != sibling_id);

CREATE OR REPLACE FUNCTION enforce_bidirectional_sibling()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM sibling
        WHERE student_id = NEW.sibling_id AND sibling_id = NEW.student_id
    ) THEN
        INSERT INTO sibling (student_id, sibling_id)
        VALUES (NEW.sibling_id, NEW.student_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_enforce_bidirectional_sibling
AFTER INSERT ON sibling
FOR EACH ROW
EXECUTE FUNCTION enforce_bidirectional_sibling();

-- Create the discount table
CREATE TABLE discount (
    discount_id VARCHAR(50) NOT NULL PRIMARY KEY,
    discount_rate DECIMAL(10, 2) NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);
-- Create the system_config table
CREATE TABLE system_config (
    config_type VARCHAR(50) NOT NULL PRIMARY KEY,
    config_value INT NOT NULL
);

-- Insert default system constraints
INSERT INTO system_config (config_type, config_value)
VALUES
    ('max_rental_duration_months', 12),
    ('max_active_rentals_per_student', 2);

-- Create the instructor table
CREATE TABLE instructor (
    instructor_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    person_id INT NOT NULL,
    scheduled_time_slot TIMESTAMP NOT NULL,
    lesson_type VARCHAR(100) NOT NULL,
    teach_ensembles BOOLEAN NOT NULL,
    total_lessons_taught INT DEFAULT 0,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

-- Create the lesson_price_history table
CREATE TABLE lesson_price_history (
    lesson_price_id VARCHAR(50) NOT NULL PRIMARY KEY,
    skill_level_price INT NOT NULL,
    lesson_type_price INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN NOT NULL,
    CONSTRAINT chk_end_date_after_start CHECK (end_date > start_date)
);
-- Create the historical_lessons table
CREATE TABLE historical_lessons (
    lesson_id VARCHAR(50),
    lesson_type VARCHAR(50),
    genre VARCHAR(50),
    instrument VARCHAR(50),
    price INT NOT NULL,
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    difficulty_level difficulty,
    duration TIME,
    PRIMARY KEY (lesson_id)
);
-- Create the lesson table
CREATE TABLE lesson (
    lesson_id VARCHAR(50) NOT NULL PRIMARY KEY,
    start_date DATE NOT NULL,
    duration TIME NOT NULL,
    instrument_type VARCHAR(50),
    difficulty_level difficulty NOT NULL,
    lesson_price_id VARCHAR(50) REFERENCES lesson_price_history(lesson_price_id) ON DELETE CASCADE,
    instructor_id INT NOT NULL REFERENCES instructor(instructor_id) ON DELETE CASCADE,
    lesson_year INT GENERATED ALWAYS AS (EXTRACT(YEAR FROM start_date)) STORED,
    lesson_month INT GENERATED ALWAYS AS (EXTRACT(MONTH FROM start_date)) STORED
);

-- Create the student_lessons table
CREATE TABLE student_lessons (
    lesson_id VARCHAR(50) NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (lesson_id, student_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);

-- Create lesson types
CREATE TABLE individual_lesson (
    lesson_id VARCHAR(50) NOT NULL PRIMARY KEY,
    time_slot TIME NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

CREATE TABLE group_lesson (
    lesson_id VARCHAR(50) NOT NULL PRIMARY KEY,
    max_students INT NOT NULL,
    min_students INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

CREATE TABLE ensembles_lesson (
    lesson_id VARCHAR(50) NOT NULL PRIMARY KEY,
    genre VARCHAR(10) NOT NULL,
    max_students INT NOT NULL,
    min_students INT NOT NULL,
    current_students INT DEFAULT 0,
    seat_status VARCHAR(20) GENERATED ALWAYS AS (
        CASE
            WHEN current_students >= max_students THEN 'No Seats'
            WHEN current_students >= max_students - 2 THEN 'Few Seats'
            ELSE 'Many Seats'
        END
    ) STORED,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);
-- Create the instrument table
CREATE TABLE instrument (
    instrument_id VARCHAR(50) NOT NULL PRIMARY KEY,
    instrument_type VARCHAR(100) NOT NULL,
    instrument_brand VARCHAR(100) NOT NULL,
    available_stock INT NOT NULL,
    lesson_id VARCHAR(50),
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

-- Create the rental_price_history table
CREATE TABLE rental_price_history (
    rental_price_id VARCHAR(50) NOT NULL PRIMARY KEY,
    instrument_id VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE
);

-- Create the instrument_rental table
CREATE TABLE instrument_rental (
    rental_id VARCHAR(100) NOT NULL PRIMARY KEY,
    rental_start_time TIMESTAMP NOT NULL,
    lease_expiry_time TIMESTAMP NOT NULL,
    rental_price_id VARCHAR(50) NOT NULL,
    instrument_id VARCHAR(50) NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (rental_price_id) REFERENCES rental_price_history(rental_price_id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);
-- Create the student_payment table
CREATE TABLE student_payment (
    payment_id VARCHAR(50) NOT NULL PRIMARY KEY,
    payment_date DATE NOT NULL,
    discount_id VARCHAR(50),
    rental_id VARCHAR(100),
    student_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (discount_id) REFERENCES discount(discount_id) ON DELETE CASCADE,
    FOREIGN KEY (rental_id) REFERENCES instrument_rental(rental_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);

-- Create the instructor_salary table
CREATE TABLE instructor_salary (
    salary_payment_id VARCHAR(50) NOT NULL PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    date_of_payment DATE NOT NULL,
    instructor_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE
);

CREATE TABLE history_lesson (
    lesson_id VARCHAR(50) NOT NULL,
    student_id INT NOT NULL,
    lesson_type VARCHAR(50) NOT NULL,
    genre VARCHAR(50),
    instrument VARCHAR(50),
    lesson_price DECIMAL(10, 2) NOT NULL,
    student_name VARCHAR(200) NOT NULL,
    student_email VARCHAR(200) NOT NULL,
    PRIMARY KEY (lesson_id, student_id)
);