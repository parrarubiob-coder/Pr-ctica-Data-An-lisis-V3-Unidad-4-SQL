-- 1. CREA EL ESQUEMA DE LA BBDD
	--En Github
	
-- =====================================================
-- 2. Muestra los nombres de todas las películas con una
--    clasificación por edades de ‘R’.
-- =====================================================

select "title", "rating" 
from "film"
where "rating" = 'R';

-- =====================================================
-- 3. Encuentra los nombres de los actores que tengan un
--    actor_id entre 30 y 40.
-- =====================================================

select concat(first_name , ' ', last_name) as "NOMBRE", actor_id 
from "actor" 
where "actor_id" between 30 and 40;

-- =====================================================
-- 4. Obtén las películas cuyo idioma coincide con el
--    idioma original.
-- =====================================================
	--*No me funciona porque la columna original_lenguage_id está en blanco*

select "title" 
from "film" 
where "language_id" = "original_language_id";

-- =====================================================
-- 5. Ordena las películas por duración de forma ascendente.
-- =====================================================

select *
from film f 
order by f.length ;

-- =====================================================
-- 6. Encuentra el nombre y apellido de los actores que
--    tengan ‘Allen’ en su apellido.
-- =====================================================

select concat(A.first_name , ' ', A.last_name )
from actor a 
where A.last_name like '%ALLEN%';

-- =====================================================
-- 7. Encuentra la cantidad total de películas en cada
--    clasificación y muestra la clasificación junto con
--    el recuento.
-- =====================================================

select f.rating , count(F.film_id )
from film f 
group by F.rating ;

-- =====================================================
-- 8. Encuentra el título de todas las películas que son
--    ‘PG-13’ o tienen una duración mayor a 3 horas.
-- =====================================================
--*Entiendo que la longitud está en minutos*

select*
from film f 
where F.rating = 'PG-13' or F.length >180;

-- =====================================================
-- 9. Encuentra la variabilidad de lo que costaría
--    reemplazar las películas.
-- =====================================================

SELECT VARIANCE(f.replacement_cost) AS "Variabilidad"
FROM film f;

-- =====================================================
-- 10. Encuentra la mayor y menor duración de una película.
-- =====================================================

SELECT 
    MAX(f.length) AS "Duracion_maxima",
    MIN(f.length) AS "Duracion_minima"
FROM film f;

-- =====================================================
-- 11. Encuentra lo que costó el antepenúltimo alquiler
--     ordenado por día.
-- =====================================================

SELECT 
    f.rental_rate AS "Precio_alquiler"
FROM rental r
INNER JOIN inventory i 
    ON r.inventory_id = i.inventory_id
INNER JOIN film f 
    ON i.film_id = f.film_id
ORDER BY r.rental_date DESC
LIMIT 1
OFFSET 2;

-- =====================================================
-- 12. Encuentra el título de las películas que no sean
--     ni ‘NC-17’ ni ‘G’.
-- =====================================================

SELECT f.title AS "Título"
FROM film f
WHERE f.rating NOT IN ('NC-17', 'G');

-- =====================================================
-- 13. Promedio de duración de las películas por
--     clasificación.
-- =====================================================

select f.rating as "Clasificación", round (AVG(f.length ),2) as "Promedio_duración" 
from film f 
group by f.rating ;

-- =====================================================
-- 14. Encuentra el título de todas las películas que
--     tengan una duración mayor a 180 minutos.
-- =====================================================

SELECT f.title AS "Título"
FROM film f
WHERE f.length > 180;

-- =====================================================
-- 15. ¿Cuánto dinero ha generado en total la empresa?
-- =====================================================

SELECT SUM(p.amount) AS "Total_ingresos"
FROM payment p;

-- =====================================================
-- 16. Muestra los 10 clientes con mayor valor de id.
-- =====================================================

SELECT 
    c.customer_id AS "CustomerId",
    CONCAT(c.first_name, ' ', c.last_name) AS "Cliente"
FROM customer c
ORDER BY c.customer_id DESC
LIMIT 10;

-- =====================================================
-- 17. Actores que aparecen en la película ‘Egg Igby’.
-- =====================================================

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS "Actor"
FROM film f
INNER JOIN film_actor fa 
    ON f.film_id = fa.film_id
