-- sql Reatail sales Analysis -

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

select * from retail_sales limit 10;

select count(*) from retail_sales;

-- data cleaning

select * from retail_sales 
where transactions_id is null;

select * from retail_sales
where sale_date is null;

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

-- data exploration

-- how many sales we have ?
 select count(*) as total_sale 
 from retail_sales;

-- how many unique customer we have ?
select count(distinct customer_id) as customer
from retail_sales;

-- how many category we have
select distinct category from retail_sales;

-- data analysis

-- write a sql query to retrive all columns for sales made on '2022-11-05'

select * from retail_sales 
where sale_date = '2022-11-05';

-- write a sql query to retrive all trancations where the category is 'colthing' and the quantity sold is more than 4 in the month of nov-2022

select * from retail_sales 
where category = 'Clothing'
and quantiy >= 4 
and to_char(sale_date, 'yyyy-mm') = '2022-11';

-- write a sql query to calculate the total sale(total_sale) for each category

select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1;

-- write a sql query to find the average age of customers who purchased items from the 'beuty' category

select 
round (avg(age), 2) as age
from retail_sales
where category = 'Beauty';

-- write a sql query to find all trancations where the total_sale is greater than 1000.

select * 
from retail_sales
where total_sale>1000;

-- write a sql query to find the total number of trancations (trancation_id) made by each gender in each category

select
category,
gender,
count(*) as transaction
from retail_sales
group by 
category,
gender;

-- write a sql query to calculate the average sale for each month find out best selling month in each year 
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

-- write a sql query to find the top 5 customre based on the highest total sales
 select 
 customer_id,
 sum(total_sale) as total_sales
 from retail_sales
 group by 1
 order by 2 desc 
 limit 5;

-- writea sql query to find the number of unique customers who purchased items from each category

select 
	category,
	count(distinct customer_id) as unique_customer
from retail_sales
group by 1;

-- write a  sql query to create each shift and number of orders (example morning <=12, afternoon betwwen 12 & 17 , evening > 17)

select *,
 	case
	  when extract (Hour from sale_time) < 12 then 'Morning'
	  when extract (Hour from sale_time) between 12 and 17 then 'afternoon'
	  else 'evening'
	end as shift
from retail_sales;	
	



