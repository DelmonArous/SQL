DROP TABLE IF EXISTS EMPLOYEES;
DROP TABLE IF EXISTS JOB_HISTORY;
DROP TABLE IF EXISTS JOBS;
DROP TABLE IF EXISTS DEPARTMENTS;
DROP TABLE IF EXISTS LOCATIONS;

CREATE TABLE EMPLOYEES (
    EMP_ID CHAR(9) NOT NULL,
    F_NAME VARCHAR(15) NOT NULL,
    L_NAME VARCHAR(15) NOT NULL,
    SSN CHAR(9),
    B_DATE DATE,
    SEX CHAR,
    ADDRESS VARCHAR(30),
    JOB_ID CHAR(9),
    SALARY DECIMAL(10 , 2 ),
    MANAGER_ID CHAR(9),
    DEP_ID CHAR(9) NOT NULL,
    PRIMARY KEY (EMP_ID)
);

CREATE TABLE JOB_HISTORY (
    EMPL_ID CHAR(9) NOT NULL,
    START_DATE DATE,
    JOBS_ID CHAR(9) NOT NULL,
    DEPT_ID CHAR(9),
    PRIMARY KEY (EMPL_ID , JOBS_ID)
);

CREATE TABLE JOBS (
    JOB_IDENT CHAR(9) NOT NULL,
    JOB_TITLE VARCHAR(30),
    MIN_SALARY DECIMAL(10, 2),
    MAX_SALARY DECIMAL(10, 2),
    PRIMARY KEY (JOB_IDENT)
);

CREATE TABLE DEPARTMENTS (
    DEPT_ID_DEP CHAR(9) NOT NULL,
    DEP_NAME VARCHAR(15),
    MANAGER_ID CHAR(9),
    LOC_ID CHAR(9),
    PRIMARY KEY (DEPT_ID_DEP)
);

CREATE TABLE LOCATIONS (
    LOCT_ID CHAR(9) NOT NULL,
    DEP_ID_LOC CHAR(9) NOT NULL,
    PRIMARY KEY (LOCT_ID , DEP_ID_LOC)
);

SELECT * FROM EMPLOYEES;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

# Retrieve all employees whose address is in Elgin,IL.
SELECT * FROM EMPLOYEES WHERE ADDRESS LIKE "%Elgin,IL%";

# Retrieve all employees who were born during the 1970’s.
SELECT * FROM EMPLOYEES WHERE B_DATE LIKE "197%";

# Retrieve all employees in department 5 whose salary is between 60000 and 70000.
SELECT * FROM EMPLOYEES WHERE (SALARY BETWEEN 60000 AND 70000) AND DEP_ID = 5;

# Retrieve a list of employees ordered by department ID.
SELECT * FROM EMPLOYEES ORDER BY DEP_ID;

# Retrieve a list of employees ordered in descending order by department ID and 
# within each department ordered alphabetically in descending order by last name.
SELECT * FROM EMPLOYEES ORDER BY DEP_ID DESC, L_NAME DESC;

# Retrieve a list of employees ordered by department name, and within each department 
# ordered alphabetically in descending order by last name.
SELECT * FROM EMPLOYEES, DEPARTMENTS 
WHERE EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP
ORDER BY DEPARTMENTS.DEP_NAME, EMPLOYEES.L_NAME DESC;

# For each department ID retrieve the number of employees in the department.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES FROM EMPLOYEES GROUP BY DEP_ID;

# For each department retrieve the number of employees in the department, 
# and the average employee salary in the department.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES GROUP BY DEP_ID;

# In previous SQL, order the result set by Average Salary.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES GROUP BY DEP_ID ORDER BY AVG_SALARY;

# In previous SQL, limit the result to departments with fewer than 4 employees.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM 
EMPLOYEES GROUP BY DEP_ID HAVING COUNT(*)<4 ORDER BY AVG_SALARY;

# Execute a failing query (i.e. one which gives an error) to retrieve all employees records whose 
# salary is lower than the average salary.
SELECT * FROM EMPLOYEES WHERE SALARY < AVG(SALARY);

# Execute a working query using a sub-select to retrieve all employees records whose salary is 
# lower than the average salary.
SELECT * FROM EMPLOYEES WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

# Execute a failing query (i.e. one which gives an error) to retrieve all employees records 
# with EMP_ID, SALARY and maximum salary as MAX_SALARY in every row.
SELECT EMP_ID, SALARY, MAX(SALARY) AS MAX_SALARY FROM EMPLOYEES;	

# Execute a Column Expression that retrieves all employees records with EMP_ID, SALARY 
# and maximum salary as MAX_SALARY in every row.
SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM EMPLOYEES) AS MAX_SALARY FROM EMPLOYEES ;	

# Execute a Table Expression for the EMPLOYEES table that excludes columns with 
# sensitive employee data (i.e. does not include columns: SSN, B_DATE, SEX, ADDRESS, SALARY).
SELECT * FROM (SELECT EMP_ID, F_NAME, L_NAME, DEP_ID FROM EMPLOYEES) AS EMP4ALL;	

# Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table.
SELECT * FROM EMPLOYEES E WHERE E.JOB_ID IN (SELECT J.JOB_IDENT FROM JOBS J); 

# Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.
SELECT * FROM EMPLOYEES E WHERE E.JOB_ID IN (
SELECT J.JOB_IDENT FROM JOBS J WHERE LCASE(J.JOB_TITLE) = "Jr. Designer"
); 

# Retrieve JOB information and who earn more than $70,000.
SELECT * FROM JOBS J WHERE J.JOB_IDENT IN (
SELECT E.JOB_ID FROM EMPLOYEES E WHERE E.SALARY > 70000
);

# Retrieve JOB information and list of employees whose birth year is after 1976.
SELECT * FROM JOBS J WHERE J.JOB_IDENT IN (
SELECT E.JOB_ID FROM EMPLOYEES E WHERE YEAR(E.B_Date) > 1976
);

# Retrieve JOB information and list of female employees whose birth year is after 1976.
SELECT * FROM JOBS J WHERE J.JOB_IDENT IN (
SELECT E.JOB_ID FROM EMPLOYEES E WHERE YEAR(E.B_Date) > 1976 AND SEX = "F"
);

# Perform an implicit cartesian/cross join between EMPLOYEES and JOBS tables.
SELECT * FROM EMPLOYEES, JOBS;

# Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table.
SELECT * FROM EMPLOYEES, JOBS WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

# Redo the previous query, using shorter aliases for table names.
SELECT * FROM EMPLOYEES E, JOBS J WHERE E.JOB_ID = J.JOB_IDENT;

# Redo the previous query, but retrieve only the Employee ID, Employee Name and Job Title.
SELECT EMP_ID,F_NAME,L_NAME, JOB_TITLE 
FROM EMPLOYEES E, JOBS J WHERE E.JOB_ID = J.JOB_IDENT;

# Redo the previous query, but specify the fully qualified column names with aliases in the SELECT clause.
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE 
FROM EMPLOYEES E, JOBS J WHERE E.JOB_ID = J.JOB_IDENT;


# Create a view called EMPSALARY to display salary along with some basic sensitive data of employees from the HR database. 
CREATE VIEW EMPSALARY AS 
SELECT EMP_ID, F_NAME, L_NAME, B_DATE, SEX, SALARY
FROM EMPLOYEES; 

SELECT * FROM EMPSALARY; # retrieve all the records

# Combining two tables EMPLOYEES and JOBS to display desired information from the HR database,
# including the columns JOB_TITLE, MIN_SALARY, MAX_SALARY of the JOBS table as well as 
# excluding the SALARY column of the EMPLOYEES table.
CREATE OR REPLACE VIEW EMPSALARY  AS 
SELECT EMP_ID, F_NAME, L_NAME, B_DATE, SEX, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM EMPLOYEES, JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

SELECT * FROM EMPSALARY;

# Delete the created EMPSALARY view.
DROP VIEW EMPSALARY;

# Select the names and job start dates of all employees who work for the department number 5.
SELECT E.F_NAME, E.L_NAME, JH.START_DATE 
FROM EMPLOYEES AS E 
INNER JOIN JOB_HISTORY AS JH ON E.EMP_ID = JH.EMPL_ID 
WHERE E.DEP_ID = '5';

# Select the names, job start dates, and job titles of all employees who work for the department number 5.
SELECT E.F_NAME, E.L_NAME, JH.START_DATE, J.JOB_TITLE 
FROM EMPLOYEES AS E 
INNER JOIN JOB_HISTORY AS JH ON E.EMP_ID = JH.EMPL_ID 
INNER JOIN JOBS AS J ON J.JOB_IDENT = JH.JOBS_ID   
WHERE E.DEP_ID = '5';

# Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT tables and 
# select employee id, last name, department id and department name for all employees.
SELECT E.EMP_ID, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
FROM EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D ON  E.DEP_ID = D.DEPT_ID_DEP;

# Re-write the previous query but limit the result set to include only 
# the rows for employees born before 1980.
SELECT E.EMP_ID, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID = D.DEPT_ID_DEP
WHERE YEAR(E.B_DATE) < 1980;

# Re-write the previous query but have the result set include all 
# the employees but department names for only the employees who were born before 1980.
SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
FROM EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID = D.DEPT_ID_DEP 
AND YEAR(E.B_DATE) < 1980;

# Perform a Full Join on the EMPLOYEES and DEPARTMENT tables and 
# select the First name, Last name and Department name of all employees.
SELECT E.EMP_ID, E.L_NAME, D.DEP_NAME
FROM EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID = D.DEPT_ID_DEP 
UNION
SELECT E.EMP_ID, E.L_NAME, D.DEP_NAME
FROM EMPLOYEES AS E 
RIGHT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID = D.DEPT_ID_DEP;

# Re-write the previous query but have the result set include all 
# employee names but department id and department names only for male employees.
SELECT E.EMP_ID, E.L_NAME, D.DEP_NAME
FROM EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID = D.DEPT_ID_DEP AND E.SEX = 'M'
UNION
SELECT E.EMP_ID, E.L_NAME, D.DEP_NAME
FROM EMPLOYEES AS E 
RIGHT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID = D.DEPT_ID_DEP AND E.SEX = 'M';
