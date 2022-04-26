# SAKILA LAB

#1 Get all the data from tables actor, film and customer.
SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM customer;

#2 Get film titles.
SELECT title
FROM film;

#3 Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.
SELECT DISTINCT name as language
FROM language;

#4 Find out how many stores does the company have?
SELECT COUNT(DISTINCT STORE_ID)
FROM store;

#5 Find out how many employees staff does the company have?
SELECT COUNT(DISTINCT staff_id)
FROM staff;

#6 Return a list of employee first names only?
SELECT first_name
FROM staff;
