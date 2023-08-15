CREATE TABLE PETSALE (
    ID INTEGER NOT NULL,
    PET CHAR(20),
    SALEPRICE DECIMAL(6,2),
    PROFIT DECIMAL(6,2),
    SALEDATE DATE
    );
    
CREATE TABLE PET (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER
    );
    
INSERT INTO PETSALE VALUES
    (1,'Cat',450.09,100.47,'2018-05-29'),
    (2,'Dog',666.66,150.76,'2018-06-01'),
    (3,'Parrot',50.00,8.9,'2018-06-04'),
    (4,'Hamster',60.60,12,'2018-06-11'),
    (5,'Goldfish',48.48,3.5,'2018-06-14');
    
INSERT INTO PET VALUES
    (1,'Cat',3),
    (2,'Dog',4),
    (3,'Hamster',2);
    
SELECT * FROM PETSALE;
SELECT * FROM PET;

# Task A1: Add a new QUANTITY column to the PETSALE table and show the altered table.
ALTER TABLE PETSALE
ADD COLUMN QUANTITY INTEGER;

SELECT * FROM PETSALE;

# Task A2: Now update the newly added QUANTITY column of the PETSALE table with some values and show all the records of the table.
UPDATE PETSALE SET QUANTITY = 9 WHERE ID = 1;
UPDATE PETSALE SET QUANTITY = 3 WHERE ID = 2;
UPDATE PETSALE SET QUANTITY = 2 WHERE ID = 3;
UPDATE PETSALE SET QUANTITY = 6 WHERE ID = 4;
UPDATE PETSALE SET QUANTITY = 24 WHERE ID = 5;

SELECT * FROM PETSALE;

# Task B: Delete the PROFIT column from the PETSALE table and show the altered table.
ALTER TABLE PETSALE
DROP COLUMN PROFIT;

SELECT * FROM PETSALE;

# Task C: Change the data type to VARCHAR(20) type of the column PET of the table PETSALE and show the altered table. 
ALTER TABLE PETSALE CHANGE PET PET VARCHAR(20);

SELECT * FROM PETSALE;

# Task D: Rename the column PET to ANIMAL of the PETSALE table and show the altered table.
ALTER TABLE PETSALE CHANGE PET ANIMAL varchar(20);

SELECT * FROM PETSALE;

# Task E: Remove all rows from the PET table and show the empty table.
TRUNCATE TABLE PET ;

SELECT * FROM PET;

# Task F: Delete the PET table and verify if the table still exists or not (SELECT statement won’t work if a table doesn’t exist).
DROP TABLE PET;

SELECT * FROM PET;

