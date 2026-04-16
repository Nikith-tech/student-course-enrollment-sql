-- Use the database
USE student_project;

-- 1. List all students
SELECT * FROM students;

-- 2. Show all courses
SELECT * FROM courses;

-- 3. Students enrolled in "Database Systems"
SELECT s.*
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

-- 4. Count total students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- 5. Display exam marks with student & course
SELECT s.name, c.course_name, r.marks
FROM results r
JOIN exams e ON r.exam_id = e.exam_id
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 6. Highest scoring student
SELECT s.name, r.marks
FROM results r
JOIN exams e ON r.exam_id = e.exam_id
JOIN students s ON e.student_id = s.student_id
ORDER BY r.marks DESC
LIMIT 1;

-- 7. Students not enrolled in any course
SELECT *
FROM students
WHERE student_id NOT IN (
    SELECT student_id FROM enrollment
);

-- 8. Courses with no exams conducted
SELECT *
FROM courses
WHERE course_id NOT IN (
    SELECT course_id FROM exams
);

-- 9. Average marks per course
SELECT c.course_name, AVG(r.marks) AS avg_marks
FROM results r
JOIN exams e ON r.exam_id = e.exam_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- 10. Students with grade 'A'
SELECT s.name, r.grade
FROM results r
JOIN exams e ON r.exam_id = e.exam_id
JOIN students s ON e.student_id = s.student_id
WHERE r.grade = 'A';

-- 11. List exams conducted in February
SELECT *
FROM exams
WHERE MONTH(exam_date) = 2;

-- 12. Convert marks → auto grade
SELECT marks,
CASE
    WHEN marks >= 85 THEN 'A'
    WHEN marks >= 70 THEN 'B'
    WHEN marks >= 50 THEN 'C'
    ELSE 'F'
END AS calculated_grade
FROM results;

-- 13. Student with most enrollments
SELECT s.name, COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
GROUP BY s.name
ORDER BY total_courses DESC
LIMIT 1;
