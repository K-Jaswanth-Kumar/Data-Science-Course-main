--1. What is the cost of the costliest software development in Basic? 
Select DEVELOPIN ,MAx(Scost) as MaxScost From Software
group by DEVELOPIN
having DEVELOPIN = 'Basic'

--2. Display details of Packages whose sales crossed the 2000 Mark.
Select * From Software
where Scost > 2000

--3. Who are the Programmers who celebrate their Birthday’s During the Current Month? 
Select * from (Select PNAME, datepart(month,dob) as Birthmonth From PROGRAMMER) as X
Where birthmonth = 5

--4. Display the Cost of Package Developed By each Programmer.
Select PNAME, Sum(SCOST) as cost_of_package From Software
group by PNAME

--5. Display the sales values of the Packages Developed by the each Programmer.
Select PNAME, (SCOST*SOLD) as sales From Software

--6. Display the Number of Packages sold by Each Programmer. 
Select pname, SUm(Sold) As Noofpackagessold From Software
Group by PNAME
having sum(sold) >0

--7. Display each programmer’s name, costliest and cheapest Packages Developed by him or her.
Select PNAME, max(DCOST) as costliest, min(SCOST) as cheapest From Software
Group by Pname

--8. Display each institute name with number of Courses, Average Cost per Course.
Select INSTITUTE, Count(course) as NOofcourses, AVG(COURSE_FEE) as AVGFEE From STUDIES
group by INSTITUTE

--9. Display each institute Name with Number of Students. 
Select INSTITUTE, Count(Pname) as Noofstudent From STUDIES
Group by INSTITUTE

--10. List the programmers (form the software table) and the institutes they studied. including those WHO DIDN'T develop any package.
Select PNAME, institute from STUDIES 
where pname not in (Select pname from Software)

--11. How many packages were developed by students, who studied in institute that charge the lowest course fee?
Select s.pname, Count(title) as Packages From STUDIES st, Software s
Where st.pname = s.pname and COURSE_FEE = (select min(course_fee) from STUDIES)
Group by S.pname, Course_fee

--12. What is the AVG salary for those whose software sales is more than 50,000/-. 
Select AVG(Salary) as AVGSAL from Software s, PROGRAMMER p
where s.pname = P.pname and SCOST*SOLD>50000;

--13. Which language listed in prof1, prof2 has not been used to develop any package. 
Select Prof1 from PROGRAMMER where PROF1 not in (select developin from Software)
Union
Select Prof2 from PROGRAMMER where PROF2 not in (select developin from Software)

--14. Display the total sales value of the software, institute wise. 
Select St.institute, Sum(s.sold*s.SCOST) as Total_Sales_Value from STUDIES st, Software s
Where st.pname = S.PNAME
group by st.INSTITUTE

--15. Display the details of the Software Developed in C By female programmers of Pragathi.
Select s.* From Software s,STUDIES st,PROGRAMMER p
where S.pname = st.pname and p.pname = s.pname and Gender = 'F' and INSTITUTE ='pragathi' 

--16. Display the details of the packages developed in Pascal by the Female Programmers.
Select s.* From Software s, PROGRAMMER p
where s.pname = p.pname and DEVELOPIN = 'PAscal' and gender = 'F'

--17. Which language has been stated as the proficiency by most of the Programmers?
Select prof1 From PROGRAMMER
group by prof1
having prof1 = (select max(prof1) from PROGRAMMER)
union
Select Prof2 From PROGRAMMER
group by PROF2
having PROF2 = (select max(PROF2) from PROGRAMMER)

--18. Who is the Author of the Costliest Package? 
Select pname, DCOST From Software
where DCOST = (Select max(DCOST) from Software)

--19. Which package has the Highest Development cost? 
Select Title, DCOST from Software
where DCOST = (Select Max(DCOST) From Software)

--20. Who is the Highest Paid Female COBOL Programmer? 
Select * From PROGRAMMER
where SALARY = (select max(salary) from PROGRAMMER
				where (PROF1='COBOL'or Prof2='COBOL')) And GENDER = 'F'

--21. Display the Name of Programmers and Their Packages.
Select PNAME, Salary From PROGRAMMER

--22. Display the Number of Packages in Each Language Except C and C++. 
Select DEVELOPIN, Count(Title) as Noofpack From Software
group by DEVELOPIN
Having DEVELOPIN <>'C' 
and DEVELOPIN <> 'C++'

--23. Display AVG Difference between SCOST, DCOST for Each Package. 
Select Title , (Avg(Dcost)-Avg(Scost)) as AVGdiff From Software
group by title

--24. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered. 
Select * From(Select PNAME, Scost, Dcost, (Scost*Sold)-Dcost as Cost From Software) as x
Where Cost < 0

--25. Who is the Highest Paid C Programmers?
Select *from PROGRAMMER
Where Salary = (Select max(salary)
		       from PROGRAMMER 
			   where PROF1 = 'C' or PROF2 = 'C')

--26. Who is the Highest Paid Female COBOL Programmer? 
Select * From PROGRAMMER
where SALARY = (select max(salary) from PROGRAMMER
				where (PROF1='COBOL' or Prof2='COBOL')) And GENDER = 'F'