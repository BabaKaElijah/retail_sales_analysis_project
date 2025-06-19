# 🛒 SQL Retail Sales Analysis

This project showcases the use of SQL to analyze retail sales data for insights on customer behavior, product performance, and sales trends. It involves table creation, data cleaning, exploration, and answering real-world business questions using SQL.

---

## 📦 Project Summary

- 📅 Date Range: Includes sales over multiple dates and times
- 🧹 Data Cleaning: Checked for missing values
- 📊 Insights: Customer count, category performance, best months, high sales, and more
- 🧠 Advanced Logic: Time-based shifts using `CASE` and Common Table Expressions (CTEs)

---

## 🧱 Table Schema

```sql
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
```
## 🔍 Data Exploration

**Total Sales**:
```sql
SELECT COUNT(*) AS total_sales FROM retail_sales;
```
**Unique Customers**:
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```
**Available Categories**:
```sql
SELECT DISTINCT category FROM retail_sales;
```
## 💼 Business Questions & SQL Answers

**Sales on 2022-11-05**:
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```
1. **Clothing Orders ≥ 4 in Nov 2022**:
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND MONTH(sale_date) = 11 AND quantity >= 4;
```
3. **Total Sales per Category***:
```sql
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS order_count
FROM retail_sales
GROUP BY category;
```
4. **Average Age for Beauty Purchases**:
```sql
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```
5. **Transactions Over 1000**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```
6. **Transactions by Gender & Category**:
```sql
SELECT gender, category, COUNT(transactions_id) AS total
FROM retail_sales
GROUP BY gender, category
ORDER BY gender, category;
```
7. **Average Sale Per Month**:
```sql
SELECT 
MONTH(sale_date) AS month_number,
DATENAME(MONTH, sale_date) AS sale_month,
ROUND(AVG(total_sale), 0) AS average_sale
FROM retail_sales
GROUP BY MONTH(sale_date), DATENAME(MONTH, sale_date)
ORDER BY month_number;
```
8. **Best-Selling Year**:
```sql
SELECT YEAR(sale_date) AS year, ROUND(AVG(total_sale), 0) AS average_sale
FROM retail_sales
GROUP BY YEAR(sale_date)
ORDER BY average_sale DESC;
```
9. **Top 5 Customers by Total Sales**:
```sql
```SELECT customer_id, SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
```
10. **Unique Customers per Category**:
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```
## 🕒 Time Shift Analysis Using CTE
Shift definitions:

Morning: 07:00 – 14:59

Afternoon: 15:00 – 21:59

Night: 22:00 – 06:59 (includes early morning hours)
```
WITH ShiftedSales AS (
  SELECT 
    CASE 
      WHEN CAST(sale_time AS TIME) >= '07:00:00' AND CAST(sale_time AS TIME) < '15:00:00' THEN 'Morning'
      WHEN CAST(sale_time AS TIME) >= '15:00:00' AND CAST(sale_time AS TIME) < '22:00:00' THEN 'Afternoon'
      ELSE 'Night'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS number_of_orders
FROM ShiftedSales
GROUP BY shift;
```
## 🧰 Tools Used
SQL Server Management Studio (SSMS)

T-SQL (Transact-SQL)

Git & GitHub for version control

👤 Author
Ellias Sithole
This project was built for SQL practice and real-world data analysis. Feel free to fork or improve the queries.



