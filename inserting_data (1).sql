-- Insert data into person table (studenter)
INSERT INTO person (person_id, person_number, first_name, last_name)
VALUES 
(1, '123456789012', 'Anna', 'Karlsson'),
(2, '234567890123', 'Erik', 'Svensson'),
(3, '345678901234', 'Lisa', 'Nilsson'),
(4, '456789012345', 'John', 'Doe'),
(5, '567890123456', 'Emily', 'Smith'),
(6, '678901234567', 'Michael', 'Johnson'),
(7, '789012345678', 'Emma', 'Brown'),
(8, '890123456789', 'Sophia', 'Williams');

-- Insert data into person table (instruktörer)
INSERT INTO person (person_id, person_number, first_name, last_name)
VALUES 
(9, '901234567890', 'Ingrid', 'Bergman'),
(10, '012345678901', 'Sven', 'Larsson'),
(11, '123456789013', 'Karin', 'Johansson'),
(12, '234567890124', 'Lars', 'Karlsson'),
(13, '345678901235', 'Eva', 'Andersson');

-- Vi behöver skapa personposter för kontaktpersonerna
INSERT INTO person (person_id, person_number, first_name, last_name)
VALUES
(14, '456123789012', 'Maria', 'Karlsson'),
(15, '567234890123', 'Olof', 'Svensson'),
(16, '678345901234', 'Katarina', 'Nilsson'),
(17, '789456012345', 'Peter', 'Doe'),
(18, '890567123456', 'Linda', 'Smith'),
(19, '901678234567', 'Thomas', 'Johnson'),
(20, '012789345678', 'Eva', 'Brown'),
(21, '123890456789', 'Karl', 'Williams'),
(22, '243890458989', 'Carl', 'Andersson'),
(23, '014789345678', 'Eva', 'Brown'),
(24, '123123129012', 'Ludde', 'Williams'),
(25, '245890558989', 'Luva', 'Andersson'),
(26, '123890356789', 'Lase', 'Williams'),
(27, '243890235898', 'Laos', 'Andersson'),
(28, '014789321568', 'Penny', 'Brown'),
(29, '121890458789', 'Sara', 'Williams'),
(30, '245890458989', 'Sandra', 'Andersson'),
(31, '123890344789', 'Lukas', 'Williams'),
(32, '243890234898', 'Lucas', 'Andersson'),
(33, '014789356568', 'Viktor', 'Brown'),
(34, '121890467789', 'Jay', 'Williams'),
(35, '245890489989', 'Jayce', 'Andersson'),
(36, '153333227948', 'Harry', 'Potter');


-- Insert data into email table
INSERT INTO email (email_id, email)
VALUES 
('E001', 'anna.karlsson@example.com'),
('E002', 'erik.svensson@example.com'),
('E003', 'lisa.nilsson@example.com'),
('E004', 'john.doe@example.com'),
('E005', 'emily.smith@example.com'),
('E006', 'michael.johnson@example.com'),
('E007', 'emma.brown@example.com'),
('E008', 'sophia.williams@example.com'),
('E009', 'ingrid.bergman@example.com'),
('E010', 'sven.larsson@example.com'),
('E011', 'karin.johansson@example.com'),
('E012', 'lars.karlsson@example.com'),
('E013', 'eva.andersson@example.com');

-- Insert data into person_email table
INSERT INTO person_email (person_id, email_id)
VALUES 
(1, 'E001'),
(2, 'E002'),
(3, 'E003'),
(4, 'E004'),
(5, 'E005'),
(6, 'E006'),
(7, 'E007'),
(8, 'E008'),
(9, 'E009'),
(10, 'E010'),
(11, 'E011'),
(12, 'E012'),
(13, 'E013');

-- Insert data into phone table
INSERT INTO phone (phone_id, phone_no)
VALUES 
(1, '0701234567'),
(2, '0702345678'),
(3, '0703456789'),
(4, '0704567890'),
(5, '0705678901'),
(6, '0706789012'),
(7, '0707890123'),
(8, '0708901234'),
(9, '0709012345'),
(10, '0700123456'),
(11, '0701234568'),
(12, '0702345679'),
(13, '0703456780');