INNER JOIN actor a 
    ON a.actor_id = fa.actor_id
WHERE f.title = 'EGG IGBY';

-- =====================================================
-- 18. Selecciona todos los nombres de las películas únicos.
-- =====================================================

SELECT DISTINCT f.title as "Películas_únicas"
FROM film f;

-- =====================================================
-- 19. Películas que son comedias y duran más de 180 minutos.
-- =====================================================

SELECT f.title as "Título"
FROM film f
INNER JOIN film_category fc 
    ON f.film_id = fc.film_id
INNER JOIN category c 
    ON c.category_id = fc.category_id
WHERE f.length > 180
  AND c.name = 'Comedy';

-- =====================================================
-- 20. Encuentra las categorías de peliculas que tienen un promedio 
-- de duración superior a 110 min. Muestra el nombre de la categoría 
-- junto con el promedio de duración    
-- =====================================================

with Duracion_categorias as (
	select c."name" as "Categoria", f.length as "Duración"
	from film f 
	inner join film_category fc 
	ON f.film_id = fc.film_id
    INNER JOIN category c
        ON c.category_id = fc.category_id
)
select "Categoria" , ROUND(AVG("Duración"),2) as "Duración_Promedio"
from Duracion_categorias
group by "Categoria" 
having ROUND(AVG("Duración"),2)> 110;

-- =====================================================
-- 21. ¿Cuás el la media de duración del alquiler de las películas?
-- =====================================================

select round(AVG(f.rental_duration) , 2) as "Media_duración_alquiler"
from film f ;

-- =====================================================
-- 22. Crea una columna con nombre y apellidos de actores.
-- =====================================================

select concat(a.first_name , ' ', a.last_name ) as "Nombre_apellidos"
from actor a ;

-- =====================================================
-- 23. Número de alquileres por día, ordenados por cantidad de alquiler
-- de forma descendente.
-- =====================================================

select DATE (r.rental_date) as "Fecha", count(r.rental_id ) as "Num_alquileres"
from rental r 
group by DATE (r.rental_date)
order by count(r.rental_id ) desc;

-- =====================================================
-- 24. Encuentra las películas con duración superior al promedio.
-- =====================================================

select f.title as "Título"
from film f 
where f.length > (
	select AVG(f2.length )
	from film f2 );

-- =====================================================
-- 25. Número de alquileres registrados por mes.
-- =====================================================

select to_char(r.rental_date, 'Month' ) as "Mes", count(r.rental_id ) as "Alquileres"
from rental r 
group by to_char(r.rental_date, 'Month');

-- =====================================================
-- 26. Encuentra el promedio, desviación estándar y varianza del total
--     pagado.
-- =====================================================

select ROUND (AVG(p.amount ), 2) as "Promedio", ROUND (STDDEV(p.amount ), 2) as "Desviación_estandar", ROUND (VARIANCE(p.amount ), 2) as "VARIANZA"
from payment p ;

-- =====================================================
-- 27. ¿Qué películas se alquilan por encima del precio medio?
-- =====================================================

select f.title as "Título"
from film f 
where f.rental_rate > (
	select AVG(f2.rental_rate )
	from film f2 );

-- =====================================================
-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
-- =====================================================

with Peliculas_por_actor as(
	select a.actor_id  as "ActorId", count(f.film_id) as "Num_películas"
	from actor a 
	inner join film_actor fa 
	on a.actor_id = fa.actor_id 
	inner join film f 
	on f.film_id = fa.film_id 
	group by a.actor_id)
select "ActorId"  , "Num_películas" 
from Peliculas_por_actor 
where "Num_películas" >40;
	

-- =====================================================
-- 29. Obtener todas las películas y, si están disponibles en el inventario,
--     mostrar la cantidad disponible.
-- =====================================================

select f.title as "Título", count(i.inventory_id ) as "Cantidad_disponible"
from film f 
left join inventory i 
on i.film_id = f.film_id 
group by f.title;

-- =====================================================
-- 30. Obtener los actores y el número de películas en las que ha actuado.
-- =====================================================

