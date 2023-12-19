use sakila;

-- 1. Rank films by length
SELECT title, length, RANK() OVER (ORDER BY length DESC) AS ranking_lenght
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 2. Rank films by length within the rating category
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS ranking_category
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 3. Number of films for each category
SELECT name AS category, COUNT(film_id) AS number_films_category
FROM category AS a
JOIN film_category AS b
ON a.category_id = b.category_id
GROUP BY name;

-- 4. Actor with the most appearances
SELECT a.actor_id, a.first_name, a.last_name, COUNT(film_id) AS num_films_appeared
FROM actor AS a
JOIN film_actor AS b 
ON a.actor_id = b.actor_id
GROUP BY actor_id, first_name, last_name
ORDER BY num_films_appeared
DESC
LIMIT 1;

-- 5. Most active customer
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS customer_rentals
FROM customer AS c
JOIN rental AS r 
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY customer_rentals 
DESC
LIMIT 1;
