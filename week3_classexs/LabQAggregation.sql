# Lab: SQL queries with aggregation

#1 Activity: Using the rental table, find out how many rentals were processed by each employee.

SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id;

#2 Activity: Using the film table, find out how many films were released.

SELECT COUNT(film_id)
FROM film;

#3 Activity: Using the film table, find out how many films there are of each rating. Sort the results in descending order of the number of films.

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

#4 Activity: Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, AVG(length)
FROM film
GROUP BY rating
HAVING AVG(length) > 120;