select a.actor_id , concat(a.first_name , ' ', a.last_name  ) as "Nombre_apellidos", count(f.film_id) as "Num_películas"
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id 
inner join film f 
on f.film_id = fa.film_id 
group by a.actor_id , concat(a.first_name , ' ', a.last_name );

-- =====================================================
-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas,
--     incluso si algunas películas no tienen actores asociados.
-- =====================================================

select f.title as "Título", concat(A.first_name , ' ', A.last_name )
from film f 
left join film_actor fa 
on FA.film_id = F.film_id 
left join actor a 
on A.actor_id = FA.actor_id ;

-- =====================================================
-- 32. Obtener todos los actores y mostrar las películas en las que han actuado,
--     incluso si algunos actores no han actuado en ninguna película.
-- =====================================================

select concat(A.first_name , ' ', A.last_name ) as "Nombre", f.title as "Título"
from actor a 
left join film_actor fa 
on A.actor_id = FA.actor_id 
left join film f 
on FA.film_id = F.film_id ;

-- =====================================================
-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
-- =====================================================

select F.title as "Película", r.rental_id as "Alquiler_Id"
from film f 
full join inventory i 
on F.film_id = I.film_id 
full join rental r 
on R.inventory_id = I.inventory_id ;

-- =====================================================
-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
-- =====================================================

select c.customer_id , concat(c.first_name, ' ', c.last_name ) as "Cliente", SUM(p.amount ) as "Gasto_total" 
from customer c 
inner join payment p 
on c.customer_id = p.customer_id 
group by c.customer_id , concat(c.first_name, ' ', c.last_name )
order by "Gasto_total" DESC
limit 5;

-- =====================================================
-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
-- =====================================================

select concat(A.first_name, ' ', A.last_name ) as "ACTORES"
from actor a 
where a.first_name = 'JOHNNY';

-- =====================================================
-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
-- =====================================================

select a.first_name as "Nombre", a.last_name as "Apellido"
from actor a ;

-- =====================================================
-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
-- =====================================================

select MIN(a.actor_id ) as "Id_minim", MAX(a.actor_id ) as "Id_max" 
from actor a ;

-- =====================================================
-- 38. Cuenta cuántos actores hay en la tabla “actor”.
-- =====================================================

select count(a.actor_id ) as "Num_actores"
from actor a ;

-- =====================================================
-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
-- =====================================================

select concat(a.first_name , ' ', a.last_name ) as "Actores"
from actor a 
order by a.last_name asc;

-- =====================================================
-- 40. Selecciona las primeras 5 películas de la tabla “film”.
-- =====================================================

select f.title 
from film f 
limit 5;

-- =====================================================
-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre.
--     ¿Cuál es el nombre más repetido?
-- =====================================================

select a.first_name as "Nombre", count(a.actor_id ) as "Nom_actores_nombre"
from actor a 
group by a.first_name
order by count(a.actor_id ) DESC;

	--KENNETH, PENELOPE Y JULIA son los más repetidos: 4 veces

-- =====================================================
-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
-- =====================================================

select r.rental_id as "Rental_Id", c.customer_id as "Cliente_Id" , concat(c.first_name , ' ', c.last_name ) as "Cliente"
from rental r 
inner join customer c 
on c.customer_id = r.customer_id ;

-- =====================================================
-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
-- =====================================================

select concat(c.first_name , ' ', c.last_name ) as "Cliente", r.rental_id as "Rental_Id"
from customer c 
left join rental r 
on c.customer_id = r.customer_id;

-- =====================================================
-- 44. Realiza un CROSS JOIN entre las tablas film y category.
--     ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
-- =====================================================

select *
from film f 
cross join category c 

	-- No aporta valor porque esto realiza un producto cartesiano entre películas y categorías.
	-- Una pelicula solo tiene una categoría asociada, y esto está mostrando todas las peliculas asociadas a todas las categorías.
	-- Está mostrando relaciones que no son reales

-- =====================================================
-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
-- =====================================================

select distinct concat(A.first_name , ' ', A.last_name ) as "Nombre_actores"
from actor a 
inner join film_actor fa 
on A.actor_id = FA.actor_id 
inner join film_category fc 
on fc.film_id = fa.film_id 
inner join category c 
on c.category_id = fc.category_id 
where c."name" = 'Action';

