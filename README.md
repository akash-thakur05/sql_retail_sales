# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  



This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sql_project_p2;

create table retail_sales
            (  
				transactions_id int primary key,
				sale_date date,
				sale_time time,
				customer_id	int,
				gender varchar(15),
				age	 int,
				category varchar(15),
				quantiy	int,
				price_per_unit float,
				cogs float,
				total_sale float

)
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

select * from retail_sales
where
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or 
	quantiy is null
	or 
	cogs is null
	or
	total_sale is null;

delete from retail_sales
where
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or 
	quantiy is null
	or 
	cogs is null
	or
	total_sale is null;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **write a sql query to retrive all columns for sales made on '2022-11-05'**:
```sql
select * from retail_sales 
where sale_date = '2022-11-05';
```

2. **write a sql query to retrive all trancations where the category is 'colthing' and the quantity sold is more than 4 in the month of nov-2022**:
```sql
select * from retail_sales 
where category = 'Clothing'
and quantiy >= 4 
and to_char(sale_date, 'yyyy-mm') = '2022-11';
```

3. **write a sql query to calculate the total sale(total_sale) for each category.**:
```sql
select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1;
```

4. **write a sql query to find the average age of customers who purchased items from the 'beuty' category.**:
```sql
select 
round (avg(age), 2) as age
from retail_sales
where category = 'Beauty';
```

5. **write a sql query to find all trancations where the total_sale is greater than 1000.**:
```sql
select * 
from retail_sales
where total_sale>1000;
```

6. **write a sql query to find the total number of trancations (trancation_id) made by each gender in each category.**:
```sql
select
category,
gender,
count(*) as transaction
from retail_sales
group by 
category,
gender;
```

7. **write a sql query to calculate the average sale for each month find out best selling month in each year**:
```sql
select 
	year,
	month,
	avg_sale
from (
		select 
		extract(Year from sale_date) as year,
		extract(Month from sale_date) as month,
		avg(total_sale) as avg_sale,
		rank() over(partition by extract (Year from sale_date) order by avg(total_sale) desc) as rank
		from retail_sales
		group by 1,2
		-- order by 1,3 desc
		) as t1
		where rank=1;
```

8. ** write a sql query to find the top 5 customre based on the highest total sales **:
```sql
 select 
 customer_id,
 sum(total_sale) as total_sales
 from retail_sales
 group by 1
 order by 2 desc 
 limit 5;
```

9. **write a sql query to find the number of unique customers who purchased items from each category**:
```sql
select 
	category,
	count(distinct customer_id) as unique_customer
from retail_sales
group by 1;
```

10. **write a  sql query to create each shift and number of orders (example morning <=12, afternoon betwwen 12 & 17 , evening > 17)**:
```sql
select *,
 	case
	  when extract (Hour from sale_time) < 12 then 'Morning'
	  when extract (Hour from sale_time) between 12 and 17 then 'afternoon'
	  else 'evening'
	end as shift
from retail_sales;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.




