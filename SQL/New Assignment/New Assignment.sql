--1. Display the “FIRST_NAME” from Employee table using the alias name 
     --as Employee_name.
Select First_Name as Employee_name From Employee_Table;

--2. Display “LAST_NAME” from Employee table in upper case.
Select Upper(Last_name) as Last_name From Employee_Table

--3. Display unique values of DEPARTMENT from EMPLOYEE table.
Select distinct(Department) From Employee_Table

--4. Display the first three characters of LAST_NAME from EMPLOYEE table.
Select LEFT(last_name,3) as Last_name From Employee_Table

--5. Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.
Select distinct(Department),len(department) as dept_length From Employee_Table

--6. Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME. a space char should separate them.
Select CONCAT(first_name,' ',last_name) as Full_name From Employee_Table


--7. DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending.
Select * From Employee_Table 
	order by first_name asc

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending.
Select * From Employee_Table
    order by first_name asc, department desc

--9. Display details for EMPLOYEE with the first name as “Veena” and  “Karan” from EMPLOYEE table.
Select * From Employee_Table
	 Where first_name = 'Veena' or first_name = 'Karan';

--10. Display details of EMPLOYEE with DEPARTMENT name as “Admin”.
Select * From Employee_Table
		Where Department = 'Admin'

--11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘v’.
Select * from Employee_Table
		Where First_name like '%V%'

--12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.
Select *From Employee_Table
		 Where Salary between 100000 and 500000

--13 Display details of the employees who have joined in Feb-2020.
Select * From Employee_Table
		Where concat((Datepart(month,Joining_date)),'-',DATEPART(year,Joining_date)) = '12-2019'

--14 Display employee names with salaries >= 50000 and <= 100000.
Select * From Employee_Table
		Where Salary BETWEEN 5000 AND 8000

-- 15 Display the number of Employees for each department in the descenting order.
SELECT Department, COUNT(*) AS num_employees FROM Employee_Table
	GROUP BY Department
	ORDER BY num_employees DESC;

--16 DISPLAY details of the EMPLOYEES who are also Managers.
Select empt.Employee_ID,empt.First_name, ET.employee_title From Employee_Table as EmpT
		Inner join Employee_Tite as ET on ET.Employee_ref_id = EmpT.Employee_ID
		where employee_title = 'Manager'


--17 DISPLAY duplicate records having matching data in some fields of a table.
Select First_name, count(Employee_ID) as CountEMP from Employee_Table
		Group by First_name
		Having count(Employee_ID)>1
		
--18 Display only odd rows from a table.
Select * From Employee_Table
		where Employee_ID % 2 <> 0

--19 Clone a new table from EMPLOYEE table.
Select * Into Employee_Table_Backup From Employee_Table
		Select * From Employee_Table_Backup

--20 DISPLAY the TOP 2 highest salary from a table.
Select Top 2 * From Employee_Table
		order by Salary desc

--21. DISPLAY the list of employees with the same salary.
Select Salary from ( Select * , DENSE_RANK()Over(order by salary desc) as Rankvalue From Employee_Table
		) as x
		Group by Salary
		having count(*) >1
		Select * from Employee_Table
		where Salary = '1000'
		
--22 Display the second highest salary from a table.
Select * from ( Select * , DENSE_RANK()Over(order by salary desc) as Rankvalue From Employee_Table
		) as x
		where Rankvalue = 2
		
--23 Display the first 50% records from a table.
Select top 50 PERCENT DENSE_RANK() Over(order by salary desc) as Rankvalue, * From Employee_Table
		

--24. Display the departments that have less than 4 people in it.
Select Department, Count(Department) as Count From Employee_Table
		Group by Department
		Having Count(Department) < 4

--25. Display all departments along with the number of people in there.
Select Department, Count(Department) as Count From Employee_Table
		Group by Department

--26 Display the name of employees having the highest salary in each department.
Select * from (
		Select *, DENSE_RANK()over(partition by department order by salary desc) as rankvalue From Employee_Table
		) as X
		where rankvalue = 1

--27 Display the names of employees who earn the highest salary.
Select Top 1 First_name, Last_Name, Salary From Employee_Table
		Order by Salary desc


--28 Diplay the average salaries for each department
Select Department, Avg(Salary) As Avgsalary From Employee_Table
		Group by Department

--29 display the name of the employee who has got maximum bonus
Select Top 1 EB.Bonus_Amount, Empt.First_name, Salary from Employee_Table as empt
		inner join Employee_Bonus as EB on EB.Employee_ref_id= Empt.Employee_ID
		Order by Bonus_Amount desc

--30 Display the first name and title of all the employees
Select ET.employee_title, Empt.First_name from Employee_Table as empt
		inner join Employee_Tite as ET on ET.Employee_ref_id= Empt.Employee_ID