-- Insert data into person_phone table
INSERT INTO person_phone (person_id, phone_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13);

-- Insert data into address_info table
INSERT INTO address_info (address_id, zip, street, city)
VALUES 
('ADDR001', '11122', 'Storgatan 1', 'Stockholm'),
('ADDR002', '22233', 'Kungsgatan 5', 'Göteborg'),
('ADDR003', '33344', 'Sveavägen 12', 'Malmö'),
('ADDR004', '44455', 'Parkvägen 4', 'Uppsala'),
('ADDR005', '55566', 'Centralgatan 10', 'Lund'),
('ADDR006', '66677', 'Ringvägen 22', 'Helsingborg'),
('ADDR007', '77788', 'Torggatan 15', 'Örebro'),
('ADDR008', '88899', 'Kyrkogatan 3', 'Västerås'),
('ADDR009', '99900', 'Villagatan 8', 'Linköping'),
('ADDR010', '00011', 'Skolgatan 2', 'Umeå'),
('ADDR011', '10112', 'Fabriksgatan 7', 'Gävle'),
('ADDR012', '12131', 'Hamngatan 9', 'Sundsvall'),
('ADDR013', '13141', 'Brovägen 6', 'Karlstad');

-- Insert data into person_address table
INSERT INTO person_address (person_id, address_id)
VALUES 
(1, 'ADDR001'),
(2, 'ADDR002'),
(3, 'ADDR003'),
(4, 'ADDR004'),
(5, 'ADDR005'),
(6, 'ADDR006'),
(7, 'ADDR007'),
(8, 'ADDR008'),
(9, 'ADDR009'),
(10, 'ADDR010'),
(11, 'ADDR011'),
(12, 'ADDR012'),
(13, 'ADDR013'),
(14, 'ADDR001'), -- Antag att kontaktpersonerna bor på samma adress
(15, 'ADDR002'),
(16, 'ADDR003'),
(17, 'ADDR004'),
(18, 'ADDR005'),
(19, 'ADDR006'),
(20, 'ADDR007'),
(21, 'ADDR008');

-- Insert data into student table

INSERT INTO student (student_id, person_id, skill_level)
VALUES 
(1, 1, 'beginner'),
(2, 2, 'intermediate'),
(3, 3, 'advanced'),
(4, 4, 'beginner'),
(5, 5, 'intermediate'),
(6, 6, 'advanced'),
(7, 7, 'beginner'),
(8, 8, 'advanced'),
(9, 22, 'beginner'),
(10, 23, 'intermediate'),
(11, 24, 'beginner'),
(12, 25, 'advanced'),
(13, 26, 'beginner'),
(14, 27, 'intermediate'),
(15, 28, 'advanced'),
(16, 29, 'beginner'),
(17, 30, 'beginner'),
(18, 31, 'intermediate'),
(19, 32, 'advanced'),
(20, 33, 'intermediate'),
(21, 34, 'beginner'),
(22, 35, 'advanced'),
(23, 36, 'intermediate');

-- Insert data into sibling table
INSERT INTO contact_person (contact_person_id, person_id, student_id, relation)
VALUES 
(1, 14, 1, 'Parent'),
(2, 15, 2, 'Guardian'),
(3, 16, 3, 'Parent'),
(4, 17, 4, 'Parent'),
(5, 18, 5, 'Guardian'),
(6, 19, 6, 'Parent'),
(7, 20, 7, 'Sibling'),
(8, 21, 8, 'Guardian');

INSERT INTO sibling (student_id, sibling_id)
VALUES 
(1, 2),
(2, 1),

(6, 7),
(7, 6),

(3, 4),
(3, 5),
(4, 3),
(4, 5),
(5, 3),
(5, 4);

-- Insert data into discount table
INSERT INTO discount (discount_id, discount_rate, student_id)
VALUES 
('DIS001', 10.00, 1),
('DIS002', 5.00, 2),
('DIS003', 15.00, 3),
('DIS004', 20.00, 4),
('DIS005', 25.00, 5),
('DIS006', 30.00, 6),
('DIS007', 5.00, 7),
('DIS008', 10.00, 8);