-- =====================================================
-- 46. Encuentra todos los actores que no han participado en películas.
-- =====================================================

select a.actor_id as "Id_actor", concat(A.first_name , ' ', A.last_name ) as "Nombre", count(fa.film_id ) as "Numero_películas"
from actor a 
left join film_actor fa 
on fa.actor_id = a.actor_id 
group by a.actor_id, concat(A.first_name , ' ', A.last_name )
having count(fa.film_id ) = 0;

	-- No hay actores que no hayan participado en ninguna película

-- =====================================================
-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
-- =====================================================

select a.actor_id as "Id_actor", concat(A.first_name , ' ', A.last_name ) as "Nombre", count(fa.film_id ) as "Numero_películas"
from actor a 
left join film_actor fa 
on fa.actor_id = a.actor_id 
group by a.actor_id, concat(A.first_name , ' ', A.last_name );

-- =====================================================
-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores
--     y el número de películas en las que han participado.
-- =====================================================

create view actor_num_peliculas as 
	select a.actor_id as "Id_actor", concat(A.first_name , ' ', A.last_name ) as "Nombre", count(fa.film_id ) as "Numero_películas"
	from actor a 
	left join film_actor fa 
	on fa.actor_id = a.actor_id 
	group by a.actor_id, concat(A.first_name , ' ', A.last_name ); 

-- =====================================================
-- 49. Calcula el número total de alquileres realizados por cada cliente.
-- =====================================================

select c.customer_id, concat(c.first_name , ' ', c.last_name ) as "Nombre_cliente", count(r.rental_id ) as "Alquileres_realizados"
from rental r 
left join customer c 
on r.customer_id = c.customer_id 
group by c.customer_id , concat(c.first_name , ' ', c.last_name );

-- =====================================================
-- 50. Calcula la duración total de las películas en la categoría 'Action'.
-- =====================================================

select sum ( f.length ) as "Longitud_total"
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id 
where c."name" ='Action';

-- =====================================================
-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
-- =====================================================

create temporary table cliente_rentas_temporal as
	select c.customer_id, concat(c.first_name , ' ', c.last_name ) as "Nombre_cliente", count(r.rental_id ) as "Alquileres_realizados"
	from rental r 
	left join customer c 
	on r.customer_id = c.customer_id 
	group by c.customer_id , concat(c.first_name , ' ', c.last_name );

-- =====================================================
-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas
--     que han sido alquiladas al menos 10 veces.
-- =====================================================

create temporary table peliculas_alquiladas as
	select f.title as "Película" , count(r.rental_id ) as "Num_alquileres"
	from rental r 
	inner join inventory i  
	on i.inventory_id = r.inventory_id 
	inner join film f 
	on f.film_id = i.film_id 
	group by f.title 
	having count(r.rental_id ) > 9
	order by count(r.rental_id ) desc;

-- =====================================================
-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre
--     ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
-- =====================================================

with Peliculas_no_devueltas as (
select F.title as "Título", concat(c.first_name , ' ', c.last_name ) as "Nombre_cliente", r.return_date as "Fecha_devolución"
from rental r
	inner join customer c 
	on c.customer_id = r.customer_id 
	inner join inventory i  
	on i.inventory_id = r.inventory_id 
	inner join film f 
	on f.film_id = i.film_id 
where r.return_date  is null)
select "Título" 
from Peliculas_no_devueltas 
where "Nombre_cliente" = 'TAMMY SANDERS'
order by "Título" ;

-- =====================================================
-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece
--     a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
-- =====================================================

select distinct concat(A.first_name , ' ', A.last_name ) as "Nombre", a.last_name  as "Apellido"
from film f 
	inner join film_category fc 
	on f.film_id = fc.film_id 
	inner join category c 
	on fc.category_id = c.category_id 
	inner join film_actor fa 
	on FA.film_id =F.film_id 
	inner join actor a 
	on A.actor_id =FA.actor_id 
where c."name" ='Sci-Fi'
order by a.last_name ;

-- =====================================================
-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron
--     después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez.
--     Ordena los resultados alfabéticamente por apellido.
-- =====================================================

