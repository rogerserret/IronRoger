# JOIN

use bank;

# How many clients per district

SELECT A2 as districtname, A3 as regionname, count(distinct client_id) as noofclients
FROM district 
LEFT JOIN client ON district.A1 = client.district_id #we use a left join because we want to see all district regardless if they have clients or not
GROUP BY A2, A3;

# How many loans and avg(amount) per account?

SELECT a.account_id, a.date, count(l.loan_id), avg(l.amount)
FROM loan l #left table
INNER JOIN account a #right table
USING (account_id) #join clause (we can use USING because the linking column has the same name)
GROUP BY a.account_id, a.date; #aggregation process

#1 Activity: Get a list of districts ordered by the number of clients (descending order). Name the columns as: District_name and Number_of_clients respectively.

SELECT district.A2 as districts, COUNT(client.client_id) as clients
FROM district
JOIN client ON district.A1 = client.district_id
GROUP BY district.A2
ORDER BY clients DESC;

#2 Activity: Get a list of regions ordered by the number of clients (descending order). Name the columns as: Region_name and Number_of_clients respectively.

SELECT district.A3 as regions, COUNT(client.client_id) as clients
FROM district
JOIN client ON district.A1 = client.district_id
GROUP BY district.A3
ORDER BY clients DESC;

#3 Activity: Get the number of accounts opened by district and year. Name the columns as: District_name, Year and Accounts_opened. Order the results by District_name and Year.

SELECT district.A2 as district_name, DATE_FORMAT(account.date, '%Y') as year, COUNT(account_id) as accounts_opened
FROM district
JOIN account ON district.A1 = account.district_id
GROUP BY district.A2, DATE_FORMAT(account.date, '%Y')
ORDER BY district_name, year;

#4 Activity: Extend the query below and list district_name, client_id, and account_id for those clients who are the owner of the account. Order the results by district_name:

select da.A2 as district_name, c.client_id, account.account_id 
from bank.disp as d
join bank.client as c using(client_id)
join bank.district as da on da.A1 = c.district_id
join account on account.district_id = da.A1
ORDER BY district_name;

# An example where left and right matters:

SELECT *
FROM account
LEFT JOIN loan # We can see that we have for example an account_id 2 that has no loans and that's why we see null values
USING (account_id);

# Joining more than 2 tables:
# How many loans per region?

SELECT d.A3 as region, count(l.loan_id) as noofloans, count(a.account_id) as noofaccounts
FROM loan l
INNER JOIN account a
USING (account_id)
INNER JOIN district d
ON a.district_id = d.A1
GROUP BY A3;

#DDL (defintion) and DML (manipulation)
#Create, alter, drop,truncate, rename, update

DROP database IF EXISTS booksauthors; #remove data base
CREATE database booksauthors; #create a new data base
use booksauthors;

DROP table IF EXISTS authors;
CREATE table authors #create tables
(author_id INT AUTO_INCREMENT NOT NULL, 
authorname VARCHAR(30) DEFAULT NULL, 
country VARCHAR(30) DEFAULT NULL, 
PRIMARY KEY (author_id));

DROP table IF EXISTS books;
CREATE table books (book_id INT AUTO_INCREMENT NOT NULL, 
author_id INT NOT NULL,
bookname VARCHAR(50) DEFAULT NULL,
PRIMARY KEY (book_id),
KEY idx_fk_author_id(author_id),
CONSTRAINT fk_author_id FOREIGN KEY (author_id)
REFERENCES authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE);

INSERT INTO authors(authorname, country)  #Insert data in the tables
VALUES('Sean Ellis','USA'), ('Eric Ries', 'USA'),('Art Spiegelman','USA'), ('Geoffrey A. Moore','USA'), ('Donald Miller','USA');

#UPDATE authors set country='UK' where author_id in (2,4,5) if needed to make a change

INSERT INTO books(author_id,bookname)  #Inser data in the tables
VALUES(1,"Hacking Growth: How Today's Fastest-Growing Companies Drive Breakout Success"), (2, 'The lean startup'),(3,'Maus'), (4,'Crossing the chasm'), (5,'Building a story brand');

# Let's join both tables:
SELECT * 
FROM authors
JOIN books USING(author_id);

# VIEWS
# Views are temporary table that are not stored, they are just precreated queries that are shown when activated, but do not phisically exist.
# CREATE VIEW <name> AS
# SELECT...; (a normal query)

use bank;
CREATE VIEW clients_loans_combo AS
SELECT c.client_id, c.district_id, l.loan_id, l.status, l.amount, l.duration, l.payments, l.date as loan_date
FROM client c
JOIN disp dp USING (client_id)
JOIN account a USING (account_id)
JOIN loan l USING (account_id)
WHERE dp.type = 'OWNER';

#SUBQUERY (query inside a query)

SELECT *
FROM loan
WHERE amount >
	(SELECT AVG(amount) FROM LOAN) # In this case we only get one value
;

# If we get a list from a subquery, then we use IN. 
#If we get a table then the subquery needs an alias:
# select s1.firstcolumn from
# (select from...) s1 

#1 Activity: Find out the average of the number of transactions by account.

SELECT AVG(ctrans)
FROM
(SELECT account_id, COUNT(trans_id) as ctrans
FROM trans
GROUP BY account_id) t1 
;

#as a view: first we create the inner query and save it as a view: create view t1 as + inner query
#then: select avg(ctrans) from t1;

#2 Activity: Get a list of accounts from Central Bohemia using a subquery.

#with subquery:
SELECT account_id
FROM account
WHERE district_id IN
(SELECT A1
FROM district
WHERE A3 = 'Central Bohemia') #it's a list, we don't need an alias
; 

#as a JOIN:
SELECT a.account_id
FROM account a
JOIN district d ON a.district_id = d.A1
WHERE d.A3 = 'Central Bohemia';

#The subquery is way more efficient than the JOIN.

# CTE's (Common Table Expressions)
# We use them when we want to join X + Y but X doesn’t exist

#Example: get the total amount for each account and any account info in trans table
# then draw the table to get information
# use that table to join another table

#WITH cte_trans as
#(SELECT...);

#example:
WITH cte_loan as ( select * from loan)
select loan_id from cte_loan
where status = 'B';
