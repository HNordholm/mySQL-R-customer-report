
#Churn analysis with CTE:s -

WITH purchasefreq AS 
(
SELECT 
	c.customer_id,
	CONCAT(first_name," ",last_name) AS fullname,
	COUNT(o.order_id) AS total_orders,
	AVG(DATEDIFF(o2.order_date, o1.order_date)) AS avgdaysbetweenorders
    FROM 
        customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN orders o1 ON o.customer_id = o1.customer_id
    JOIN orders o2 ON o1.order_date < o2.order_date
    GROUP BY c.customer_id,fullname
),
churnrisk AS 
(
SELECT 
	customer_id,
	fullname,
	total_orders,
	avgdaysbetweenorders,
	CASE 
		WHEN total_orders = 1 THEN 'New customer(s)'
		WHEN avgdaysbetweenorders  >365 THEN 'High risk customer(s)'
		ELSE 'Loyal customer(s)'
        END AS customer_status
FROM Purchasefreq
)
SELECT 
    customer_status,
    COUNT(customer_id) AS total_customers,
    ROUND(AVG(avgdaysbetweenorders),0) AS avg_days
FROM churnrisk
GROUP BY customer_status;

#Top 10 customers with order date -- 
SELECT 
	c.customer_id,
	CONCAT(c.first_name, " ", c.last_name) AS fullname,
	ROUND(SUM(oi.quantity * oi.list_price), 2) AS revenue,
	COUNT(o.order_id) AS total_orders,
	MAX(o.order_date) AS latest_order_date
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY revenue DESC
LIMIT 10;




