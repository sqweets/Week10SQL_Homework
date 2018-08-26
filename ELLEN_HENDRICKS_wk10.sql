# 1a
SELECT first_name, last_name FROM actor;

# 1b
SELECT UPPER(first_name), UPPER(last_name), CONCAT(first_name, " ", last_name) AS "Actor Name" FROM actor;

# 2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'JOE';

# 2b
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%GEN%";

# 2c
SELECT actor_id, last_name, first_name FROM actor WHERE last_name LIKE "%LI%";

# 2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

# 3a
ALTER TABLE actor ADD COLUMN description BLOB AFTER last_name;

# 3b
ALTER TABLE actor DROP COLUMN description;

# 4a
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

# 4b
SELECT last_name, COUNT(last_name) AS cnt FROM actor GROUP BY last_name HAVING cnt > 1;

# 4c
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

# 4d
UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

# 5a
SHOW CREATE TABLE address;

# 6a
SELECT staff.first_name, staff.last_name, address.address FROM staff
INNER JOIN address
ON staff.address_id = address.address_id;

# 6b. (not working)
SELECT staff.first_name, staff.last_name, 
(SELECT SUM(payment.amount) FROM payment WHERE Month(payment.payment_date)='08' && YEAR(payment.payment_date)='2005' AND staff.staff_id = payment.staff_id) AS 'Total'
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;

# 6c (not working)
SELECT film.title, film.film_id, film_actor.film_id, 
(SELECT COUNT(*) FROM film_actor WHERE film.film_id = film_actor.film_id) AS 'Actor Count'
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

# 6d
SELECT film.title, COUNT(inventory.film_id) FROM inventory
INNER JOIN film
ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible';

# 6e
SELECT customer.first_name, customer.last_name,  SUM(payment.amount) AS Total
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name ASC;

# 7a
SELECT title FROM film
    WHERE language_id in
        (SELECT language_id
        FROM language
        WHERE name = "English" )
    AND (title LIKE "K%") OR (title LIKE "Q%");
        
# 7b
SELECT first_name, last_name
FROM actor
    WHERE actor_id IN
        (SELECT actor_id 
        FROM film_actor 
        WHERE film_id IN 
            (SELECT film_id
            FROM film 
            WHERE title = 'ALONE TRIP'
        ));

# 7c
SELECT first_name, last_name, email
FROM customer
    INNER JOIN address
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id
    WHERE country.country_id = 20;
                
# 7d
SELECT title
FROM film
    WHERE film_id IN
        (SELECT film_id 
        FROM film_category 
        WHERE category_id IN 
            (SELECT category_id
            FROM category 
            WHERE name = 'Family'));

# 7e
SELECT title,
(SELECT COUNT(*) 
FROM rental 
WHERE rental.inventory_id IN
    (SELECT inventory_id
    FROM inventory
    WHERE inventory.film_id = film.film_id)) AS Rentals
FROM film
ORDER BY Rentals DESC;

# 7f
SELECT store_id,
(SELECT SUM(amount) 
FROM payment 
WHERE customer_id IN
    (SELECT customer_id
    FROM customer
    WHERE customer.store_id = store.store_id)) AS 'Business in Dollars'
FROM store;

# 7g
SELECT store.store_id, city.city, country.country
FROM store
    INNER JOIN address
        ON store.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id;

# 7h
SELECT category.name AS Genre, SUM(payment.amount) AS Revenue
FROM film
    INNER JOIN inventory
        ON film.film_id = inventory.film_id
    INNER JOIN rental
        ON inventory.inventory_id = rental.inventory_id
    INNER JOIN payment
        ON rental.rental_id = payment.rental_id
    INNER JOIN film_category
        ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id
    GROUP BY category.name
    ORDER BY revenue DESC LIMIT 5;

# 8a
CREATE VIEW revenue_by_genre AS
SELECT category.name AS Genre, SUM(payment.amount) AS Revenue
FROM film
    INNER JOIN inventory
        ON film.film_id = inventory.film_id
    INNER JOIN rental
        ON inventory.inventory_id = rental.inventory_id
    INNER JOIN payment
        ON rental.rental_id = payment.rental_id
    INNER JOIN film_category
        ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id
    GROUP BY category.name
    ORDER BY revenue DESC LIMIT 5;

# 8b
# I'm not sure what the question is asking.  If it's about what an executive would want to see, well
# I would think they would want it updated every x hours or days, etc, so they can act on what the data is
# telling them.  I would also think things like # of movies in inventory for the top genres, the rental prices for those
# movies, how frequently they are rented, etc. would be useful.

# 8c
DROP VIEW IF EXISTS revenue_by_genre;



