
use sakila;

-- In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure.

DELIMITER //
CREATE PROCEDURE Client_data()
BEGIN
  
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  END //
DELIMITER ;

call Client_data; 
-- Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.

DELIMITER //
CREATE PROCEDURE Client_data2(IN cat char(10))
BEGIN
  
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = cat
  group by first_name, last_name, email;
  
  END //
DELIMITER ;

call Client_data2("animation"); 

-- Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.

SELECT 
    A.name, COUNT(B.film_id) AS num_released
FROM
    category AS A
        JOIN
    film_category AS B USING (category_id)
GROUP BY A.name
;



DELIMITER //
CREATE PROCEDURE filtere_number_of_movies(IN min_num INT)
BEGIN
SELECT 
    A.name, COUNT(B.film_id) AS num_released
FROM
    category AS A
        JOIN
    film_category AS B USING (category_id)
GROUP BY A.name
HAVING num_released > min_num
;
END //
DELIMITER ;

CALL filtere_number_of_movies(60);
