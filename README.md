# TASK-4 SQL for Data Analysis – eCommerce Dataset

 Objective
Perform SQL-based data analysis on a relational eCommerce dataset using SQLite. This project showcases how to extract, analyze, and interpret data using core SQL techniques.

 Tools Used
- **SQLiteStudio** – Lightweight SQL GUI tool for SQLite
- **eCommerce CSV Dataset** – Public dataset simulating customer, order, product, and transaction data
- **SQL** – Data manipulation and analysis language

Dataset Tables
| Table         | Description                          |
|---------------|--------------------------------------|
| `customers`   | Customer IDs and locations           |
| `orders`      | Orders placed, timestamps            |
| `order_items` | Product, price, and seller info      |
| `products`    | Product category data                |
| `sellers`     | Seller locations                     |
| `payments`    | Payment type and amount              |
| `reviews`     | Order reviews and ratings            |


 Key Concepts Practiced
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
- Aggregate functions: `SUM()`, `AVG()`
- SQL `JOINS` (INNER, LEFT)
- Subqueries
- Creating `VIEWS`
- Adding `INDEXES` for optimization

 📊 Example Queries

 ---Order details with customer city
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    c.customer_city
FROM
    orders o
JOIN
    customers c ON o.customer_id = c.customer_id;
---Order items with product and seller info
SELECT
    oi.order_id,
    p.product_category_name,
    s.seller_city,
    oi.price,
    oi.freight_value
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.product_id
JOIN
    sellers s ON oi.seller_id = s.seller_id;
--- Order payments  
SELECT
    o.order_id,
    py.payment_type,
    py.payment_value
FROM
    payments py
JOIN
    orders o ON py.order_id = o.order_id;
---Average delivery time in days
SELECT
    AVG(
        julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
    ) AS avg_delivery_days
FROM
    orders
WHERE
    order_delivered_customer_date IS NOT NULL
    AND order_purchase_timestamp IS NOT NULL;
---Average review score per product category
SELECT
    p.product_category_name,
    AVG(r.review_score) AS avg_score
FROM
    reviews r
JOIN
    order_items oi ON r.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    avg_score DESC;
--- Create view for top 10 categories by revenue
DROP VIEW IF EXISTS top_categories;
CREATE VIEW top_categories AS
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_revenue DESC
LIMIT 10;
---Query the top categories view
SELECT * FROM top_categories;
---Create indexes to optimize queries 
CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_items_product ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_items_seller ON order_items(seller_id);
CREATE INDEX IF NOT EXISTS idx_reviews_order ON reviews(order_id);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(product_category_name);

📦 ecommerce-sql-analysis/
├── sql_queries.sql           # SQL queries used for analysis
├── screenshots/              # Output screenshots of queries
├── orders.csv, products.csv  # Source CSVs
├── README.md   

www.linkedin.com/in/sionrani

