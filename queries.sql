-- Show all student records
SELECT * FROM students;

-- Show all available courses
SELECT * FROM courses;

-- Filter students by their city
SELECT name, age FROM students
WHERE city = 'Delhi';

-- Find students with grade A
SELECT student_id, grade FROM enrollments
WHERE grade = 'A';

-- Count total number of students
SELECT COUNT(*) AS total_students FROM students;

-- Join students with their courses
SELECT students.name, courses.course_name, enrollments.grade
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id;

-- Count students enrolled per course
SELECT courses.course_name, COUNT(enrollments.student_id) AS total_students
FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.course_name;

-- Get A grade students and courses
SELECT students.name, courses.course_name
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE enrollments.grade = 'A';

-- Students enrolled in multiple courses
SELECT students.name, COUNT(enrollments.course_id) AS total_courses,
SUM(CASE WHEN enrollments.grade = 'A' THEN 1 ELSE 0 END) AS a_grades
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
GROUP BY students.name
HAVING COUNT(enrollments.course_id) > 1;

-- Calculate each course A grade percentage
SELECT courses.course_name,
COUNT(enrollments.student_id) AS total_enrolled,
SUM(CASE WHEN enrollments.grade = 'A' THEN 1 ELSE 0 END) AS total_a_grades,
ROUND(SUM(CASE WHEN enrollments.grade = 'A' THEN 1 ELSE 0 END) * 100.0 / COUNT(enrollments.student_id), 2) AS a_grade_percentage
FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.course_name;

-- Find each students best grade
SELECT students.name, students.city, courses.course_name, enrollments.grade
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE enrollments.grade = (
    SELECT MIN(grade) FROM enrollments e2
    WHERE e2.student_id = students.student_id
);
