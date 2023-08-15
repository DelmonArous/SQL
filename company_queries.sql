-- Corporate
INSERT INTO employee VALUES(NULL, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
INSERT INTO branch VALUES(NULL, 'Corporate', 100, '2006-02-09');

UPDATE employee SET branch_id = 1 WHERE emp_id = 100;

INSERT INTO employee VALUES(NULL, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(NULL, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES(NULL, 'Scranton', 102, '1992-04-06');

UPDATE employee SET branch_id = 2 WHERE emp_id = 102;

INSERT INTO employee VALUES
(NULL, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2),
(NULL, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2),
(NULL, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(NULL, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES(NULL, 'Stamford', 106, '1998-02-13');

UPDATE employee SET branch_id = 3 WHERE emp_id = 106;

INSERT INTO employee VALUES
(NULL, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3),
(NULL, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES
(2, 'Hammer Mill', 'Paper'),
(2, 'Uni-ball', 'Writing Utensils'),
(3, 'Patriot Paper', 'Paper'),
(2, 'J.T. Forms & Labels', 'Custom Forms'),
(3, 'Uni-ball', 'Writing Utensils'),
(3, 'Hammer Mill', 'Paper'),
(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES
(NULL, 'Dunmore Highschool', 2),
(NULL, 'Lackawana Country', 2),
(NULL, 'FedEx', 3),
(NULL, 'John Daly Law, LLC', 3),
(NULL, 'Scranton Whitepages', 2),
(NULL, 'Times Newspaper', 3),
(NULL, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES
(105, 400, 55000),
(102, 401, 267000),
(108, 402, 22500),
(107, 403, 5000),
(108, 403, 12000),
(105, 404, 33000),
(107, 405, 26000),
(102, 406, 15000),
(105, 406, 130000);

-- Find all employees
SELECT * FROM works_with;

-- Find all clients
SELECT * FROM clients;

-- Find all employees ordered by salary
SELECT * from employee ORDER BY salary ASC;

-- Find all employees ordered by sex then name
SELECT * from employee ORDER BY sex, first_name, last_name;

-- Find the first 5 employees in the table
SELECT * from employee LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name, employee.last_name FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, employee.last_name AS surname FROM employee;

-- Find out all the different genders
SELECT DISTINCT sex FROM employee;

-- Find all male employees
SELECT * FROM employee WHERE sex = 'M';

-- Find all employees at branch 2
SELECT * FROM employee WHERE branch_id = 2;

-- Find all employee's id's and names who were born after 1969
SELECT emp_id, first_name, last_name FROM employee WHERE birth_day >= 1970-01-01;

-- Find all female employees at branch 2
SELECT * FROM employee WHERE branch_id = 2 AND sex = 'F';

-- Find all employees who are female & born after 1969 or who make over 80000
SELECT * FROM employee WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

-- Find all employees born between 1970 and 1975
SELECT * FROM employee WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David
SELECT * FROM employee WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');

-- Find the number of employees
SELECT COUNT(super_id) FROM employee; -- does not include NULL in count 
SELECT COUNT(emp_id) FROM employee WHERE sex = 'F' AND birth_day > '1971-01-01'; 

-- Find the average of all employee's salaries
SELECT AVG(salary) FROM employee;

-- Find the sum of all employee's salaries
SELECT SUM(salary) FROM employee;

-- Find out how many males and females there are
SELECT COUNT(sex), sex FROM employee GROUP BY sex;

-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id;

-- Find the total amount of money spent by each client
SELECT SUM(total_sales), client_id FROM works_with GROUP BY client_id;

-- % = any # characters, _ = one character

-- Find any client's who are an LLC
SELECT * FROM client WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT * FROM branch_supplier WHERE supplier_name LIKE '% Label%';

-- Find any employee born on the 10th day of the month
SELECT * FROM employee WHERE birth_day LIKE '____-10%';

-- Find any clients who are schools
SELECT * FROM client WHERE client_name LIKE '%school%';


-- Find a list of employee and branch names
SELECT employee.first_name AS Employee_Branch_Names FROM employee
UNION 
SELECT branch.branch_name FROM branch;

-- Find a list of all clients & branch suppliers' names
SELECT client.client_name AS NonEmployee_Entities, client.branch_id AS Branch_ID FROM client
UNION 
SELECT branch_supplier.supplier_name, branch_supplier.branch_id FROM branch_supplier;

-- Add the extra branch
INSERT INTO branch VALUES(NULL, 'Paff', NULL, NULL);

-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name FROM employee
JOIN branch ON employee.emp_id = branch.mgr_id; -- LEFT JOIN, RIGHT JOIN
 
-- Find names of all employees who have sold over 50,000
SELECT employee.first_name, employee.last_name FROM employee WHERE employee.emp_id IN (
	SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales > 50000
);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT client.client_id, client.client_name FROM client WHERE client.branch_id = (
	SELECT branch.branch_id FROM branch WHERE branch.mgr_id = 102 LIMIT 1
);

 -- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
SELECT client.client_id, client.client_name FROM client WHERE client.branch_id = (
	SELECT branch.branch_id FROM branch WHERE branch.mgr_id = (
		SELECT employee.emp_id FROM employee WHERE employee.first_name = 'Michael' AND employee.last_name ='Scott' LIMIT 1
	)
);

-- Find the names of employees who work with clients handled by the scranton branch
SELECT employee.first_name, employee.last_name FROM employee WHERE employee.emp_id IN (
	SELECT works_with.emp_id FROM works_with
) AND employee.branch_id = 2;

-- Find the names of all clients who have spent more than 100,000 dollars
SELECT client.client_name FROM client WHERE client.client_id IN (
	SELECT client_id FROM (
		SELECT SUM(works_with.total_sales) AS totals, client_id FROM works_with GROUP BY client_id
	) 
    AS total_client_sales WHERE totals > 100000
);
