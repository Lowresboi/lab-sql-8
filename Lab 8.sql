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
SELECT c.name AS category, COUNT(fc.film_id) AS number_films_category
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- 4. Actor with the most appearances
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS number_films_appeared
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY num_films_appeared DESC
LIMIT 1;

-- 5. Most active customer
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS customer_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY customer_rentals DESC
LIMIT 1;
