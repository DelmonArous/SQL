DROP TABLE employee;
DROP TABLE branch;

CREATE TABLE employee (
    emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    birth_day DATE NOT NULL,
    sex VARCHAR(1) NOT NULL,
    salary INT NOT NULL,
    super_id INT NOT NULL,
    branch_id INT NOT NULL
)  AUTO_INCREMENT=100;

CREATE TABLE branch (
    branch_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(40) NOT NULL,
    mgr_id INT NOT NULL,
    mgr_start_date DATE NOT NULL,
    FOREIGN KEY (mgr_id) REFERENCES employee (emp_id)
);

ALTER TABLE employee ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id);
ALTER TABLE employee ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id);
ALTER TABLE employee MODIFY COLUMN super_id INT, MODIFY COLUMN branch_id INT;
-- ALTER TABLE tbl AUTO_INCREMENT = 5; -- including 5!
DELETE FROM branch WHERE branch_name = 'Buffalo';


DESCRIBE employee;

CREATE TABLE client (
    client_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(40) NOT NULL,
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branch (branch_id)
)  AUTO_INCREMENT=400;

CREATE TABLE works_with (
    emp_id INT NOT NULL,
    client_id INT NOT NULL,
    total_sales INT NOT NULL,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES employee (emp_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES client (client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT NOT NULL,
    supplier_name VARCHAR(40) NOT NULL,
    supply_type VARCHAR(40) NOT NULL,
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY (branch_id) REFERENCES branch (branch_id) ON DELETE CASCADE
);
