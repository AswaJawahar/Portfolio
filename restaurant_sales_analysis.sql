SELECT * 
FROM menu_items;

-- total menu items
SELECT COUNT(*)
FROM menu_items;

-- least expensive items
SELECT item_name, price
FROM menu_items
ORDER BY price; 

-- most expensive items
SELECT item_name, price
FROM menu_items
ORDER BY price DESC;

-- How many Italian dishes are on the menu? 

SELECT COUNT(*)
FROM menu_items
WHERE category = "Italian";

-- What are the least and most expensive Italian dishes on the menu?

SELECT item_name, price
FROM menu_items
WHERE category = "Italian"
ORDER BY price; 

SELECT item_name, price
FROM menu_items
WHERE category = "Italian"
ORDER BY price DESC;

-- How many dishes are in each category? 

SELECT category, COUNT(*)
FROM menu_items
GROUP BY category;

-- What is the average dish price within each category?
SELECT category, AVG(price)
FROM menu_items
GROUP BY category;

-- View the order_details table. What is the date range of the table?

SELECT * 
FROM order_details;

SELECT MIN(order_date), MAX(order_date)
FROM order_details;

-- How many orders were made within this date range?

SELECT COUNT(DISTINCT order_id) 
FROM order_details;

-- How many items were ordered within this date range?

SELECT COUNT(*) 
FROM order_details;

-- Which orders had the most number of items?

SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- How many orders had more than 12 items?

SELECT COUNT(*) 
FROM (SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12) num_orders;

-- Combine the menu_items and order_details tables into a single table

SELECT * 
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id = mi.menu_item_id;

-- What were the least and most ordered items? What categories were they in?

SELECT item_name, category, COUNT(order_id) AS num_orders
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id = mi.menu_item_id
GROUP BY item_id, category
ORDER BY num_orders DESC;

-- What were the top 5 orders that spent the most money?

SELECT od.order_id, SUM(mi.price) AS total_spent
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id = mi.menu_item_id
GROUP BY od.order_id
ORDER BY total_spent DESC
LIMIT 5;

-- View the details of the highest spend order. Which specific items were purchased?

SELECT *
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440;

-- View the details of the top 5 highest spend orders

SELECT *
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675);
