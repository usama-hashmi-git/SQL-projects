Create database sql_project1;
-- Create Table

DROP TABLE IF EXISTS Retail_sales;

CREATE TABLE Retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(12),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
-- Data Cleaning Steps.
-- Retrieving columns
SELECT * FROM Retail_sales Limit 100;

-- Count data 
Select count(*) from Retail_sales;

-- Checking any Null Values
Select * From Retail_sales
where 
		transactions_id is NULL
		or
		price_per_unit is NULL
		or
		sale_date is NULL
		or
		cogs is NULL;

-- Delete NUll values, we can replace it with other value as well.

Delete From Retail_sales 
where 
		transactions_id is NULL
		or
		price_per_unit is NULL
		or
		sale_date is NULL
		or
		cogs is NULL;

-- Data Exploration
-- 1) How many Sales we have?
Select count(*) as total_sale from Retail_sales; 

-- 2) How many unique Customers we have?
Select count (Distinct customer_id) as Total_Cus from Retail_sales;

-- 3) How many Categories we have?
Select count(Distinct category) as total_Category from Retail_sales; 

-- 4) Write a query to retrieve all columns for sales made on 2022-11-05
Select * 
From Retail_sales
where sale_date = '2022-11-05' ;

-- 5) Write a query to retrieve all transactions where category is Clothing and quantity sold is more than 10 in the month of nov-2022
Select *
From Retail_sales
where category = 'Clothing'
And
quantity <= 4
And
sale_date >= '2022-11-01'
And
sale_date < '2022-12-01';	

-- 6) Write a query to calculate the total sales for each category, later I add total order as well
Select category, sum(total_sale) as SALES,
Count(*) as Total_Orders, Count(*) as Total_Orders
From Retail_sales
Group By 1;

--7) Write a query to find the average age of customers who purchased items from the 'Beauty' category.
Select Round(AVG(age), 2) From Retail_sales
where category = 'Beauty'

-- 8) Write a query to retrieve all transactions with a total sale greater than 1,000
Select * From Retail_sales
where total_sale > 1000;

-- 9) Write a query to find the total number of transactions (transaction_id) made by each gender in each category
Select category, gender, Count(*) From Retail_sales
Group By gender, category
order by 1;

--10) Write a query to calculate the average sale from each month. Find out the best selling month in each year.
Select * FROM(
SELECT 
	EXTRACT(YEAR FROM sale_date) as Year,
	EXTRACT(MONTH FROM sale_date) as MONTH,
	AVG(total_sale) as Average_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC )
From Retail_sales
GROUP BY 1, 2)
Where RANK = 1;