--SQL Retail Sale Analysis

--Create Table
CREATE TABLE retail_sales (
 	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender NVARCHAR(20),
	age INT,
	category NVARCHAR(20),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales;

--Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
	  OR
	  sale_date IS NULL
	  OR
	  sale_time IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantity IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;
    
--Data Exploration

--How many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales

--How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold atleast 4 in the month of Nov-2022

SELECT 
*
FROM retail_sales
WHERE category = 'Clothing' AND MONTH(sale_date) = 1 AND quantity >= 4


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT DISTINCT category, 
SUM(total_sale) AS total_per_cat,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
*
FROM retail_sales
WHERE total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
gender,
category,
COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY gender, category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
MONTH(sale_date) AS month_number,
DATENAME(MONTH, sale_date) AS sale_month,
ROUND(AVG(total_sale), 0) AS average_sale
FROM retail_sales
GROUP BY MONTH(sale_date), DATENAME(MONTH, sale_date)
ORDER BY month_number;

--Best selling year: 2022
SELECT 
YEAR(sale_date) AS period,
ROUND(AVG(total_sale), 0) AS average_sale
FROM retail_sales
GROUP BY YEAR(sale_date)
ORDER BY average_sale DESC;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
customer_id,
total_sale 
FROM retail_sales 
ORDER BY total_sale DESC


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
COUNT(DISTINCT customer_id) AS unique_customers,
category
FROM retail_sales
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    sale_time,
    CASE 
        WHEN CAST(sale_time AS TIME) >= '07:00:00' AND CAST(sale_time AS TIME) < '15:00:00' THEN 'Morning'
        WHEN CAST(sale_time AS TIME) >= '15:00:00' AND CAST(sale_time AS TIME) < '22:00:00' THEN 'Afternoon'
        ELSE 'Night'  -- includes times from 22:00 to 06:59
    END AS time_shift,
	quantity
FROM 
    retail_sales;

--To make it cleaner, use a subquery or Common Table Expression (CTE)
WITH ShiftedSales AS (
    SELECT 
        CASE 
            WHEN CAST(sale_time AS TIME) >= '07:00:00' AND CAST(sale_time AS TIME) < '15:00:00' THEN 'Morning'
            WHEN CAST(sale_time AS TIME) >= '15:00:00' AND CAST(sale_time AS TIME) < '22:00:00' THEN 'Afternoon'
            ELSE 'Night'
        END AS shift
    FROM 
        retail_sales
)
SELECT 
    shift,
    COUNT(*) AS number_of_orders
FROM 
    ShiftedSales
GROUP BY 
    shift;

--WITH cte_name AS (
    -- temporary result set (your logic goes here)
  --  SELECT ...
--)
-- then you use it like a normal table:
--SELECT ...
--FROM cte_name;


--End of Project