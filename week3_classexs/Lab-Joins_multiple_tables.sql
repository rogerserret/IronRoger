# LAB: SQL, Joins on multiple tables

#1 Activity: Write a query to display for each store its store ID, city and country.

use Sakila;
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country co USING (country_id);

#2 Activity: Write a query to display how much benefit amount, in dollars, each store brought in.

SELECT s.store_id, SUM(p.amount) as amount
FROM store s
JOIN customer c USING (store_id)
JOIN payment p USING (customer_id)
GROUP BY store_id;

#3 Activity: What is the average running time of films by category?

SELECT c.name, AVG(f.length) as avg_length
FROM category c
JOIN film_category fc USING (category_id)
JOIN film f USING (film_id)
GROUP BY c.name;

#4 Activity: Which film categories are longest on average?

SELECT c.name, AVG(f.length) as avg_length
FROM category c
JOIN film_category fc USING (category_id)
JOIN film f USING (film_id)
GROUP BY c.name
ORDER BY avg_length DESC;

#5 Activity: Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_id) as noofrent
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
GROUP BY f.title
ORDER BY noofrent DESC;
