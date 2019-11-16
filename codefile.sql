--drop table functions

DROP TABLE departments;
DROP TABLE departments_emp;
DROP TABLE deparment_man;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

--create tables
CREATE TABLE departments (
		dept_no VARCHAR(30) NOT NULL,
		dept_name VARCHAR (30) NOT NULL
);

CREATE TABLE departments_emp (
		emp_no INT NOT NULL,
		dept_no VARCHAR(30) NOT NULL,
		from_date VARCHAR(30) NOT NULL,
		to_date VARCHAR(30) NOT NULL
);

CREATE TABLE department_man (
		dept_no VARCHAR(30) NOT NULL,
		emp_no INT NOT NULL,
		from_date VARCHAR(30) NOT NULL,
		to_date VARCHAR(30) NOT NULL
);

CREATE TABLE employees (
		emp_no INT NOT NULL,
		birth_date VARCHAR(30) NOT NULL,
		first_name VARCHAR(30) NOT NULL,
		last_name VARCHAR(30) NOT NULL,
		gender VARCHAR(10) NOT NULL,
		hire_date VARCHAR(30) NOT NULL
);

CREATE TABLE salaries (
		emp_no INT NOT NULL,
		salary INT NOT NULL,
		from_date VARCHAR(30) NOT NULL,
		to_date VARCHAR(30) NOT NULL
);

CREATE TABLE titles (
		emp_no INT NOT NULL,
		title VARCHAR(30) NOT NULL,
		from_date VARCHAR(30) NOT NULL,
		to_date VARCHAR(30) NOT NULL
);

--check to see that headers show up on tables and date imported properly
SELECT * FROM departments
SELECT * FROM departments_emp
SELECT * FROM department_man
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles
		
--List the following details of each employee: employee number, last name, first name, gender, and salary

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no = salaries.salary

--List employees who were hired in 1986

SELECT * FROM employees
WHERE hire_date LIKE '%1986';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT departments.dept_no, departments.dept_name, department_man.emp_no, employees.last_name, employees.first_name, department_man.from_date, department_man.to_date
FROM departments
JOIN department_man
ON departments.dept_no = department_man.dept_no
JOIN employees
ON department_man.emp_no = employees.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT departments_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM departments_emp
JOIN employees
ON departments_emp.emp_no = employees.emp_no
JOIN departments
ON departments_emp.dept_no = departments.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT departments_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM departments_emp
JOIN employees
ON departments_emp.emp_no = employees.emp_no
JOIN departments
ON departments_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';
		
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT departments_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM departments_emp
JOIN employees
ON departments_emp.emp_no = employees.emp_no
JOIN departments
ON departments_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;