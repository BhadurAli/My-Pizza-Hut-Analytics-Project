select * from pizzadb.pizza_sales;

-- KPI REQUIREMENTS

-- Total Reveniew
select sum(total_price) as total_reveniew from pizzadb.pizza_sales; -- Without round
select round(sum(total_price)) as total_reveniew from pizzadb.pizza_sales; -- With round

-- Average Order values
select sum(total_price) / count(distinct order_id) AS Average_order_Value from pizza_sales; -- Without round
select round (sum(total_price) / count(distinct order_id)) AS Average_order_Value from pizza_sales; -- With round

-- Total Pizza Solds
select sum(quantity) as Total_pizza_solds from pizza_sales;

-- Total Order Placed
select count(distinct order_id) as Total_order_placed from pizza_sales;

-- Average Pizas per Order
select cast(sum(quantity) / count(distinct order_id) as decimal(10,2)) from pizza_sales; -- with cast
select sum(quantity) / count(distinct order_id)  from pizza_sales; -- without cast 

-------------------------------------------------------------------------------------------------------------------------------

-- CHARTS REQUIREMENTS
select * from pizzadb.pizza_sales;

-- Hourly trend for total pizza solds
select hour(order_time) as hours, sum(quantity) from pizza_sales
group by hours
order by hours;

-- weekly trends for total Orders
select week(order_date) as weeks, Year(order_date) as years, count(distinct order_id) from pizza_sales
group by weeks, years 
order by weeks, years; 

-- Percentage of sales by pizza category
select pizza_category, round(sum(unit_price)) as Unit, 
concat(format(sum(total_price) * 100 / (select sum(total_price) from pizza_sales)*100,2), "%") as percentage_of_sale 
from pizza_sales
where month(order_date) in (1,2,3,4,5,6,7,8,9) -- filter data by months
group by pizza_category;

-- Percentage of sales by pizza category without filtering
select pizza_category, round(sum(unit_price)) as Unit, 
concat(format(sum(total_price) * 100 / (select sum(total_price) from pizza_sales)*100,2), "%") as percentage_of_sale 
from pizza_sales
group by pizza_category;

-- Percentage of sales by pizza size
select pizza_size, round(sum(unit_price)) as Unit, 
concat(format(sum(total_price) * 100 / (select sum(total_price) from pizza_sales)*100,2), "%") as percentage_of_sale 
from pizza_sales
group by pizza_size
order by percentage_of_sale DESC;

-- Total Pizza sold by category
select pizza_category, sum(quantity) from pizza_sales
group by pizza_category;

-- top 5 best seller pizza by revenue
select pizza_name, sum(total_price) as Total_reveniew from pizza_sales
group by pizza_name
order by Total_reveniew DESC
limit 5;

-- top 5 low seller pizza by revenue
select pizza_name, sum(total_price) as Total_reveniew from pizza_sales
group by pizza_name
order by Total_reveniew
limit 5;

-- top 5 best seller pizza by Total quantity
select pizza_name, sum(quantity) as Total_quantity from pizza_sales
group by pizza_name
order by Total_quantity DESC
limit 5;

-- top 5 low seller pizza by Total quantity
select pizza_name, sum(quantity) as Total_quantity from pizza_sales
group by pizza_name
order by Total_quantity
limit 5;

-- top 5 best seller pizza by Total Order
select pizza_name, count(distinct order_id) as Total_order from pizza_sales
group by pizza_name
order by Total_order DESC
limit 5;

-- top 5 low seller pizza by Total Order
select pizza_name, count(distinct order_id) as Total_order from pizza_sales
group by pizza_name
order by Total_order
limit 5;