CREATE TABLE students (
    student_id   INT PRIMARY KEY,
    name         VARCHAR(50),
    age          INT,
    city         VARCHAR(50)
);

CREATE TABLE courses (
    course_id    INT PRIMARY KEY,
    course_name  VARCHAR(50),
    instructor   VARCHAR(50)
);

CREATE TABLE enrollments (
    enrollment_id  INT PRIMARY KEY,
    student_id     INT,
    course_id      INT,
    grade          VARCHAR(5)
);