-- Insert data into instructor table
INSERT INTO instructor (instructor_id, person_id, scheduled_time_slot, lesson_type, teach_ensembles)
VALUES 
(1, 9, '2023-11-21 10:00:00', 'Group', TRUE),
(2, 10, '2023-11-22 12:00:00', 'Individual', FALSE),
(3, 11, '2023-11-23 10:00:00', 'Individual', TRUE),
(4, 12, '2023-11-24 14:00:00', 'Group', FALSE),
(5, 13, '2023-11-25 09:00:00', 'Group', TRUE);


-- Insert data into instructor_salary table
INSERT INTO instructor_salary (salary_payment_id, amount, date_of_payment, instructor_id)
VALUES 
('SAL001', 20000.00, '2023-11-01', 1),
('SAL002', 25000.00, '2023-11-01', 2),
('SAL003', 22000.00, '2023-11-05', 3),
('SAL004', 24000.00, '2023-11-05', 4),
('SAL005', 26000.00, '2023-11-05', 5);

-- Insert data into lesson_price_history table
INSERT INTO lesson_price_history (lesson_price_id, skill_level_price, lesson_type_price, start_date, end_date, is_current)
VALUES 
('LP001', 100, 220, '2023-01-01', '2023-12-31', TRUE),
('LP002', 150, 290, '2023-01-01', '2023-12-31', TRUE),
('LP003', 120, 230, '2023-02-01', '2023-12-31', TRUE),
('LP004', 140, 260, '2023-03-01', '2023-12-31', TRUE),
('LP005', 160, 260, '2023-04-01', '2023-12-31', TRUE),
('LP006', 180, 280, '2023-05-01', '2023-12-31', TRUE),
('LP007', 200, 3000, '2023-06-01', '2023-12-31', TRUE),
('LP008', 160, 260, '2023-04-01', '2023-12-31', TRUE),
('LP009', 180, 280, '2023-05-01', '2023-12-31', TRUE),
('LP010', 160, 300, '2023-04-01', '2023-12-31', TRUE),
('LP011', 180, 230, '2023-05-01', '2023-12-31', TRUE),
('LP012', 160, 231, '2023-04-01', '2023-12-31', TRUE),
('LP013', 180, 861, '2023-05-01', '2023-12-31', TRUE),
('LP014', 160, 325, '2023-04-01', '2023-12-31', TRUE),
('LP015', 180, 351, '2023-05-01', '2023-12-31', TRUE),
('LP016', 160, 223, '2023-04-01', '2023-12-31', TRUE),
('LP017', 180, 851, '2023-05-01', '2023-12-31', TRUE),
('LP018', 160, 432, '2023-04-01', '2023-12-31', TRUE),
('LP019', 180, 567, '2023-05-01', '2023-12-31', TRUE),
('LP020', 160, 842, '2024-01-01', '2024-12-31', TRUE),
('LP021', 200, 134, '2024-01-01', '2024-12-31', TRUE),
('LP022', 180, 624, '2024-01-01', '2024-12-31', TRUE),
('LP023', 180, 245, '2024-01-01', '2024-12-31', TRUE),
('LP024', 320, 678, '2024-01-01', '2024-12-31', TRUE),
('LP025', 210, 356, '2024-01-01', '2024-12-31', TRUE),
('LP026', 320, 257, '2024-01-01', '2024-12-31', TRUE),
('LP027', 150, 156, '2024-01-01', '2024-12-31', TRUE),
('LP028', 140, 186, '2024-01-01', '2024-12-31', TRUE),
('LP029', 250, 245, '2024-01-01', '2024-12-31', TRUE),
('LP030', 320, 762, '2024-01-01', '2024-12-31', TRUE),
('LP031', 150, 123, '2024-01-01', '2024-12-31', TRUE),
('LP032', 190, 456, '2024-01-01', '2024-12-31', TRUE),
('LP033', 180, 789, '2024-01-01', '2024-12-31', TRUE),
('LP034', 150, 234, '2024-01-01', '2024-12-31', TRUE),
('LP035', 180, 563, '2024-01-01', '2024-12-31', TRUE),
('LP036', 190, 823, '2024-01-01', '2024-12-31', TRUE),
('LP037', 150, 456, '2024-01-01', '2024-12-31', TRUE),
('LP038', 180, 365, '2024-01-01', '2024-12-31', TRUE),
('LP039', 170, 875, '2024-01-01', '2024-12-31', TRUE),
('LP040', 190, 462, '2024-01-01', '2024-12-31', TRUE);
-- Insert data into lesson table
INSERT INTO lesson (lesson_id, start_date, duration, instrument_type, difficulty_level, lesson_price_id, instructor_id)
VALUES
    -- November Lessons
    ('L001', '2023-11-20', '01:00:00', 'Guitar', 'beginner', 'LP001', 1),
    ('L002', '2023-11-21', '02:00:00', 'Guitar', 'advanced', 'LP002', 2),
    ('L003', '2023-11-22', '01:30:00', 'Violin', 'beginner', 'LP003', 3),
    ('L004', '2023-11-23', '02:30:00', 'Drum', 'advanced', 'LP004', 4),
    ('L005', '2023-11-24', '01:00:00', 'Piano', 'intermediate', 'LP005', 5),
    ('L006', '2023-11-26', '02:00:00', 'Mixed', 'intermediate', 'LP005', 1),

    -- December Lessons
    ('L007', '2023-12-05', '01:00:00', 'Guitar', 'beginner', 'LP001', 1),
    ('L008', '2023-12-10', '01:30:00', 'Violin', 'intermediate', 'LP002', 2),
    ('L009', '2023-12-15', '02:00:00', 'Piano', 'advanced', 'LP003', 3),

    -- January Lessons
    ('L010', '2024-01-05', '02:30:00', 'Mixed', 'beginner', 'LP004', 5),
    ('L011', '2024-01-12', '01:00:00', 'Drum', 'intermediate', 'LP005', 5),
    ('L012', '2024-01-20', '02:00:00', 'Guitar', 'advanced', 'LP006', 1),

    -- February Lessons
    ('L013', '2024-02-03', '01:00:00', 'Guitar', 'beginner', 'LP007', 2),
    ('L014', '2024-02-10', '02:00:00', 'Mixed', 'intermediate', 'LP008', 3),
    ('L015', '2024-02-15', '01:30:00', 'Piano', 'advanced', 'LP009', 4),
    ('L016', '2024-02-25', '02:00:00', 'Violin', 'beginner', 'LP010', 5),

    -- March Lessons
    ('L017', '2024-03-01', '01:30:00', 'Piano', 'beginner', 'LP011', 1),
    ('L018', '2024-03-05', '02:00:00', 'Guitar', 'intermediate', 'LP012', 2),
    ('L019', '2024-03-10', '01:00:00', 'Violin', 'advanced', 'LP013', 3),
    ('L020', '2024-03-15', '02:30:00', 'Mixed', 'intermediate', 'LP014', 3),
    ('L021', '2024-03-20', '01:00:00', 'Piano', 'beginner', 'LP015', 5),
    ('L022', '2024-03-25', '02:00:00', 'Drum', 'advanced', 'LP016', 1),
	
	--November Lessons
	('L023', '2024-11-01', '01:30:00', 'Piano', 'beginner', 'LP011', 4),
    ('L024', '2024-11-03', '02:00:00', 'Guitar', 'intermediate', 'LP012', 5),
    ('L025', '2024-11-04', '01:00:00', 'Violin', 'advanced', 'LP013', 5),
    ('L026', '2024-11-08', '02:30:00', 'Mixed', 'intermediate', 'LP014', 3),
    ('L027', '2024-11-10', '01:00:00', 'Piano', 'beginner', 'LP015', 2),
    ('L028', '2024-11-12', '02:00:00', 'Drum', 'advanced', 'LP016', 1),
	('L029', '2024-11-14', '01:30:00', 'Piano', 'beginner', 'LP011', 2),
    ('L030', '2024-11-15', '02:00:00', 'Guitar', 'intermediate', 'LP012', 4),
    ('L031', '2024-11-18', '01:00:00', 'Violin', 'advanced', 'LP013', 2),
    ('L032', '2024-11-20', '02:30:00', 'Mixed', 'intermediate', 'LP014', 1),
    ('L033', '2024-11-21', '01:00:00', 'Piano', 'beginner', 'LP015', 2),
    ('L034', '2024-11-23', '02:00:00', 'Drum', 'advanced', 'LP016', 4),
	--December Lessons
    ('L035', '2024-12-02', '01:30:00', 'Piano', 'beginner', 'LP011', 5),
    ('L036', '2024-12-03', '02:00:00', 'Guitar', 'intermediate', 'LP012', 5),
    ('L037', '2024-12-04', '01:00:00', 'Violin', 'advanced', 'LP013', 1),
    ('L038', '2024-12-05', '02:30:00', 'Mixed', 'intermediate', 'LP014', 2),
    ('L039', '2024-12-07', '01:00:00', 'Piano', 'beginner', 'LP015', 5),
    ('L040', '2024-12-30', '02:00:00', 'Drum', 'advanced', 'LP016', 3);
