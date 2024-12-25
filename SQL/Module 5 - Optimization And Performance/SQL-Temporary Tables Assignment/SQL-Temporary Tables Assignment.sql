--1. Display the details of the software developed in DBASE by Male Programmers, who belong to the institute in which most number of Programmers studied.
create Table INST(ins varchar(20), CNT int)
Insert into INST
Select institute, count(pname) from STUDIES
Group by Institute
Select * from INST
Select distinct sw.*
From PROGRAMMER p, STUDIES s, Software sw, INST
Where DEVELOPIN = 'DBASE' and gender = 'M' and SW.pname = P.pname
			and INSTITUTE = INS and CNT = (Select max(CNT) from INST)

--2. In which language are most of the programmer’s proficient. 
create table Proff(prof varchar(20),cnt int)
insert into Proff(prof,cnt)
select Prof1,count(pname) from PROGRAMMER group by PROF1
union all
select Prof2,count(pname) from PROGRAMMER group by PROF2
Create table proff2(pro varchar(20),cn int)
Insert into proff2 (pro,cn)
Select prof,sum(cnt) from Proff
group by prof
Select * from Proff2
Where CN = (select max(CN) from Proff2)

--3. In which month did most number of programmers join? 
create table temp_month(monthP int,cnt int)
insert into temp_month
select month(DOJ), count(pname) from PROGRAMMER
group by Month(DOJ)
Select * from temp_month
Select Monthp,CNT from temp_month
where CNT in (select max(cnt) from temp_month)

--4. In which year was the most number of Programmers born.
Create Table temp(YOB int, CNT int)
Insert into temp
select year(DOB), count(pname) from PROGRAMMER
group by year(dob)
Select * from Temp
Select YOB,CNT from temp 
where cnt = (select max(cnt) from temp)

--5. Which programmer has developed the highest number of Packages? 
Select Pname
From Software
group by Pname
having Pname = (Select Max(Pname) from Software)

--6. Which language was used to develop the most number of Packages. 
Select top 1 DEVELOPIN, Count(TITLE) as countT From Software
group by DEVELOPIN
order by CountT desc

--7. Which course has below average number of Students? 
Create table AVGcount (CRS varchar(20), Cnt INT)
INSERT INTO AVGcount(CRS,CNT)
Select COURSE, count(PNAME) as Coursecount From STUDIES group by COURSE
Select CRS, CNT from AVGcount where Cnt <= (select avg(cnt) from AVGcount)
Select * from AVGcount

--8. Which course has been done by the most of the Students? 
Select Top 2 COURSE , Count(COURSE) as Courseno From STUDIES
group by COURSE
order by Courseno desc

--9. Which Institute has most number of Students? 
Select top 1 INSTITUTE, count(pname) as countno From STUDIES
group by INSTITUTE
order by Count(pname) desc

 --10. Who is the Above Programmer Referred in 50?
 -- No information of 50

--11. Display the names of the highest paid programmers for each Language. 
With CTC (Pname, Prof, Salary)
as 
(Select Pname, Prof1 as prof, Salary from PROGRAMMER
Union
Select Pname, Prof2, salary from PROGRAMMER)
Select P1.Pname, p1.prof, p1.Salary  from CTC as P1
left join CTC as p2 on p1.Prof=P2.Prof and p1.Salary < p2.Salary
where P2.pname is null;
