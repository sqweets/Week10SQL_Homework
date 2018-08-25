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
UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO';

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

# 6e (not working)


# 7a (not working)
SELECT title, language_id
FROM film
WHERE language_id IN (SELECT langusge_id FROM language)
WHERE title IN
(SELECT title FROM film WHERE (title LIKE 'K%' OR title LIKE 'Q%)'))
WHERE language_id IN
(SELECT language_id, `name` FROM `language` WHERE `name` = 'English');


AND WHERE film.language_id IN (SELECT language.language_id, `name` from `language` WHERE name = 'English');


        
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
    WHERE address_id IN
        (SELECT address_id 
        FROM address 
        WHERE city_id IN 
            (SELECT city_id
            FROM city 
            WHERE country_id IN
                (SELECT country_id
                FROM country 
                WHERE country = 'Canada')));
                
# 7d
SELECT `title`
FROM film
    WHERE film_id IN
        (SELECT film_id 
        FROM film_category 
        WHERE category_id IN 
            (SELECT category_id
            FROM category 
            WHERE name = 'Family'));



