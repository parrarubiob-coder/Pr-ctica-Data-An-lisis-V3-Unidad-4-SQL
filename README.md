# Movie Rental SQL Analysis

**Language: English (default) | [Versión en Español](README_ES.md)**

**Tools:** SQL (PostgreSQL)

## Project Description  
This project consists of the analysis of a movie rental database using SQL to answer a set of business-related questions. The database includes information about films, categories, inventory, customers, rentals, and payments.  
Through different queries, the project explores customer behavior and the usage of the movie catalog.

---

## Analysis Objective  
The main goal of this project is to extract insights from rental data, including:

- Analyzing customer rental activity  
- Identifying high-demand movies and categories  
- Exploring rental patterns and inventory usage  
- Generating aggregated insights from transactional data  

---

## Project Workflow  
The project followed these main steps:

1. Initial exploration of database tables and structure  
2. Identification of primary and foreign keys and table relationships  
3. Review of the database schema  
4. Understanding each problem statement and defining the approach  
5. Development of SQL queries using joins, subqueries, and aggregations  
6. Validation and verification of results  

---

## Query Approach  
Different SQL techniques were applied throughout the project:

- JOINs across tables such as `film`, `inventory`, `rental`, `customer`, and `category`  
- Aggregation functions such as `COUNT`, `SUM`, and `AVG`  
- Grouping using `GROUP BY` and filtering with `HAVING`  
- Subqueries for intermediate calculations  
- Sorting results using `ORDER BY`  

Each query is numbered and includes the corresponding problem statement as a comment in the SQL file.

---

## Key Insights  
From the analysis, the following conclusions were identified:

- A small group of customers generates a significantly higher number of rentals  
- Certain movies and categories show higher demand  
- Inventory usage is not uniform, with some copies rented more frequently  
- Aggregated analysis reveals clear customer behavior patterns  
