--#######################################################################################
--#                                                                                     #
--#                                   TRIGGERS                                          #
--#                                                                                     #
--# rental_duration_check: Säkerställer att hyresperioden inte överstiger max tillåten. #
--# active_rentals_check: Kontrollerar att en student inte har mer än max aktiva hyror. #
--# update_rental_price_history: Hanterar historik för hyrespriser och uppdaterar       #
--# is_current för att säkerställa att endast en post är aktuell.                       #
--# instrument_stock_check: Säkerställer att instrumentet finns i lager innan uthyrning #
--# och minskar lagret med 1 vid uthyrning.                                             #
--# unique_student_lesson_check: Säkerställer att en student inte är registrerad mer än #
--# en gång för samma lektion.                                                          #
--# lesson_capacity_check: Säkerställer att antalet registrerade studenter inte överst  #
--# maxkapaciteten för en lektion.                                                      #
--#######################################################################################

-- Trigger 1: Kontrollera max antal aktiva hyresavtal per student
CREATE OR REPLACE FUNCTION check_active_rentals()
RETURNS TRIGGER AS $$
DECLARE
    active_rentals_count INT;
    max_active_rentals INT;
BEGIN
    -- Hämta max antal aktiva hyror från system_config
    SELECT config_value INTO max_active_rentals
    FROM system_config
    WHERE config_type = 'max_active_rentals_per_student';

    IF max_active_rentals IS NULL THEN
        RAISE EXCEPTION 'Configuration for max_active_rentals_per_student is missing in system_config.';
    END IF;

    -- Räkna studentens aktiva hyror
    SELECT COUNT(*) INTO active_rentals_count
    FROM instrument_rental
    WHERE student_id = NEW.student_id
      AND lease_expiry_time >= CURRENT_DATE; -- Kontrollera aktiva hyrningar

    -- Kontrollera om antalet aktiva hyror överstiger max tillåtna
    IF (active_rentals_count >= max_active_rentals) THEN
        RAISE EXCEPTION 'Student % already has the maximum allowed number of active rentals (%).', NEW.student_id, max_active_rentals;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS active_rentals_check ON instrument_rental;

CREATE TRIGGER active_rentals_check
BEFORE INSERT OR UPDATE ON instrument_rental
FOR EACH ROW
EXECUTE FUNCTION check_active_rentals();


-- Trigger 2: Kontrollera max hyrestid i månader
CREATE OR REPLACE FUNCTION check_rental_duration()
RETURNS TRIGGER AS $$
DECLARE
    max_duration_months INT;
BEGIN
    -- Hämta max hyrestid från system_config
    SELECT config_value INTO max_duration_months
    FROM system_config
    WHERE config_type = 'max_rental_duration_months';

    IF max_duration_months IS NULL THEN
        RAISE EXCEPTION 'Configuration for max_rental_duration_months is missing in system_config.';
    END IF;

    -- Kontrollera om hyrestiden överstiger max tillåten
    IF (NEW.lease_expiry_time > NEW.rental_start_time + (max_duration_months || ' months')::interval) THEN
        RAISE EXCEPTION 'Rental duration exceeds the maximum allowed limit of % months.', max_duration_months;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS rental_duration_check ON instrument_rental;

CREATE TRIGGER rental_duration_check
BEFORE INSERT OR UPDATE ON instrument_rental
FOR EACH ROW
EXECUTE FUNCTION check_rental_duration();


-- Trigger 3: Uppdatera "is_current" i rental_price_history
CREATE OR REPLACE FUNCTION update_rental_price_history()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.is_current = TRUE AND (TG_OP = 'INSERT' OR OLD.is_current <> TRUE)) THEN
        -- Markera alla andra poster som inaktuella för samma instrument
        UPDATE rental_price_history
        SET is_current = FALSE
        WHERE instrument_id = NEW.instrument_id
          AND rental_price_id != NEW.rental_price_id
          AND is_current = TRUE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_rental_price_trigger ON rental_price_history;

CREATE TRIGGER update_rental_price_trigger
AFTER INSERT OR UPDATE ON rental_price_history
FOR EACH ROW
EXECUTE FUNCTION update_rental_price_history();


-- Trigger 4: Kontrollera och uppdatera lagerstatus för instrument
CREATE OR REPLACE FUNCTION check_and_update_instrument_stock()
RETURNS TRIGGER AS $$
BEGIN
    -- Minska lagret med 1 och kontrollera att lagret inte blir negativt
    UPDATE instrument
    SET available_stock = available_stock - 1
    WHERE instrument_id = NEW.instrument_id
      AND available_stock > 0;

    -- Kontrollera om lagret uppdaterades
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Instrument % is out of stock.', NEW.instrument_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS instrument_stock_check ON instrument_rental;

CREATE TRIGGER instrument_stock_check
BEFORE INSERT ON instrument_rental
FOR EACH ROW
EXECUTE FUNCTION check_and_update_instrument_stock();


-- Trigger 5: Kontrollera unik relation i student_lessons (kan utelämnas om PRIMARY KEY finns)
-- Den här triggern är egentligen redundant om du har en PRIMARY KEY på (lesson_id, student_id)
-- i tabellen student_lessons. Om så är fallet, kan du ta bort denna trigger.

-- Trigger 6: Kontrollera lektionens kapacitet
CREATE OR REPLACE FUNCTION check_lesson_capacity()
RETURNS TRIGGER AS $$
DECLARE
    student_count INT;
    max_capacity INT;
BEGIN
    -- Räkna antalet studenter för lektionen, inklusive den nya
    SELECT COUNT(*) + 1 INTO student_count
    FROM student_lessons
    WHERE lesson_id = NEW.lesson_id;

    -- Hämta maxkapacitet för lektionen
    SELECT max_students INTO max_capacity
    FROM group_lesson
    WHERE lesson_id = NEW.lesson_id;

    IF max_capacity IS NULL THEN
        SELECT max_students INTO max_capacity
        FROM ensembles_lesson
        WHERE lesson_id = NEW.lesson_id;
    END IF;

    IF max_capacity IS NULL THEN
        -- Kontrollera om det är en individuell lektion
        IF EXISTS (SELECT 1 FROM individual_lesson WHERE lesson_id = NEW.lesson_id) THEN
            max_capacity := 1;
        ELSE
            -- Om lektionen inte finns i någon av tabellerna
            RAISE EXCEPTION 'Lesson % does not exist in any lesson type table.', NEW.lesson_id;
        END IF;
    END IF;

    -- Kontrollera om lektionen har nått sin maxkapacitet
    IF student_count > max_capacity THEN
        RAISE EXCEPTION 'Lesson % has reached its maximum capacity of % students.', NEW.lesson_id, max_capacity;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS lesson_capacity_check ON student_lessons;

CREATE TRIGGER lesson_capacity_check
BEFORE INSERT ON student_lessons
FOR EACH ROW
EXECUTE FUNCTION check_lesson_capacity();
