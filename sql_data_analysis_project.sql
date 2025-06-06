-- database: :memory:

-- 1. Order details with customer city
SELECT o.order_id, o.order_purchase_timestamp, c.customer_city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 2. Order items with product and seller info
SELECT oi.order_id,
       p.product_category_name,
       s.seller_city,
       oi.price,
       oi.freight_value
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN sellers s ON oi.seller_id = s.seller_id;

-- 3. Order payments
SELECT o.order_id,
       p.payment_type,
       p.payment_value
FROM payments p
JOIN orders o ON p.order_id = o.order_id;

-- 4. Average delivery time in days
SELECT AVG(
  julianday(order_delivered_customer_date)
  - julianday(order_purchase_timestamp)
) AS avg_delivery_days
FROM orders;

-- 5. Average review score per product category
SELECT p.product_category_name,
       AVG(r.review_score) AS avg_score
FROM reviews r
JOIN order_items oi ON r.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name;

-- 6. Create view for top 10 categories by revenue
CREATE VIEW top_categories AS
SELECT p.product_category_name,
       SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 7. Query the top categories view
SELECT * FROM top_categories;

-- 8. Create indexes to optimize queries
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_items_product ON order_items(product_id);
