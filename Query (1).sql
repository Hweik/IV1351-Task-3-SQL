----Table1 1: Show the number of lessons given per month during a specified year-----
CREATE VIEW MonthlyLessonSummary AS
SELECT 
    TO_CHAR(lesson.start_Date, 'Mon') AS "Month",
    EXTRACT(MONTH FROM lesson.start_Date) AS "Month_Num",
    COUNT(*) AS "Total",
    COUNT(individual_lesson.lesson_id) AS "Individual",
    COUNT(group_lesson.lesson_id) AS "Group",
    COUNT(ensembles_lesson.lesson_id) AS "Ensemble"
FROM lesson
LEFT JOIN individual_lesson ON lesson.lesson_id = individual_lesson.lesson_id
LEFT JOIN group_lesson ON lesson.lesson_id = group_lesson.lesson_id
LEFT JOIN ensembles_lesson ON lesson.lesson_id = ensembles_lesson.lesson_id
WHERE EXTRACT(YEAR FROM lesson.start_Date) = 2023
GROUP BY TO_CHAR(lesson.start_Date, 'Mon'), 
         EXTRACT(MONTH FROM lesson.start_Date);
SELECT * 
FROM MonthlyLessonSummary
ORDER BY "Month_Num";




--Table 2: Show how many students there are with no sibling, with one sibling, with two siblings, etc--
SELECT 
    COUNT(s.student_id) AS "No_of_Students",
    COALESCE(sibling_counts.sibling_count, 0) AS "No_of_Siblings"
FROM student s
LEFT JOIN (
    SELECT 
        student_id, 
        COUNT(DISTINCT sibling_id) AS sibling_count
    FROM sibling
    GROUP BY student_id
) sibling_counts
ON s.student_id = sibling_counts.student_id
GROUP BY sibling_counts.sibling_count
ORDER BY "No_of_Siblings";
CREATE VIEW StudentSiblingSummary AS
SELECT 
    s.student_id,
    COUNT(DISTINCT sib.sibling_id) AS sibling_count
FROM student s
LEFT JOIN sibling sib
ON s.student_id = sib.student_id
GROUP BY s.student_id;
SELECT 
    COUNT(student_id) AS "No_of_Students",
    COALESCE(sibling_count, 0) AS "No_of_Siblings"
FROM StudentSiblingSummary
GROUP BY sibling_count
ORDER BY "No_of_Siblings";

--Table 3:List ids and names of all instructors who has given more than a specific number of lessons during the current month--
CREATE VIEW InstructorLessonSummary AS
SELECT 
    i.instructor_id AS "Instructor_ID",
    p.first_name AS "First_Name",
    p.last_name AS "Last_Name",
    COUNT(l.lesson_id) AS "No_of_Lessons"
FROM instructor i
JOIN person p ON i.person_id = p.person_id
JOIN lesson l ON i.instructor_id = l.instructor_id
WHERE EXTRACT(YEAR FROM l.start_date) = EXTRACT(YEAR FROM CURRENT_DATE)
  AND EXTRACT(MONTH FROM l.start_date) = EXTRACT(MONTH FROM CURRENT_DATE) -- Only lessons from the current month
GROUP BY i.instructor_id, p.first_name, p.last_name;

-- Query instructors with more than 3 lessons
SELECT 
    "Instructor_ID",
    "First_Name",
    "Last_Name",
    "No_of_Lessons"
FROM InstructorLessonSummary
WHERE "No_of_Lessons" > 0
ORDER BY "No_of_Lessons" DESC;

--Table 4:List all ensembles held during the next week
CREATE VIEW EnsemblesNextWeekSummary AS
SELECT "Lesson_ID", "Day", "Genre", "No_of_Free_Seats"
FROM (
    SELECT 
        lesson.lesson_id AS "Lesson_ID",
        TO_CHAR(lesson.start_date, 'Dy') AS "Day",
        ensembles_lesson.genre AS "Genre",
        CASE
            WHEN (ensembles_lesson.max_students - COALESCE(student_counts.no_of_students, 0)) <= 0 THEN 'No Seats'
            WHEN (ensembles_lesson.max_students - COALESCE(student_counts.no_of_students, 0)) <= 2 THEN '1 or 2 Seats'
            ELSE 'Many Seats'
        END AS "No_of_Free_Seats",
        EXTRACT(DOW FROM lesson.start_date) AS "Day_Order"
    FROM lesson
    JOIN ensembles_lesson ON lesson.lesson_id = ensembles_lesson.lesson_id
    LEFT JOIN (
        SELECT 
            lesson_id, 
            COUNT(student_id) AS no_of_students
        FROM student_lessons
        GROUP BY lesson_id
    ) student_counts ON lesson.lesson_id = student_counts.lesson_id
    WHERE lesson.start_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
) sub
ORDER BY "Day_Order", "Genre";

SELECT * 
FROM EnsemblesNextWeekSummary;
