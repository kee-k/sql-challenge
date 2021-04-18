CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(10)   NOT NULL,
    "hire_date" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

select * from salaries;
select * from employees;
select * from departments;
select * from dept_manager;
select * from departments;
select * from dept_emp;

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex,salaries.salary
from employees
join salaries
on (salaries.emp_no = employees.emp_no);
 
--2. List first name, last name, and hire date for employees who were hired in 1986.
select first_name,last_name,hire_date from employees where hire_date like '%1986';
 
--3. List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from departments
join dept_manager
on (dept_manager.dept_no = departments.dept_no)
	join employees
	on (employees.emp_no = dept_manager.emp_no);
 
--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
from departments
join dept_emp
on (dept_emp.dept_no = departments.dept_no)
	join employees
	on (employees.emp_no = dept_emp.emp_no)

--5. List first name, last name, and sex for employees whose first name is "Hercules" and 
--last names begin with "B."
select first_name,last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, 
--first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from departments
join dept_emp
on (dept_emp.dept_no = departments.dept_no)
	join employees
	on (employees.emp_no = dept_emp.emp_no)
where dept_name = 'Sales'
	 
--7. List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from departments
join dept_emp
on (dept_emp.dept_no = departments.dept_no)
	join employees
	on (employees.emp_no = dept_emp.emp_no)
where dept_name = 'Sales' or dept_name = 'Development'

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
select last_name, count (last_name) as "count"
from employees
group by last_name
order by "count" desc;