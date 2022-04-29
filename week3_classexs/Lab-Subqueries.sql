# LAB: Subqueries

#1 Activity: How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

#2 Activity: List all films whose length is longer than the average of all the films.

SELECT f.title, f.length
FROM film f
WHERE length > 
(SELECT AVG(length)
FROM film);

#3 ACtivity: Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name
FROM actor 
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id in
(SELECT film_id FROM film WHERE title = 'Alone Trip'));

#4 Activity: Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title
FROM film 
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id =
(SELECT category_id FROM category WHERE name = 'Family'));

#5 Activity: Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

# With JOIN:
SELECT c.first_name, c.last_name, c.email, country
FROM customer c
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country cn USING (country_id)
WHERE country = 'Canada';

# With subqueries:

SELECT first_name, last_name, email
FROM customer 
WHERE address_id IN
(SELECT address_id FROM address WHERE city_id IN 
(SELECT city_id FROM city WHERE country_id IN
(SELECT country_id FROM country WHERE country = 'Canada')));

#6 Activity: Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT title
FROM film 
JOIN film_actor USING (film_id)
WHERE actor_id = 
(SELECT actor_id
FROM
(SELECT actor_id, COUNT(film_id) as count
FROM film_actor
WHERE film_id IN
(SELECT film_id FROM film)
GROUP BY actor_id
ORDER BY count DESC) t1
LIMIT 1);

# 7 Activity: Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT title
FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE customer_id = 
(SELECT customer_id
FROM 
(SELECT customer_id, SUM(amount) as profit
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer)
GROUP BY customer_id
ORDER BY profit DESC
Limit 1) t1);

# 8 Activity: Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

SELECT customer_id as client_id, SUM(amount) as total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) >
(SELECT AVG(profit)
FROM
(SELECT customer_id, SUM(amount) as profit
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer)
GROUP BY customer_id) t1);

