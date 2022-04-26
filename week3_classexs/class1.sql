SELECT account_id as id, amount as am, balance as bal, amount-balance as test
FROM trans
ORDER BY am DESC
LIMIT 10;

#Count the number of records in a table
SELECT COUNT(*)
FROM trans;

SELECT COUNT(DISTINCT account_id)
FROM trans;

SELECT DISTINCT operation 
FROM trans;

#1 Activity: The select statement is used as a print command in SQL. Use the select statement to print "Hello World".

SELECT "Hello world";

#2 Activity: Use the select statement to perform a simple mathematical calculation to add two numbers.

SELECT duration + amount
FROM loan;

#3 Activity: Use an appropriate select statement to retrieve a list of unique card types from the bank database, table card. (Hint: You can use the DISTINCT function here.)

SELECT DISTINCT type
FROM card;

#4+Bonus Activity: Get a list of all the district names in the bank database. A suggestion is to use the files_for_activities/case_study_extended here to work out which column is required here because we are looking for the names of places, not just the IDs. You should have 77 rows.

SELECT A2 as district_name, A3 as region_name
FROM district
LIMIT 30;

#5 Activity: Get all the types of the card as type_of_card and the issue date as issue_date from card client and alias the table as bc.

SELECT DISTINCT type as type_of_card, issued as issue_date
FROM card as bc;

# Operators and logical clauses
# + - * / == <= >= != (this last one is the same as <>)

# From the bank loan, get loan id and amound in thousands

SELECT loan_id, amount/1000 as amountk 
FROM loan;

#Only loans where status is A or B

SELECT *
FROM loan
WHERE status = 'A' OR status = 'B' ; #it also works if we use: status IN ('A','B')

SELECT *
FROM loan
WHERE status <> 'A' AND status <> 'B' ; #not any of those values

#let's add an AND to our WHERE
#all loans with status B and amount > 100000

SELECT *
FROM loan
WHERE status = 'B' AND amount > 100000
ORDER BY amount DESC;

# duration is less or equal to 24 months

SELECT *
FROM loan
WHERE status = 'B' AND amount > 100000 AND duration <= 24
ORDER BY duration DESC;

# the biggest loan

SELECT MAX(amount),MIN(amount)
FROM loan;

SELECT round(AVG(amount),2), CEILING(AVG(amount)) 
FROM bank.order;

# Useful string functions 
# lower, upper, length, concat, left, right, lttrim, rttrim

SELECT A2, LEFT(A2,5)
FROM district;

#1 Activity: Select districts and salaries (from the district table) where salary is greater than 10000. Return columns as district_name and average_salary. 

SELECT A2 as district_name, A11 as avg_salary
FROM district
WHERE A11  > 10000;

#2 Activity: Select those loans whose contracts finished and were not paid. Hint: You should be looking at the loan column and you will need the extended case study information to tell you which value of status is required.

SELECT loan_id, status
FROM loan
WHERE status = 'B';

#3 Activity: Select cards of type junior. Return just the first 10 in your query.

SELECT card_id, type
FROM card
WHERE type = 'junior'
LIMIT 10;

#4 Activity: Select those loans whose contract is finished and not paid back. Return the debt value from the status you identified in the last activity, together with loan id and account id.

SELECT loan_id, account_id, amount-payments as debt
FROM loan
WHERE status = 'B';

#5 Activity: Calculate the urban population for all districts. Hint: You are looking for the number of inhabitants and the % of urban inhabitants in each district. Return columns as district_name and urban_population.

SELECT round(A4*A10)/100 as urban_population, A2 as districtname 
FROM district;

#6 Activity: On the previous query result - rerun it but filter out districts where the rural population is greater than 50%.

SELECT round(A4*A10)/100 as urban_population, A2 as districtname, A10 
FROM district
WHERE A10 > 50;

#Dates
#convert(), substring_index(), date_format()

SELECT *, convert(account.date, date) as mydate
FROM bank.account

#How to extract gender from a weird date and gender format:
SELECT *, IF RIGHT(LEFT(birth_number,4),2)>12) THEN 'female' ELSE 'male' end) as gender
FROM client;

SELECT *, CONVERT(substring_index(issued, ' ',1), date) as new_date #we are getting the first part of the date until the space
FROM bank.card;

SELECT *, date_format(convert(loan.date,date), '%y/%m/%d') as newdate
FROM bank.loan;

# Nulls
#isnull() or is not null()

SELECT isnull(loan.loan_id)
FROM bank.loan;

# Case
#E.g. Replace 'A' status when appears by 'good' and 'B' as 'warning'

SELECT *, CASE 
WHEN status = 'A' THEN 'good'
WHEN status = 'B' THEN 'warning'
END AS alter_name
FROM loan;
#it also works as:
SELECT *, CASE status
WHEN 'A' THEN 'good'
WHEN 'B' THEN 'warning'
END AS alter_name
FROM loan;




