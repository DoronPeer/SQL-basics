--2. 
SELECT 
distinct Extended_step
from salary_range_by_job_classification;

--3.
Select 
min(Biweekly_high_Rate)
From salary_range_by_job_classification
where biweekly_high_rate <> '$0.00'

--4.
SELECT 
Max(Biweekly_high_Rate) 
From salary_range_by_job_classification;

--5.
Select
job_code,
pay_type
From salary_range_by_job_classification
where job_code like '03%';

--6.
Select
grade, eff_date, sal_end_date 
From salary_range_by_job_classification
where grade like 'Q90H0';

--7.
Select
biweekly_low_rate
From salary_range_by_job_classification
order by biweekly_low_rate asc


--8.
select Job_Code, Step
From salary_range_by_job_classification
where Job_Code between '0110' and '0400' ;

--9.
select Job_Code, Biweekly_High_Rate,
Biweekly_Low_Rate
From salary_range_by_job_classification
where Job_Code like '0170';

--10.
Select
Extended_step,
Pay_Type
From salary_range_by_job_classification
Where Pay_Type in ('M', 'H', 'D');

--11.
SELECT 
Union_code,
SetID,
Step
from salary_range_by_job_classification
where Union_code = 990 and (SetID = 'SFMTA' or SetID = 'COMMN')


--week2

--1.
select trackId, milliseconds
from tracks
where milliseconds  > '5000000' ;

--2.
select count(total) 
from Invoices
where total between '5.00' and '15.00';

--3.
select FirstName,
LastName,
Company
from customers
where state in ('RJ', 'DF', 'AB', 'BC', 'CA', 'WA', 'NY');

--4.
select 
invoiceId,
invoiceDate

from invoices
where customerId in ('56', '58') and total between '1.00' and '5.00';

--5.
select name 
from tracks
where name like 'all%';

--6.
select email
from customers
where email like 'j%gmail.com';

--7.
select 
total
from invoices
where billingcity in ('Brasília', 'Edmonton', 'Vancouver')
order by invoiceId DESC;

--8.
SELECT customerID, COUNT(INVOICEID) as "number of orders" FROM Invoices

GROUP BY customerID

ORDER BY "number of orders" DESC;

--week 3 priactice

--1. How many albums does the artist Led Zeppelin have?
select ar.artistid,
count(al.albumid) as number

from artists as ar inner join albums as al on al.artistid = ar.artistid
where ar.name = "Led Zeppelin"

--2. Create a list of album titles and the unit prices for the artist "Audioslave"
select ar.name,
t.unitprice
from (( albums as al inner join artists as ar ON ar.Artistid = al.Artistid)  
  inner join tracks as t on al.albumid = t.albumid)
  where ar.name = "Audioslave"

--3. Find the first and last name of any customer who does not have an invoice. Are there any customers returned from the query?

select c.firstname,
c.lastname,
c.customerid
from customers as c left join invoices as i 
on c.customerid = i.customerid
where invoiceid is null

--4. Find the total price for each album.
SELECT t.Title, SUM(p.UnitPrice)
FROM albums as t INNER JOIN tracks as p ON t.Albumid = p.Albumid
where t.title = "Big Ones"
group by t.Albumid

--5.How many records are created when you apply a Cartesian join to the invoice and invoice items table?
 SELECT a.invoiceid
FROM invoices as a CROSS JOIN invoice_items as b;

--quiz

--1.Using a subquery, find the names of all the tracks for the album "Californication".
select name
from tracks 
where albumid in (
select albumid 
from albums where title =  "Californication")

--2. Find the total number of invoices for each customer along with the customer's full name, city and email.
select c.firstname,
c.lastname,
c.city,
c.email,
COUNT(i.invoiceid) as nubmer
from invoices as i, customers as c
where i.customerid = c.customerid
group by i.customerid

--3. Retrieve the track name, album, artistID, and trackID for all the albums.
select t.name,
t.trackid,
a.title,
a.artistid
from albums as a left join tracks as t on a.albumid = t.albumid

--4. Retrieve a list with the managers last name, and the last name of the employees who report to him or her.
select m.lastname as manager,
e.lastname as employee
from employees as e, employees as m
where m.employeeid = e.reportsto

--5. Find the name and ID of the artists who do not have albums.
select a.artistid,
a.name
from artists as a left join albums as i 
on a.artistid = i.artistid
where title is null

--6. Use a UNION to create a list of all the employee's and customer's first names and last names ordered by the last name in descending order.
select lastname,
firstname
from employees
union
select lastname,
firstname
from customers
order by lastname desc

--7. See if there are any customers who have a different city listed in their billing city versus their customer city.
select c.city,
i.billingcity
from customers as c, invoices as i 
on c.customerid = i.customerid
where c.city != i.billingcity



--week 4

--1. Pull a list of customer ids with the customer’s full name, and address, along with combining their city and country together. Be sure to make a space in between these two and make it UPPER CASE. (e.g. LOS ANGELES USA)
select customerid, 
firstname || " " ||  lastname as "full name",
address,
upper( city || " " || country) as address
from customers

--2. Create a new employee user id by combining the first 4 letters of the employee’s first name with the first 2 letters of the employee’s last name. Make the new field lower case and pull each individual step to show your work.
select employeeid,
lastname,
firstname,
lower(substr(firstname, 1,4) || substr(lastname, 1,2)) as "user id"
from employees

--3.Show a list of employees who have worked for the company for 15 or more years using the current date function. Sort by lastname ascending.
select employeeid,
lastname,
firstname,
hiredate,
(date('now') - hiredate) as "time"
from employees
where "time" > 14
order by lastname asc

--4. Find the cities with the most customers and rank in descending order.
select city,
count(customerid) as num
from customers
group by city
order by num desc

--5. Create a new customer invoice id by combining a customer’s invoice id with their first and last name while ordering your query in the following order: firstname, lastname, and invoiceID.
SELECT c.firstname,
c.lastname,
i.InvoiceId,
c.firstname || c.lastname || i.InvoiceId AS NewID
FROM Customers c INNER JOIN Invoices i
ON c.CustomerID = i.CustomerID
WHERE NewId like 'AstridGruber%'
ORDER BY c.firstname,c.lastname, i.InvoiceId