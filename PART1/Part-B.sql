--1 Retrieve the names of all employees who work on at least one of the projects.
SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE employee.ssn IN (SELECT ssn FROM employee INTERSECT (SELECT ESSN FROM works_on));
--2 For each department, retrieve the department number, department name, and the average salary of all employees working in that department. 
(SELECT dname, dno, avg(SALARY) FROM department, employee WHERE department.dnumber=employee.dno group by dname,dno);
--3 List the last names of all department managers who have no dependents.
SELECT Fname, minit, Lname FROM employee, department WHERE employee.ssn = department.mgr_ssn AND employee.ssn NOT IN (SELECT ssn FROM dependent, employee WHERE employee.ssn=dependent.essn);
--4 Determine the department that has the employee with the lowest salary among all employees. 
SELECT Dname, Fname, minit, Lname, salary FROM employee, department WHERE employee.dno = (SELECT dno FROM employee WHERE employee.salary=(SELECT min(salary) FROM employee)) AND employee.dno = department.dnumber;
--5 Find the total number of employees and the total number of dependents for every department
SELECT COUNT(DISTINCT(ssn)) AS num_of_emp, 
COUNT(dependent.dependent_name) AS num_of_dep FROM employee
FULL OUTER JOIN dependent ON employee.ssn=dependent.essn GROUP BY (employee.dno)
--6 Retrieve the names of employees whose salary is within $20,000 of the salary of the employee who is paid the most in the company (e.g., if the highest salary in the company is $80,000, retrieve the names of all employees that make at least $60,000)
SELECT Fname, minit, Lname FROM employee WHERE salary+20000 >= (SELECT max(salary) FROM employee);
