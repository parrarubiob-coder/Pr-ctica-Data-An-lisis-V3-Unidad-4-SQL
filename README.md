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
