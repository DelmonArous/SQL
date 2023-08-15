DROP TABLE student;

CREATE TABLE IF NOT EXISTS student (
    student_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    major VARCHAR(30) NOT NULL DEFAULT 'Undecided'
);

#ALTER TABLE student MODIFY COLUMN gpa DECIMAL(3,2) NOT NULL;
#ALTER TABLE student DROP COLUMN gpa;

INSERT INTO student VALUES 
(NULL, 'Jack', 'Biology'),
(NULL, 'Kate', 'Sociology'),
(NULL, 'Claire', 'English'),
(NULL, 'Jack', 'Biology'),
(NULL, 'Mike', 'Computational Science'),
(NULL, 'Jennifer', 'Chemistry');

UPDATE student 
SET major = 'Chem'
WHERE major = 'Chemistry';
    
UPDATE student 
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student 
SET major = 'Biochem'
WHERE major = 'Bio' OR major = 'Chem';

DELETE FROM student 
WHERE name = 'Tom' AND major = 'English';

DESCRIBE student;
SELECT * FROM student;

SELECT * FROM student
WHERE student.major = 'Biochem'
ORDER BY student.major , student.student_id DESC
LIMIT 3;

SELECT * FROM student
WHERE name IN ('Claire' , 'Mike', 'Kate');