-- Insert data into student_lessons table
INSERT INTO student_lessons (lesson_id, student_id)
VALUES
    -- Group Lessons
    ('L001', 1), ('L001', 4), ('L001', 9), ('L001', 16), -- Guitar
    ('L003', 7), ('L003', 13), ('L003', 17),             -- Violin
    ('L007', 1), ('L007', 4), ('L007', 9), ('L007', 16), -- Guitar
    ('L009', 3), ('L009', 6), ('L009', 15), ('L009', 19),-- Piano
    ('L011', 2), ('L011', 10), ('L011', 18),             -- Drum
    ('L016', 7), ('L016', 13),                           -- Violin
    ('L017', 4), ('L017', 14),  ('L017', 21),             -- Piano
    ('L019', 3), ('L019', 6), ('L019', 19),              -- Violin

    -- Individual Lessons
    ('L002', 12), -- Guitar
    ('L004', 8), -- Drum
    ('L005', 5), -- Piano
    ('L008', 3), -- Violin
    ('L012', 12), -- Guitar
    ('L013', 9), -- Guitar
    ('L015', 15), -- Piano
    ('L018', 16), -- Guitar
    ('L021', 21), -- Piano
    ('L022', 10), -- Drum

    -- Ensembles Lessons
    ('L006', 1), ('L006', 5), ('L006', 12), ('L006', 15), -- Guitar and Piano
    ('L010', 7), ('L010', 13), ('L010', 19), ('L010', 22),-- Violin and Piano
    ('L014', 3), ('L014', 6), ('L014', 8), ('L014', 18),  -- Piano, Drum, Violin
    ('L035', 1), ('L035', 4), ('L035', 5), ('L035', 8),-- Guitar, Drum, Piano
	('L035', 12), ('L035', 15), ('L035', 19), ('L035', 20),
	('L036', 13), ('L036', 2), ('L036', 12), ('L036', 15),
	('L037', 12), ('L037', 14), ('L037', 13), ('L037', 16),
	('L038', 4), ('L038', 17), ('L038', 2), ('L038', 20),
	('L038', 5), ('L038', 12), ('L038', 14), ('L038', 19),
	('L039', 2), ('L039', 4), ('L039', 20), ('L039', 15);-- Guitar, Drum, Piano

	-- Insert data into instrument table
