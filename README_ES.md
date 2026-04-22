# Pr-ctica-Data-An-lisis-V3-Unidad-4-SQL

## Descripción del proyecto
Este proyecto consiste en un análisis de una base de datos sobre alquiler de películas proporcionada durante el curso, usando SQL para resolver una serie de consultas en el enunciado.
La base de datos contiene información relacionada con películas, categorías, inventario, clientes, alquileres y pagos. A partir de estas tablas se han realizado diferentes consultas para analizar el comportamiento de los clientes y el uso del catálogo de películas.

## Objetivo del análisis
El objetivo principal del análisis es responder a distintas preguntas relacionadas con el sistema de alquiler de películas, entre ellas:

- Analizar el número de alquileres realizados por los clientes.
- Identificar películas y categorías más relevantes.
- Estudiar patrones de alquiler y frecuencia de uso del inventario.
- Extraer información agregada a partir de los datos de alquileres.

## Pasos seguidos durante el proyecto
1. Exploración inicial de las tablas de la base de datos para comprender su estructura.
2. Identificación de las claves primarias y foráneas y de las relaciones entre tablas.
3. Revisión del esquema de la base de datos proporcionado.
4. Análisis de los enunciados para definir el enfoque de cada consulta.
5. Desarrollo de las consultas SQL utilizando JOINs, subconsultas y funciones de agregación.
6. Comprobación y validación de los resultados obtenidos.

## Enfoque de las consultas
Para la resolución de los ejercicios se han utilizado distintas técnicas de SQL, entre ellas:

- JOINs entre tablas como `film`, `inventory`, `rental`, `customer` y `category`.
- Funciones de agregación como `COUNT`, `SUM` y `AVG`.
- Agrupaciones mediante `GROUP BY` y filtrado de resultados con `HAVING`.
- Subconsultas para resolver cálculos intermedios.
- Ordenación de resultados con `ORDER BY`.

Cada consulta está numerada e incluye como comentario su enunciado correspondiente en el archivo SQL.

## Principales conclusiones del análisis
A partir del análisis realizado se pueden extraer las siguientes conclusiones generales:

- Algunos clientes realizan un número significativamente mayor de alquileres que la media.
- Determinadas películas y categorías presentan una mayor frecuencia de alquiler.
- El uso del inventario no es uniforme, existiendo copias que se alquilan con mayor frecuencia.
- El análisis agregado permite identificar patrones de comportamiento en los clientes.

## Ejemplos de consultas

-- =====================================================
-- Exercise 20 – Average Movie Duration by Category (CTE)
-- Identifies movie categories with an average duration
-- above 110 minutes using a Common Table Expression.
-- =====================================================

WITH Duracion_categorias AS (
    SELECT 
        c.name AS "Category",
        f.length AS "Duration"
    FROM film f
    INNER JOIN film_category fc 
        ON f.film_id = fc.film_id
    INNER JOIN category c 
        ON c.category_id = fc.category_id
)
SELECT 
    "Category",
    ROUND(AVG("Duration"), 2) AS "Average_Duration"
FROM Duracion_categorias
GROUP BY "Category"
HAVING AVG("Duration") > 110;


-- =====================================================
-- Exercise 27 – Movies Priced Above the Average Rental Rate (Subquery)
-- Finds movies whose rental price is higher than the
-- overall average rental rate.
-- =====================================================

SELECT f.title AS "Title"
FROM film f
WHERE f.rental_rate > (
    SELECT AVG(f2.rental_rate)
    FROM film f2
);


-- =====================================================
-- Exercise 34 – Top 5 Customers by Total Spend
-- Ranks customers based on the total revenue generated.
-- =====================================================

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS "Customer",
    SUM(p.amount) AS "Total_Spent"
FROM customer c
INNER JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, "Customer"
ORDER BY "Total_Spent" DESC
LIMIT 5;


-- =====================================================
-- Exercise 48 – Actor Movie Count View
-- Creates a reusable view showing the number of movies
-- each actor has appeared in.
-- =====================================================

CREATE VIEW actor_num_movies AS
SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS "Actor",
    COUNT(fa.film_id) AS "Movie_Count"
FROM actor a
LEFT JOIN film_actor fa 
    ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, "Actor";


-- =====================================================
-- Exercise 52 – Frequently Rented Movies (Temporary Table)
-- Stores movies rented at least 10 times in a temporary
-- table for further analysis.
-- =====================================================

CREATE TEMPORARY TABLE frequently_rented_movies AS
SELECT 
    f.title AS "Movie",
    COUNT(r.rental_id) AS "Rental_Count"
FROM rental r
INNER JOIN inventory i  
    ON i.inventory_id = r.inventory_id
INNER JOIN film f 
    ON f.film_id = i.film_id
GROUP BY f.title
HAVING COUNT(r.rental_id) >= 10
ORDER BY "Rental_Count" DESC;


-- =====================================================
-- Exercise 53 – Movies Not Returned by a Specific Customer (CTE)
-- Identifies movies rented and not yet returned by
-- a given customer.
-- =====================================================

WITH not_returned_movies AS (
    SELECT 
        f.title AS "Title",
        CONCAT(c.first_name, ' ', c.last_name) AS "Customer",
        r.return_date
    FROM rental r
    INNER JOIN customer c 
        ON c.customer_id = r.customer_id
    INNER JOIN inventory i  
        ON i.inventory_id = r.inventory_id
    INNER JOIN film f 
        ON f.film_id = i.film_id
    WHERE r.return_date IS NULL
)
SELECT "Title"
FROM not_returned_movies
WHERE "Customer" = 'TAMMY SANDERS'
ORDER BY "Title";


-- =====================================================
-- Exercise 55 – Actors in Movies Rented After a Reference Date (CTE)
-- Finds actors who appeared in movies rented after the
-- first rental of 'Spartacus Cheaper'.
-- =====================================================

WITH first_spartacus_rental AS (
    SELECT MIN(r.rental_date) AS first_rental_date
    FROM film f
    INNER JOIN inventory i 
        ON i.film_id = f.film_id
    INNER JOIN rental r 
        ON r.inventory_id = i.inventory_id
    WHERE f.title = 'SPARTACUS CHEAPER'
)
SELECT DISTINCT 
    a.first_name,
    a.last_name
FROM rental r
INNER JOIN inventory i 
    ON i.inventory_id = r.inventory_id
INNER JOIN film_actor fa 
    ON fa.film_id = i.film_id
INNER JOIN actor a 
    ON a.actor_id = fa.actor_id
CROSS JOIN first_spartacus_rental fsr
WHERE r.rental_date > fsr.first_rental_date
ORDER BY a.last_name;


-- =====================================================
-- Exercise 56 – Actors Without Movies in a Specific Category (CTEs + NOT EXISTS)
-- Identifies actors who have not appeared in movies
-- belonging to the 'Music' category.
-- =====================================================

WITH music_movies AS (
    SELECT f.film_id
    FROM film f
    INNER JOIN film_category fc 
        ON f.film_id = fc.film_id
    INNER JOIN category c 
        ON c.category_id = fc.category_id
    WHERE c.name = 'Music'
),
music_actors AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    INNER JOIN music_movies mm
        ON fa.film_id = mm.film_id
)
SELECT 
    a.first_name AS "First_Name",
    a.last_name AS "Last_Name"
FROM actor a
WHERE NOT EXISTS (
    SELECT 1
    FROM music_actors ma
    WHERE ma.actor_id = a.actor_id
);

