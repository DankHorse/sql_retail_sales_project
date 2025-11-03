-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p1;


-- Create Table
CREATE TABLE retail_sales(
 transactions_id INT PRIMARY KEY,
 sale_date	DATE,
 sale_time	TIME,
 customer_id INT,	
 gender	VARCHAR(20),
 age INT,	
 category VARCHAR(20),	
 quantiy INT,	
 price_per_unit FLOAT,	
 cogs FLOAT,	
 total_sale FLOAT
);

SELECT * FROM retail_sales;


SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE
	 transactions_id IS NULL; 
     
SELECT * FROM retail_sales
WHERE
	 sale_date IS NULL;
     
SELECT * FROM retail_sales
WHERE
     sale_time IS NULL;
     
SELECT * FROM retail_sales
WHERE
     customer_id IS NULL;
     
SELECT * FROM retail_sales
WHERE
     gender IS NULL;
     
     SELECT * FROM retail_sales
WHERE
     age IS NULL;
	
SELECT * FROM retail_sales
WHERE
     category IS NULL;
     
SELECT * FROM retail_sales
WHERE
     quantity IS NULL;
     
SELECT * FROM retail_sales
WHERE
	 price_per_unit IS NULL;
     
SELECT * FROM retail_sales
WHERE
     cogs IS NULL;
     
SELECT * FROM retail_sales
WHERE
     total_sale IS NULL;
     

-- Data Exploration      

-- How many sales we have

SELECT COUNT(*) AS total_sale FROM retail_sales;

-- How many unique customers we have

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- How many unique categories we have and their names

SELECT COUNT(DISTINCT category) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;


-- Data Analysis and Business Key Problems and Answers

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM retail_sales 
WHERE category = 'Clothing'
AND 
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND
quantity >= 4;

-- TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';


ALTER TABLE retail_sales
CHANGE COLUMN quantiy quantity INT;

SELECT * FROM retail_sales;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category, SUM(total_sale) FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT AVG(age) FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT price_per_unit, total_sale, category FROM retail_sales
WHERE total_sale > 1000
ORDER BY category;


-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:

SELECT COUNT(transactions_id), gender, category FROM retail_sales
GROUP BY gender, category
ORDER BY gender;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT AVG(total_sale), MONTH(sale_date) AS month FROM retail_sales
WHERE YEAR(sale_date) = 2022
GROUP BY MONTH(sale_date)
ORDER BY AVG(total_sale) DESC
LIMIT 1;
-- ORDER BY MONTH(sale_date);

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales :

SELECT SUM(total_sale), customer_id FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT COUNT(DISTINCT customer_id), category FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
( SELECT *,
     CASE
     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
     ELSE 'Evening'
     END as shift
     FROM retail_sales
)
SELECT COUNT(*) AS total_orders, shift
FROM hourly_sale
GROUP BY shift;

-- END OF PROJECT