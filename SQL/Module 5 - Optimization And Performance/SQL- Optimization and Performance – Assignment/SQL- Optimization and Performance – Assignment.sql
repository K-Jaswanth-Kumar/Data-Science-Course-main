--1. Display the names of the highest paid programmers for each Language. 
With CTC (Pname, Prof, Salary)
as 
(Select Pname, Prof1 as prof, Salary from PROGRAMMER
Union
Select Pname, Prof2, salary from PROGRAMMER)
Select P1.Pname, p1.prof, p1.Salary from CTC as P1
left join CTC as p2 on p1.Prof=P2.Prof and p1.Salary < p2.Salary
where P2.pname is null;

--2. Display the details of those who are drawing the same salary. 
Select * From PROGRAMMER
where SALARY in (Select SALARY from PROGRAMMER
				group by SALARY
				having count(SALARY)>1);

--3. Who are the programmers who joined on the same day? 
Select A.Pname,A.DOJ From PROGRAMMER A, PROGRAMMER B
where a.doj = b.doj and A.pname<>b.pname

--4. Who are the programmers who have the same Prof2? 
Select Distinct(a.Pname), a. PROF2 From PROGRAMMER a, PROGRAMMER b
where a.PROF1 = b.PROF2 and a.pname <> b.pname

--5. How many packages were developed by the person who developed the cheapest package, where did HE/SHE study?
Select Count(DEVELOPIN) as package From PROGRAMMER s, Software P
where S.pname = p.pname 
Group by DEVELOPIN
having min(dcost)=(select min(dcost) from software)