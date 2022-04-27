#1 Select all the actors with the first name "Scarlett".

SELECT first_name, last_name
FROM actor
WHERE first_name = 'Scarlett';

#2 How many films (movies) are available for rent and how many films have been rented?

SELECT COUNT(DISTINCT inventory_id), COUNT(DISTINCT rental_id)
FROM rental;

#3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT MAX(length), MIN(length)
FROM film;

#4 What's the average movie duration expressed in format (hours, minutes)?

# SELECT AVG(length), sec_to_time(AVG(length)*60)  as length_hm. another way to do it
SELECT floor(avg(length) /60) as hours, round(avg(length) % 60) as minutes
FROM film;

#5 How many distinct (different) actors' last names are there?

SELECT COUNT(DISTINCT last_name)
FROM actor;

#6 Since how many days has the company been operating (check DATEDIFF() function)?

SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) as company_life
FROM rental;

#7 Show rental info with additional columns month and weekday. Get 20 results.

SELECT rental_date, DATE_FORMAT(rental_date, '%M') as month, DATE_FORMAT(rental_date, '%W') as weekday
FROM rental
LIMIT 20;

#8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT rental_date, DATE_FORMAT(rental_date, '%M') as month, DATE_FORMAT(rental_date, '%W') as weekday, CASE DATE_FORMAT(rental_date, '%W')
WHEN ('Monday') THEN 'workday'
WHEN ('Tuesday') THEN 'workday'
WHEN ('Wednesday') THEN 'workday'
WHEN ('Thursday') THEN 'workday'
WHEN ('Friday') THEN 'workday'
ELSE 'weekend'
END AS day_type
FROM rental
LIMIT 20; 

# Another way to do it would have been:

select *, case
when date_format(rental_date, ‘%W’)
in (‘Saturday’, ‘Sunday’) then ‘weekend’
else ‘workday’ end as day_type
from rental;

#9 How many rentals were in the last month of activity?

SELECT *
FROM rental
ORDER BY rental_date DESC;

SELECT DATE_FORMAT(MAX(rental_date),'%M %Y') #last_month
FROM rental;

SELECT COUNT(rental_id) 
FROM rental
WHERE DATE_FORMAT(rental_date,'%M %Y') = 'February 2006';

# Another way to do it:

select date(max(rental_date))- INTERVAL 30 DAY, date(max(rental_date))
from rental;

select count(*)
from rental
where date(rental_date) between date('2006-01-15') and date('2006-02-14');

# Using a subquery is the best way to do it:

SELECT COUNT(rental_id) 
FROM rental
WHERE DATE_FORMAT(rental_date,'%M %Y') = (SELECT DATE_FORMAT(MAX(rental_date),'%M %Y') #last_month
FROM rental);