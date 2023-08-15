-- Databases and SQL for Data Science with Python: Module 6 Bonus Module: Advanced SQL for Data Engineer (Honors): Final Project

-- -------------------- Exercise 1: Using Joins -------------------- --

-- Question 1 
# Write and execute a SQL query to list the school names, community names 
# and average attendance for communities with a hardship index of 98.
SELECT CPS.NAME_OF_SCHOOL, CPS.AVERAGE_STUDENT_ATTENDANCE, CSD.COMMUNITY_AREA_NAME 
FROM CHICAGO_PUBLIC_SCHOOLS AS CPS
LEFT OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA AS CSD ON CPS.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER 
WHERE CSD.HARDSHIP_INDEX = 98;

-- Question 2 
# Write and execute a SQL query to list all crimes that took place at a school. 
# Include case number, crime type and community name.
SELECT CD.CASE_NUMBER, CD.PRIMARY_TYPE, CSD.COMMUNITY_AREA_NAME, CD.LOCATION_DESCRIPTION
FROM CHICAGO_CRIME AS CD
LEFT OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA AS CSD ON CD.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER
WHERE CD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

-- -------------------- Exercise 2: Creating a View -------------------- --

-- Question 1
# Write and execute a SQL statement to create a view showing the columns listed in the following table, 
# with new column names as shown in the second column.
DROP VIEW IF EXISTS VIEW_CPS; # drop view if it exists

CREATE VIEW VIEW_CPS (School_Name, Safety_Rating, Family_Rating, Environment_Rating, 
Instruction_Rating, Leaders_Rating, Teachers_Rating) 
AS SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon, 
Instruction_Icon, Leaders_Icon, Teachers_Icon
FROM CHICAGO_PUBLIC_SCHOOLS;

# Write and execute a SQL statement that returns all of the columns from the view.
SELECT * FROM VIEW_CPS; 

# Write and execute a SQL statement that returns just the school name and leaders rating from the view.
SELECT School_Name, Leaders_Rating FROM VIEW_CPS;

-- -------------------- Exercise 3: Creating a Stored Procedure -------------------- --

-- Question 1
# Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE 
# that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer.
DELIMITER //

CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leaders_Score INTEGER)

BEGIN 

END //

DELIMITER ; 

-- Question 2
# Inside your stored procedure, write a SQL statement to update the Leaders_Score field in the 
# CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID to the value in the in_Leader_Score parameter.
DELIMITER //

CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leaders_Score INTEGER)

BEGIN
  
	UPDATE CHICAGO_PUBLIC_SCHOOLS 
	SET Leaders_Score = in_Leaders_Score
	WHERE School_ID = in_School_ID; 

	COMMIT;    
   
END //

DELIMITER ; 

-- Question 3
# Inside your stored procedure, write a SQL IF statement to update the Leaders_Icon field in the 
# CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID using the following information.
DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE; # drop stored procedure if it exists
DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leaders_Score INTEGER)
BEGIN
	UPDATE CHICAGO_PUBLIC_SCHOOLS 
	SET Leaders_Score = in_Leaders_Score
	WHERE School_ID = in_School_ID; 

	IF in_Leaders_Score > 0 AND in_Leaders_Score < 20 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 40 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 60 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Average'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 80 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Strong'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 100 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very Strong'
		WHERE School_ID = in_School_ID;
	END IF;
END //
DELIMITER ; 

-- Question 4
# Run your code to create the stored procedure. Write a query to call the stored procedure, 
# passing a valid school ID and a leader score of 50, to check that the procedure works as expected.

# Modify data type of 'Leaders_Icon' column in order to not have any errors during exection
ALTER TABLE CHICAGO_PUBLIC_SCHOOLS MODIFY COLUMN Leaders_Icon VARCHAR(15);

CALL UPDATE_LEADERS_SCORE(610084, 50); 
SELECT School_ID, Leaders_Icon, Leaders_Score FROM CHICAGO_PUBLIC_SCHOOLS WHERE School_ID=610084;

-- -------------------- Exercise 4: Using Transactions -------------------- --

-- Question 1
# Update your stored procedure definition. Add a generic ELSE clause to the IF statement that 
# rolls back the current work if the score did not fit any of the preceding categories.
DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE; # drop stored procedure if it exists
DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leaders_Score INTEGER)
BEGIN
	UPDATE CHICAGO_PUBLIC_SCHOOLS 
	SET Leaders_Score = in_Leaders_Score
	WHERE School_ID = in_School_ID; 

	IF in_Leaders_Score > 0 AND in_Leaders_Score < 20 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 40 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 60 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Average'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 80 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Strong'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 100 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very Strong'
		WHERE School_ID = in_School_ID;
	ELSE
		ROLLBACK;
	END IF;
END //
DELIMITER ; 

-- Question 2
# Update your stored procedure definition again. Add a statement to commit the current unit 
# of work at the end of the procedure.
DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE; # drop stored procedure if it exists
DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leaders_Score INTEGER)
BEGIN
	UPDATE CHICAGO_PUBLIC_SCHOOLS 
	SET Leaders_Score = in_Leaders_Score
	WHERE School_ID = in_School_ID; 

	IF in_Leaders_Score > 0 AND in_Leaders_Score < 20 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 40 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 60 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Average'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 80 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Strong'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leaders_Score < 100 THEN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very Strong'
		WHERE School_ID = in_School_ID;
	ELSE
		ROLLBACK;
	END IF;
	COMMIT;
END //
DELIMITER ; 

# Run your code to replace the stored procedure.
# Write and run one query to check that the updated stored 
# procedure works as expected when you use a valid score of 38.
CALL UPDATE_LEADERS_SCORE(610084, 38); 
SELECT School_ID, Leaders_Icon, Leaders_Score FROM CHICAGO_PUBLIC_SCHOOLS WHERE School_ID=610084;

# Write and run another query to check that the updated stored procedure 
# works as expected when you use an invalid score of 101 (no changes were made).
CALL UPDATE_LEADERS_SCORE(610084, 101); 
SELECT School_ID, Leaders_Icon, Leaders_Score FROM CHICAGO_PUBLIC_SCHOOLS WHERE School_ID=610084;
