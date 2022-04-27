#SQL class 2

# ORDER BY

USE bank;
SELECT *
FROM trans
WHERE k_symbol='UROK' and operation <>' '
ORDER BY date DESC, amount DESC; #we are creating a partition

# LIKE and '%'

SELECT * 
FROM district
WHERE A2 LIKE '%u%' or A2 LIKE 'U%';

SELECT A2 from district
WHERE A2 REGEXP '[uxy]'; # Looking for u, x or y in any place. This regex expression is useful if we want that the character we are looking for is in any position

SELECT * 
FROM district
WHERE A2 LIKE '_____'; #5 underscores will return words with 5 characters

#1 Activity: Get transactions in the first 15 days of 1993.

SELECT trans_id
FROM trans
WHERE trans.date BETWEEN '930101' and '930115';

#2 Activity: Find the different values from the field A2 that start with the letter 'M'.

SELECT A2 
FROM district
WHERE A2 LIKE 'M%';

#3 Activity: Find the different values from the field A2 that end with the letter 'M'.

SELECT A2 
FROM district
WHERE A2 LIKE '%M';

# GROUP BY: to aggregate data by something
SELECT SUM(amount), duration, status 
FROM loan
GROUP BY duration, status;

SELECT account_id, COUNT(order_id), round(sum(amount),2)
FROM bank.order
GROUP BY account_id
HAVING count(order_id) > 1 #HAVING is used instead of WHERE for GROUP BY queries to refer to aggegated variables (we can still use WHERE to non-aggregated ones)
ORDER BY count(order_id) DESC;

#1 Activity: Get the total rental revenue using the column amount from table payment. Display it as Total_revenue.

use sakila;

SELECT SUM(amount) as Total_revenue
FROM payment;

#2 Activity: Get the total rental revenue by customer_id sorted by total benefit in descending order.

SELECT customer_id, SUM(amount) as revenue
FROM payment
GROUP BY customer_id
ORDER BY revenue DESC;

#We have selected the SQL mode: less flexible, more like the real SQL:
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY';
SELECT @@GLOBAL.sql_mode;

# Window functions (when we want to do an aggregation but we don't want a summary table)

SELECT *, AVG(amount) OVER() as avg_amount
FROM loan
WHERE duration = 12;

# Partition by (does the same as the previous one but for each of the unique values of the partition)
#e.g. duration:

SELECT *, round(AVG(amount) OVER(partition by duration),0) as avgbydur
FROM loan;

# The same but with 2 variabes to do the partition:
SELECT *, round(AVG(amount) OVER(partition by status, duration),0) as avgbystatdur
FROM loan;

#We can also include ORDER BY inside the partition:
SELECT account_id, date, amount, round(sum(amount) OVER(partition by account_id ORDER BY date),0) as running_sum
FROM trans
WHERE account_id in (1,2,3);

#1 Activity: Create a query to show for each rating the average movie length (displayed as Mean_length). Sort the results in descending order of Mean_length.

SELECT rating, AVG(length) as Mean_length
FROM film
GROUP BY rating
ORDER BY Mean_length;

#2 Activity: Create a query to show for each movie the following data (in this order):rating,title,length,mean length by rating displayed as Mean_length_by_rating,ranking displayed as Ranking (showing from the longest to the shortest movie within the same rating).This means sorting the results by rating and descending order of movie length.

SELECT rating, title, length, AVG(length) OVER (partition by rating) as Mean_length_by_rating, rank() OVER(partition by rating ORDER BY length DESC) as ranking
FROM film