INSERT INTO instrument (instrument_id, instrument_type, instrument_brand, available_stock, lesson_id)
VALUES
('INSTR001', 'Guitar', 'Yamaha', 5, 'L001'),
('INSTR002', 'Piano', 'Roland', 3, 'L002'),
('INSTR003', 'Violin', 'Stradivarius', 2, 'L003'),
('INSTR004', 'Drum', 'Pearl', 4, 'L004'),
('INSTR005', 'Flute', 'Yamaha', 6, 'L005');
-- Insert data into rental_price_history table
INSERT INTO rental_price_history (rental_price_id, instrument_id, start_date, end_date, is_current, price)
VALUES
('RP001', 'INSTR001', '2023-01-01', '2023-12-31', TRUE, 100.00),
('RP002', 'INSTR002', '2023-01-01', '2023-12-31', TRUE, 120.00),
('RP003', 'INSTR003', '2023-02-01', '2023-12-31', TRUE, 150.00),
('RP004', 'INSTR004', '2023-03-01', '2023-12-31', TRUE, 180.00),
('RP005', 'INSTR005', '2023-04-01', '2023-12-31', TRUE, 200.00);
-- Insert data into group_lesson table
INSERT INTO group_lesson (lesson_id, max_students, min_students)
VALUES
    ('L001', 8, 4), -- Group Guitar (beginner)
    ('L003', 6, 3), -- Group Violin (beginner)
    ('L007', 8, 4), -- Group Guitar (beginner)
    ('L009', 10, 4), -- Group Piano (advanced)
    ('L011', 6, 3), -- Group Drum (intermediate)
    ('L016', 8, 2), -- Group Violin (beginner)
    ('L017', 10, 3), -- Group Piano (beginner)
    ('L019', 6, 3); -- Group Violin (advanced)
