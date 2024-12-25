--1. How many Programmers Don’t know PASCAL and C 
Select * From PROGRAMMER
Where PROF1 <> 'C'
and PROF1 <> 'PASCAL'
and PROF2 <> 'C'
and PROF2 <> 'PASCAL'

--2. Display the details of those who don’t know Clipper, COBOL or PASCAL. 
Select * From PROGRAMMER
Where PROF1 <> 'clipper'
And PROF1 <> 'Cobol'
And PROF1 <> 'Pascal'
and PROF2 <> 'clipper'
And PROF2 <> 'Cobol'
And PROF2 <> 'Pascal'

--3. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy. 
Select DEVELOPIN, Avg(DCOST) as AVGDCOST, AVG(SCOST) as AVGSCOST, AVG(SCOST) as AVGPRICE 
From Software
Group by DEVELOPIN

--4. List the programmer names (from the programmer table) and No. Of Packages each has developed.
Select P.PNAME, count(developin) as Developin From PROGRAMMER P, Software S
where S.PNAME = P.PNAME
group by P.PNAME

--5. List each PROF with the number of Programmers having that PROF and the number of the packages in that PROF.
Select count(*),sum(scost*sold-dcost) "PROFIT" from software
where developin in (select distinct(prof1) from programmer
union
select distinct(PROF2) from programmer)
group by developin;

--6. How many packages are developed by the most experienced programmer form BDPS.
select count(*) as Countp from software s,programmer p
where p.pname=s.pname 
group by doj 
having min(doj)=(select min(doj) from studies st,programmer p, software s
where p.pname=s.pname and st.pname=p.pname and (institute='bdps'));

--7. How many packages were developed by the female programmers earning more than the highest paid male programmer? 
Select Count(DEVELOPIN) From Software s, PROGRAMMER p
where s.pname = p.pname and  gender = 'F' and Salary>(select max(salary) from PROGRAMMER where gender = 'M')

--8. How much does the person who developed the highest selling package earn and what course did HE/SHE undergo.
Select p.Pname, p.Salary,st.COURSE From PROGRAMMER p, STUDIES St
Where p.pname =st.pname and p.Salary = (Select max(Salary) from PROGRAMMER)

--9. In which institute does the person who developed the costliest package study. 
Select INSTITUTE From STUDIES st, Software s
where st.pname = s.pname and DCOST = (Select Max(DCOST) from Software)
group by INSTITUTE

--10. Display the names of the programmers who have not developed any packages.
Select PNAME From PROGRAMMER
where pname not in (Select Pname from Software)

--11. Display the details of the software that has developed in the language which is neither the first nor the second proficiency.
Select s.* From PROGRAMMER p, Software s
where p.pname=s.pname and p.PROF1<>s.DEVELOPIN and p.prof2<>s.DEVELOPIN

--12. Display the details of the software Developed by the male programmers Born before 1965 and female programmers born after 1975. 
Select s.*,Year(p.DOB), GENDER From Software s, PROGRAMMER p
where s.pname=p.pname and ((GENDER='M' AND YEAR(DOB)<1965) OR (GENDER='F' AND YEAR(DOB)>1975))

--13. Display the number of packages, No. of Copies Sold and sales value of each programmer institute wise.
Select p.INSTITUTE, count(s.DEVELOPIN) as Developin,count(s.sold) as Sold, Sum(s.sold*s.scost) as Sales From STUDIES p, Software s
where p.pname = s.PNAME
group by p.INSTITUTE

--14. Display the details of the Software Developed by the Male Programmers Earning More than 3000/-. 
Select * from PROGRAMMER p, Software s
where p.pname = s.pname and salary > 3000 and gender = 'M'

--15. Who are the Female Programmers earning more than the Highest Paid Male? 
Select Pname, Salary From PROGRAMMER
where SALARY >= (select max(salary) from PROGRAMMER
where gender ='M') And Gender = 'F'

--16. Who are the male programmers earning below the AVG salary of Female Programmers?
Select PNAME, GENDER From PROGRAMMER
where SALARY < (select avg(salary) from PROGRAMMER
where gender='F') And Gender='M'

--17. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package. 
Select DEVELOPIN, PNAME From Software
where SOLD in (Select max(SOLD) from Software group by pname)
union
Select DEVELOPIN, PNAME From Software
where SOLD in (Select min(SOLD) from Software group by pname)
 
--18. Display the names of the packages, which have sold less than the AVG number of copies. 
Select TITLE From Software
where sold < (select avg(sold) from Software)

--19. Which is the costliest package developed in PASCAL.
Select TITLE, DEVELOPIN From Software
Where DCOST = (select max(DCOST) from software
where DEVELOPIN = 'Pascal')

--20. How many copies of package that has the least difference between development and selling cost where sold. 
Select Title,SOLD as cost from Software
where title = (select title from Software
Where (DCOST-SCOST) = (Select min(DCOST-SCOST) from Software))

--21. Which language has used to develop the package, which has the highest sales amount?
Select * From ( Select *, Scost as Sell from Software) as x
where Sell = (select max(scost) from Software)

--22. Who Developed the Package that has sold the least number of copies? 
Select pname, TITLE, SOLD from Software
where SOLD = (select min(sold) from Software)

--23. Display the names of the courses whose fees are within 1000 (+ or -) of the 
--Average Fee, 
Select COURSE From Studies
where COURSE_FEE < (Select AVG(course_fee)+1000 from STUDIES) AND Course_fee > (Select AVG(Course_fee)-1000 from STUDIES)

--24. Display the name of the Institute and Course, which has below AVG course fee. 
Select institute, Course from STUDIES
where COURSE_FEE < (select avg(course_fee) from STUDIES);

--25. Which Institute conducts costliest course. 
Select Top 1 INSTITUTE, Max(course_fee) as Co From STUDIES
Group by INSTITUTE
order by CO desc;

--26. What is the Costliest course? 
Select * From STUDIES
where COURSE_FEE= (Select max(Course_fee) as costiest From STUDIES)