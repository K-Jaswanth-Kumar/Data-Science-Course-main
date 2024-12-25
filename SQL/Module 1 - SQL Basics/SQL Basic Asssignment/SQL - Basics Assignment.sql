/*1. Find out the selling cost AVG for packages developed in Pascal. */
SELECT AVG(SCOST) AS average_selling_cost FROM software WHERE DEVELOPIN = 'PASCAL';

/*2. Display Names, Ages of all Programmers*/
SELECT DATEDIFF(str_to_date(DOJ, '%m-%d-%Y'), str_to_date(DOB, '%m-%d-%Y')) / 365 AS age FROM programmer;

/*3. Display the Names of those who have done the DAP Course.*/
SELECT PNAME from STUDIES WHERE COURSE='DAP';

/*4. Display the Names and Date of Births of all Programmers Born in January.*/
SELECT PNAME, DOB from programmer where month(str_to_date(DOB, '%m-%d-%Y')) ='1';

/*5. Display the Details of the Software Developed by Ramesh.*/
Select *  FROM software WHERE PNAME='RAMESH';

/*6. Display the Details of Packages for which Development Cost have been recovered.*/
SELECT * FROM software WHERE SOLD*SCOST>DCOST;

/*7. Display the details of the Programmers Knowing C. */
SELECT * FROM software WHERE DEVELOPIN='C';

/*8. What are the Languages studied by Male Programmers?*/
SELECT * FROM software JOIN programmer on software.PNAME = programmer.PNAME where GENDER='M';

/*9. Display the details of the Programmers who joined before 1990.*/
SELECT * FROM programmer WHERE year(str_to_date(DOj, '%m-%d-%Y'))>1990;

/*10. Who are the authors of the Packages, which have recovered more than double the Development cost?*/
SELECT distinct PNAME FROM software WHERE 2*(SOLD*SCOST)>DCOST;
SELECT distinct PNAME FROM software WHERE 2*(SOLD*SCOST)>DCOST;