-- Insert data into individual_lesson table
INSERT INTO individual_lesson (lesson_id, time_Slot)
VALUES
    ('L002', '10:00:00'), -- Guitar (advanced)
    ('L004', '11:30:00'), -- Drum (advanced)
    ('L005', '14:00:00'), -- Piano (intermediate)
    ('L008', '15:30:00'), -- Violin (intermediate)
    ('L012', '13:00:00'), -- Guitar (advanced)
    ('L013', '09:30:00'), -- Guitar (beginner)
    ('L015', '14:30:00'), -- Piano (advanced)
    ('L018', '12:00:00'), -- Guitar (intermediate)
    ('L021', '10:30:00'), -- Piano (beginner)
    ('L022', '11:00:00'); -- Drum (advanced)
-- Insert data into ensembles_lesson table
INSERT INTO ensembles_lesson (lesson_id, genre, max_students, min_students)
VALUES
    ('L006', 'Classical', 10, 2), -- Guitar and Piano
    ('L010', 'Jazz', 12, 2),      -- Piano and Violin
    ('L014', 'Rock', 15, 3),      -- Piano, Drum, and Violin
    ('L020', 'Pop', 15, 3),       -- Guitar, Drum, and Piano
	('L030', 'Classical', 26, 2), -- Guitar and Piano
    ('L034', 'Jazz', 12, 2),      -- Piano and Violin
	('L035', 'Rock', 20, 2),      -- Piano, Drum, and Violin
	('L036', 'Jazz', 5, 1),      -- Piano, Drum, and Violin
	('L037', 'Classical', 4, 2),      -- Piano, Drum, and Violin
    ('L038', 'Classical', 9, 4),      -- Piano, Drum, and Violin
    ('L039', 'Pop', 4, 1);      -- Guitar, Drum, and Piano
-- Insert data into instrument_rental table
INSERT INTO instrument_rental (rental_id, rental_start_time, lease_expiry_time, rental_price_id, instrument_id, student_id)
VALUES
('R001', '2023-11-20 10:00:00', '2023-12-20 10:00:00', 'RP001', 'INSTR001', 1),
('R002', '2023-11-21 10:00:00', '2023-12-21 10:00:00', 'RP002', 'INSTR002', 2);
-- Insert data into student_payment table
INSERT INTO student_payment (payment_id, payment_date, discount_id, rental_id, student_id, amount)
VALUES
('PAY001', '2023-11-22', 'DIS001', 'R001', 1, 90.00), -- Applied 10% discount
('PAY002', '2023-11-23', 'DIS002', 'R002', 2, 114.00); -- Applied 5% discount