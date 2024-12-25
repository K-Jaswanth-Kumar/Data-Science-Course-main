--1. What is the Highest Number of copies sold by a Package? 
Select MAX(Sold) as HighestNosold From Software

--2. Display lowest course Fee. 
Select Min(Course_fee) as Lowest From Studies

--3. How old is the Oldest Male Programmer. 
Select max(age)as oldestage From
(
Select pname, GENDER,(datediff(year,DOB,getdate())) as age
From PROGRAMMER
where Gender = 'M'
) as P

--4. What is the AVG age of Female Programmers? 
Select GENDER, Avg(DATEDIFF(year,DOB,getdate())) as Age
From PROGRAMMER
group by GENDER
having GENDER = 'f'

--5. Calculate the Experience in Years for each Programmer and Display with their names in Descending order.
Select * from 
(
Select PNAME, Datediff(year,doj,getdate()) as EXP
From PROGRAMMER
) as x
order by exp desc

--6. How many programmers done the PGDCA Course? 
Select *
From Studies
Where Course = 'PGDCA'

--7. How much revenue has been earned thru sales of Packages Developed in C.5588
Select * From
(
Select DEVELOPIN , ((Sum(Scost)*Sum(Sold))-sum(Dcost)) as revenue
From Software
group by DEVELOPIN
) as X
where DEVELOPIN = 'C'

--8. How many Programmers Studied at Sabhari? 
Select *
From Studies
Where INSTITUTE = 'Sabhari'

--9. How many Packages Developed in DBASE? 
Select * 
From Software
where DEVELOPIN = 'DBASE'

--10. How many programmers studied in Pragathi? 
Select *
From STUDIES
where INSTITUTE = 'Pragathi'

--11. How many Programmers Paid 5000 to 10000 for their course? 
Select *
From PROGRAMMER
where SALARY between 5000 and 10000

--12. How many Programmers know either COBOL or PASCAL.
Select *
From PROGRAMMER
Where PROF1 = 'COBOL'
or PROF1 = 'PASCAL'
or PROF2 = 'COBOL'
or PROF2 = 'PASCAL'

--13. How many Female Programmers are there? 
Select count(gender) as Totalfemale 
From PROGRAMMER
Where gender = 'F'

--14. What is the AVG Salary? 
Select Avg(Salary) as AVGSAL
From PROGRAMMER

--15. How many people draw salary 2000 to 4000? 
Select Count(*) as TotalPeople
From PROGRAMMER
Where Salary between 2000 and 4000

--16. Display the sales cost of the packages Developed by each Programmer Language wise.
Select DEVELOPIN, SUM(SCOST*SOLD) as SalesCost
From Software
Group by DEVELOPIN
Having SUM(SCOST*SOLD) > 0

--17. Display the details of the Software Developed by the Male Programmers Earning More than 3000/-. 
Select *
from PROGRAMMER p, Software s
where p.pname = s.pname and salary > 3000 and gender = 'M'

--18. Who is the oldest Female Programmer who joined in 1992?
Select Pname, datepart(year,DOB) as Yearofbirth, GENDER, DATEDIFF(year,dob,getdate()) as age
from PROGRAMMER
where datepart(year,DOJ) = '1992' and GENDER = 'F'

--19. Who is the youngest male Programmer born in 1965?
Select Pname, datepart(year,DOB) as Yearofbirth, GENDER, DATEDIFF(year,dob,getdate()) as age
from PROGRAMMER
where datepart(year,DOB) = '1965' and GENDER = 'M'

--20. Which Package has the lowest selling cost? 
Select TITLE, Scost
From Software
where scost = (select min(scost) from Software)

--21. Which Female Programmer earning more than 3000 does not know C, C++, ORACLE or DBASE? 
Select * from PROGRAMMER where gender = 'F'
and Salary >3000 and PROF1 <> 'c' and PROF1 <>'c++' and PROF1 <>'oracle'
And PROF1<>'dbase' and PROF2 <> 'c'  and PROF2 <>'c++' and PROF2 <>'oracle'  And PROF2<>'dbase'

--22. Who is the Youngest Programmer knowing DBASE?		
SELECT pname, prof1, prof2, datediff(YEAR, dob, getdate()) as age
from programmer 
where dob = (SELECT max(dob) from programmer where prof1='dbase' or prof2='dbase');

--23. Which Language is known by only one Programmer? 
With CTE(pname,Prof) as (Select Pname, Prof1 as prof From PROGRAMMER union Select pname, prof2 from programmer)
Select Prof from CTE group by Prof having Count(prof) = 1

--24. Who is the most experienced male programmer knowing PASCAL. 
Select max(DATEDIFF(year,DOJ,getdate())) as EXPce From PROGRAMMER
where PROF1 = 'Pascal' or PROF2 = 'Pascal' And Gender = 'M'

--25. Who is the least experienced Programmer. 
Select * From(
		Select min(DATEDIFF(year,DOJ,getdate())) as MinYears
		From PROGRAMMER
		) as least_exp_prog

--26. Display the Number of Packages in Each Language for which Development Cost is less than 1000.
Select DEVELOPIN,COUNT(Title) as noofpack From Software
where dcost <1000
Group by DEVELOPIN

--27. Display Highest, Lowest and Average Salaries for those earning more than 2000.
Select max(salary) as Maxsal,min(salary) as Minsal, avg(salary) as AVGsal From PROGRAMMER
where SALARY > 2000