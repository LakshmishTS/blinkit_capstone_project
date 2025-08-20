SELECT *
FROM blinkit_data;


SELECT COUNT(*)
FROM blinkit_data


SELECT DISTINCT Item_Fat_Content
from blinkit_data


update blinkit_data
SET	Item_Fat_Content = 
CASE 
WHEN Item_Fat_Content IN ('LF','low fat') then 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
else Item_Fat_Content
end	

-- total sales 
SELECT SUM(Sales) AS "Total Sales"
from blinkit_data


-- Converting total sales to million like 1.20
	select CAST(sum(Sales) / 1000000 as decimal(10,2)) as "Total sales as million"
	from blinkit_data

-- Converting 1.20 to 1.20M
	SELECT CONCAT(CAST(SUM(Sales) / 1000000 AS DECIMAL(10,2)), 'M') AS "Total Sales in Million"
	FROM blinkit_data;

-- Average sales 
select avg(sales) as "Average Sales"
from blinkit_data

-- Average sales by decimal
Select cast(avg(sales) as decimal(10,1)) as "Average sales"
from blinkit_data


-- Number of Items
Select count(*) as "Total number of Items"
from blinkit_data

-- totals sales of low fat
select sum(sales) as "Low fat sales"
from blinkit_data
where Item_Fat_Content = 'Low Fat'


-- Average rating 
select cast(avg(Rating) as decimal(10,2)) as "Average Rating"
from blinkit_data 


-- 1. Total sales by fact content
Select  Item_Fat_Content,
concat(cast(sum(sales) / 1000 as decimal(10,2)), 'K') as "Total sales by fat content",
cast(avg(sales) as decimal(10,1)) as "Average sales by fat content",
count(*) as "Total number of Items",
cast(avg(Rating) as decimal(10,2)) as "Average Rating"
from blinkit_data
group by Item_Fat_Content 
order by "Total sales by fat content" desc


select distinct Item_Type
from blinkit_data


-- 2. Total Sales by Item Type:

select top 5 Item_Type,
concat(cast(sum(sales) / 1000 as decimal(10,2)),'K') as 'Total sales by Item type',
cast(avg(sales) as decimal(10,2)) as 'Average Sales by Item type',
count(*) as 'Total number of item sold by item type',
cast(avg(Rating) as decimal(10,2)) as 'Rating by Item type'
from blinkit_data
group by Item_Type
order by sum(sales) Asc


-- 3. Fat Content by Outlet for Total Sales:
select Outlet_Location_Type, Item_Fat_Content,
concat(cast(sum(sales) / 1000 as decimal(10,2)),'K') as 'Sum of sales by outlet location type',
cast(avg(sales) as decimal(10,2)) as 'Average Sales by Item type',
count(*) as 'Total number of item sold by item type',
cast(avg(Rating) as decimal(10,2)) as 'Rating by Item type'
from blinkit_data
group by Outlet_Location_Type, Item_Fat_Content
order by sum(sales) 




-- 3. Fat Content by Outlet for Total Sales:
select Outlet_Location_Type, 
	   isnull([Low Fat],0) as 'Low Fat',
	   isnull([Regular],0) as 'Regular'
from 
(
select Outlet_Location_Type, Item_Fat_Content,
cast(sum(Sales) as decimal(10,2)) as Total_sales
from blinkit_data
group by Outlet_Location_Type, Item_Fat_Content	
) as SourceTable
PIVOT
(
sum(Total_sales)
for Item_Fat_Content in ([Low Fat],[Regular])
) as PivotTable
order by Outlet_Location_Type



-- 4. Total Sales by Outlet Establishment:

select Outlet_Establishment_Year,
	   concat(cast(sum(Sales) / 1000 as decimal(10,2)) , 'K'),
	   cast(avg(Sales) as decimal(10,2)) as 'Average Sales',
	   count(*) as 'Total Items Solds',
	   cast(avg(Rating) as decimal(10,2))
from blinkit_data
group by Outlet_Establishment_Year 
order by sum(Sales) desc



select distinct Outlet_Establishment_Year
from blinkit_data



select *
from blinkit_data
where Outlet_Establishment_Year = 2012


-- 5. Percentage of Sales by Outlet Size:
select 
Outlet_Size,
concat(CAST(sum(Sales) / 1000 as decimal(10,2)),'K') as 'Total sales',
concat(cast((sum(Sales) * 100.0 / sum(sum(Sales)) over()) as decimal(10,2)),'%') as 'Sales Percentage'
from blinkit_data
group by Outlet_Size
order by sum(Sales) desc


-- 6. Sales by Outlet Location:
select Outlet_Location_Type,
concat(cast(sum(Sales) / 1000 as decimal(10,2)),'K') as 'Total sales by Outlet location type',
concat(cast((sum(Sales) * 100.0 / sum(sum(Sales)) over()) as decimal(10,2)),'%') as 'Sales Percentage',
cast(avg(Sales) as decimal(10,2)) as 'Average Sales',
count(*) as 'Total Items Solds',
cast(avg(Rating) as decimal(10,2))
from blinkit_data
group by Outlet_Location_Type
order by sum(Sales) desc


-- 7. All Metrics by Outlet Type:
select Outlet_Type,
concat(cast(sum(Sales) / 1000 as decimal(10,2)),'K') as 'Total sales by Outlet location type',
concat(cast((sum(Sales) * 100.0 / sum(sum(Sales)) over()) as decimal(10,2)),'%') as 'Sales Percentage',
cast(avg(Sales) as decimal(10,2)) as 'Average Sales',
count(*) as 'Total Items Solds',
cast(avg(Rating) as decimal(10,2)) as 'Average Rating'
from blinkit_data
group by Outlet_Type
order by sum(Sales) desc




