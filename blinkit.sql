select*
from blinkit

-- Data Cleaning

UPDATE blinkit
SET item_fat_content = 
CASE 
WHEN item_fat_content IN ('LF','low fat') THEN 'Low Fat'
WHEN item_fat_content  = 'reg' THEN 'Regular'
ELSE item_fat_content
END


--Below are KPis

-- Total Sales

select round(sum(sales)) as  total_sales
from blinkit


-- Average Sales
select round(avg(sales)) as avg_sales
from blinkit


--Number of items
select count(*) as number_of_items
from blinkit

--Total Sales per item_fat_content
select item_fat_content, round(sum(sales)) as total_sales
from blinkit
group by item_fat_content


-- Average Ratings
select round(avg(rating)::numeric,2)
from blinkit


-- GRANULAR REQUIREMENTSS

-- 1. Total Sales by Fat Content
select item_fat_content, round(sum(sales)::numeric,2) as total_sales
from blinkit
group by item_fat_content
order by total_sales desc 

--2 Overall View per Fat Content

select item_fat_content, 
round(sum(sales)::numeric,2) as total_sales,
round(avg(sales)::numeric,2) as avg_sales,
count(*) as number_of_items

from blinkit
group by item_fat_content
order by total_sales desc 


--3 Overview for outlet establishement year 2022
select item_fat_content, 
round(sum(sales)::numeric,2) as total_sales,
round(avg(sales)::numeric,2) as avg_sales,
count(*) as number_of_items

from blinkit
where outlet_establishment_year = 2022
group by item_fat_content
order by total_sales desc 

--4 Overview per Item Type

select item_type, 
round(sum(sales)::numeric,2) as total_sales,
round(avg(sales)::numeric,2) as avg_sales,
count(*) as number_of_items

from blinkit
group by item_type
order by total_sales desc 

--5. Top 5 best sold items
select item_type, 
round(sum(sales)::numeric,2) as total_sales,
round(avg(sales)::numeric,2) as avg_sales,
count(*) as number_of_items

from blinkit
group by item_type
order by total_sales desc
limit 5


--6 Total Sales per fat content and outlet
select outlet_location_type,item_fat_content , round(sum(sales))as total_sales
from blinkit

group by item_fat_content, outlet_location_type
order by total_sales desc


--7 Total Sales with Outlet Establishment Year

select outlet_establishment_year, round(sum(sales)) as total_sales
from blinkit
group by outlet_establishment_year
order by outlet_establishment_year asc


--8 Percentage of sales by outlet size
SELECT 
outlet_size,
round(SUM(sales)) AS total_sales,
ROUND( (SUM(sales)::numeric * 100) / SUM(SUM(sales)) OVER ()::numeric, 2) AS sales_percentage

FROM 
blinkit
GROUP BY 
outlet_size
order by total_sales desc


--9 Sales By Outlet Location

select outlet_location_type, 
round(sum(sales)::numeric,2) as total_sales,
ROUND( (SUM(sales)::numeric * 100) / SUM(SUM(sales)) OVER ()::numeric, 2) AS sales_percentage,
round(avg(sales)::numeric,2) as avg_sales

from blinkit
group by outlet_location_type
order by total_sales desc


-- 10 Overall View BY Outlet Type

select outlet_type, 
round(sum(sales)::numeric,2) as total_sales,
round(avg(rating)::numeric,2) as avg_rating,
ROUND((SUM(sales)::numeric * 100) / SUM(SUM(sales)) OVER ()::numeric, 2) AS sales_percentage,
round(avg(sales)::numeric,2) as avg_sales

from blinkit
group by outlet_type
order by total_sales desc