with Primer_alquiler_Spartacus as (
	select MIN(r.rental_date) AS primer_alquiler_spartacus
	from film f
	join inventory i ON i.film_id = f.film_id
	join rental r ON r.inventory_id = i.inventory_id
	where f.title = 'SPARTACUS CHEAPER')
select distinct a.first_name , a.last_name 
from rental r
inner join inventory i ON i.inventory_id = r.inventory_id
inner join film_actor fa ON fa.film_id = i.film_id
inner join actor a ON a.actor_id = fa.actor_id
cross join primer_alquiler_spartacus pas
where r.rental_date > pas.primer_alquiler_spartacus
order by a.last_name ;

-- =====================================================
-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
-- =====================================================

with Peliculas_cat_musica as (
	select f.film_id as "Id_Peliculas_musicales"
	from film f 
	inner join film_category fc 
	on f.film_id = fc.film_id 
	inner join category c 
	on c.category_id = fc.category_id 
	where c."name" = 'Music'
	),
	Actores_musica as (
	select distinct fa.actor_id  
	from film_actor fa
	inner join Peliculas_cat_musica pcm
	on fa.film_id = pcm."Id_Peliculas_musicales") 
select a.first_name  as "Nombre", a.last_name as "Apellido"
from actor a 
where not exists (
	select 1
	from Actores_musica am
	where am.actor_id = a.actor_id );
	
-- =====================================================
-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
-- =====================================================

select distinct f.title as "Película"
from rental r 
inner join inventory i 
on r.inventory_id = i.inventory_id 
inner join film f 
on f.film_id = i.film_id
where r.return_date is not null and (R.return_date::date  - R.rental_date::date )>8;

-- =====================================================
-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
-- =====================================================

select F.title as "Título_palícula"
from film f 
	inner join film_category fc 
	on f.film_id = fc.film_id 
	inner join category c 
	on c.category_id = fc.category_id 
where c."name" = 'Animation';	
	
-- =====================================================
-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título
--     ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
-- =====================================================

select f.title as "Título_pelicula"
from film f 
where f.length = (
	select f2.length 
	from film f2
	where f2.title = 'DANCING FEVER')
order by F.title ;	
	
-- =====================================================
-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas.
--     Ordena los resultados alfabéticamente por apellido.
-- =====================================================

select C.first_name as "Nombre", C.last_name  as "Apellido", count (distinct i.film_id )
from customer c  
inner join rental r 
on R.customer_id = C. customer_id 
inner join inventory i 
on i.inventory_id = r.inventory_id 
group by c.first_name , c.last_name 
having count (distinct i.film_id  ) > 6
order by c.last_name ;

-- =====================================================
-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
--     junto con el recuento de alquileres.
-- =====================================================

select c."name" as "Categorías", count (r.rental_id ) as "Numero_Películas"
from film f 
	inner join film_category fc 
	on f.film_id = fc.film_id 
	inner join category c 
	on c.category_id = fc.category_id
	inner join inventory i 
	on i.film_id = f.film_id 
	inner join rental r 
	on i.inventory_id =r.inventory_id 
group by c."name" ;	

-- =====================================================
-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
-- =====================================================

select c."name" as "Categoria", count(f.film_id ) as "Num_Peliculas_por_categoria", f.release_year as "Año_estreno"
from film f 
inner join film_category fc 
on fc.film_id = f.film_id 
inner join category c 
on c.category_id = fc.category_id 
where f.release_year = 2006
group by c."name", f.release_year

-- =====================================================
-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
-- =====================================================

select concat(S.first_name , ' ', S.last_name )"Nombre_empleado", S2.store_id as "Store_Id"
from staff s 
cross join store s2 ;

-- =====================================================
-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente,
--     su nombre y apellido junto con la cantidad de películas alquiladas.
-- =====================================================

select c.customer_id as "IdCLiente", c.first_name as "NombreCLiente", c.last_name as "ApellidoCLiente", count(i.film_id  ) as "Peliculas alquiladas"
from customer c 
	left join rental r 
	on r.customer_id = c.customer_id 
	left join inventory i 
	on i.inventory_id = r.inventory_id 
group by c.customer_id, c.first_name, c.last_name;
