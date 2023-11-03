CREATE DATABASE db_school;

USE db_school;

CREATE TABLE classes (
	class_id INT PRIMARY KEY NOT NULL IDENTITy (1,1),
	class_name VARCHAR(50)
);

CREATE TABLE instructors (
	instructor_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	instructor_name VARCHAR(50)
);

CREATE TABLE students (
	student_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	student_name VARCHAR(50),
	class_id INT NULL,
	instructor_id INT NULL,
	FOREIGN KEY (class_id) REFERENCES classes(class_id),
	FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

INSERT INTO classes
	(class_name)
	VALUES
	('Software Developer Boot Camp'),
	('C# Boot Camp')
;

INSERT INTO students
	(student_name)
	VALUES
	('Darrell'),
	('Judah'),
	('Victor'),
	('Sam'),
	('John'),
	('Kyle')
;

INSERT INTO instructors
	(instructor_name)
	VALUES
	('Albert Einstein'),
	('Alan Turing')
;


-- Calculate the midpoint
DECLARE @midpoint INT;
SELECT @midpoint = CEILING(COUNT(*) / 2.0) FROM students;

-- Update Class_ID for the first half of students
UPDATE TOP (@midpoint) students
SET class_id = 1;

-- Update Class_ID for the remaining students
UPDATE students
SET class_id = 2
WHERE class_id IS NULL;



-- Calculate the midpoint for instructors
DECLARE @instructorMidpoint INT;
SELECT @instructorMidpoint = CEILING(COUNT(*) / 2.0) FROM students;

-- Update Instructor_ID for the first half of students
UPDATE TOP (@instructorMidpoint) students
SET instructor_id = 1;

-- Update Instructor_ID for the remaining students
UPDATE students
SET instructor_id = 2
WHERE instructor_id IS NULL;

SELECT * FROM instructors;

SELECT * FROM students;

SELECT * FROM students ORDER BY student_name;

SELECT
    c.class_name AS Class,
    s.student_name AS Student,
    i.instructor_name AS Instructor
FROM
    classes c
LEFT JOIN
    students s ON c.class_id = s.class_id
LEFT JOIN
    instructors i ON s.instructor_id = i.instructor_id
ORDER BY
    c.class_id, s.student_id;
