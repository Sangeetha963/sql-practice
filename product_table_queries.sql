-- Create a table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2),
    category VARCHAR(50)
);

-- Insert data
INSERT INTO products (name, price, category) VALUES
('I-phone', 85000, 'Electronics'),
('Watch', 799, 'Fashion'),
('Dinning Table', 2500, 'Home');

ALTER TABLE products ADD COLUMN mfg varchar(100);
-- Select all products
SELECT * FROM products;

SELECT * FROM products WHERE category = 'Fashion';

SELECT name FROM products WHERE category = 'Electronics';

SELECT name, id FROM products WHERE category = 'Home';

SELECT name, id, category FROM products WHERE price > '500';

UPDATE products SET mfg='15/05/2023' WHERE id = '10';

INSERT INTO products (name, price, category, mfg) VALUES ('Mixer Grinder', 4500, 'Home', '2023-02-15'),
('Headphones', 2999, 'Electronics', '2022-11-10'),
('Sneakers', 2499, 'Fashion', '2023-01-25'),
('Book - SQL Mastery', 799, 'Books', '2024-06-10');


SELECT name, price FROM products WHERE category = 'Electronics';

SELECT name, price, category FROM products ORDER BY price DESC;

SELECT name, price, category FROM products WHERE mfg > '10/10/2022';

SELECT category, AVG(price) AS avg_price FROM products GROUP BY category;

UPDATE products SET name = 'Laptop Pro 15' WHERE name = 'Laptop';

DELETE FROM products WHERE id = '10';

SELECT category, COUNT(*) AS total_count FROM products GROUP BY category;

SELECT name, price FROM products ORDER BY price DESC LIMIT 1;



SELECT name, price, category FROM products ORDER BY price ASC LIMIT 1;

SELECT category, COUNT(*) AS cat_count FROM products GROUP BY category; 

SELECT AVG(price) AS avg_price FROM products;

SELECT COUNT(*) AS total_count FROM products;

SELECT name, price, category FROM products ORDER BY name ASC;

UPDATE products SET price = '60000' WHERE id = 1;

INSERT INTO products (name, price, category, mfg) VALUES ('Smartwatch', 4500, 'Electronics', '10/10/2023');

SELECT * FROM products WHERE category IN ('Fashion','Electronics') ORDER BY category ASC;

SELECT * FROM products WHERE name LIKE 'B%';

SELECT * FROM products WHERE name LIKE '%h';

SELECT * FROM products WHERE price BETWEEN '1000' AND '10000';

SELECT name, price, (price*0.9) AS disc_price FROM products; 

SELECT name, price, category, (price*0.5) AS disc_price FROM products;

SELECT * FROM products WHERE mfg IS NULL;

SELECT SUM(price) AS tot_price FROM products;

SELECT name, price, category FROM products WHERE price > (SELECT AVG(price) FROM products);

SELECT name, price, category, mfg FROM products ORDER BY mfg DESC LIMIT 1;

UPDATE products
SET mfg = 
  CASE
    WHEN mfg LIKE '%/%' THEN TO_CHAR(TO_DATE(mfg, 'DD/MM/YYYY'), 'YYYY-MM-DD')
    ELSE mfg
  END;

  ALTER TABLE products 
ALTER COLUMN mfg TYPE DATE 
USING TO_DATE(mfg, 'YYYY-MM-DD');



SELECT name, price, category, mfg FROM products WHERE mfg > '2023-01-25';

UPDATE products SET price = price * 1.10 WHERE category = 'Home';

UPDATE products SET price = price - 100 WHERE category = 'Books';

SELECT category, mfg, name, AVG(price) AS avg_price, SUM(price) AS tot_price FROM products GROUP BY category, mfg, name;

UPDATE products SET category = 'Apparel' WHERE category = 'Fashion';

ALTER TABLE products ADD COLUMN stock INT;

UPDATE products SET stock = FLOOR(RANDOM() * 50 + 1);

SELECT name, category, price, mfg, stock FROM products WHERE stock < 10;

SELECT SUM(price*stock) AS inventory_sum FROM products;

SELECT name, price, category, mfg FROM products ORDER BY price DESC LIMIT 3;

SELECT name, category, price, mfg FROM products ORDER BY price ASC LIMIT 3;

SELECT name, category, price, mfg FROM products ORDER BY price, category;

CREATE VIEW active_inventory AS SELECT name, price, category, stock FROM products WHERE stock > 0;

SELECT * FROM active_inventory;

SELECT category, COUNT(*) AS num_products FROM products GROUP BY category HAVING COUNT(*) > 2;

SELECT category, COUNT(*) AS num_produts FROM products GROUP BY category HAVING COUNT(*) > 5;

SELECT price, name, category, ROUND(price) AS rounded_price FROM products;

SELECT name, category, price, mfg FROM products ORDER BY mfg ASC LIMIT 2;

CREATE TABLE suppliers (suppier_id SERIAL PRIMARY KEY, supplier_name VARCHAR(100), contact_email VARCHAR(100));

SELECT * FROM suppliers;

INSERT INTO suppliers(supplier_name, contact_email) VALUES ('TechWorld Pvt Ltd', 'contact@techworld.com'),
('HomeNeeds Ltd', 'sales@homeneeds.com'),
('BookStore Co', 'info@bookstore.com'),
('ApparelHub', 'support@apparelhub.com');

INSERT INTO products(name, price, category, mfg, stock) VALUES ('chair', '20000', 'Office', '2024-08-10', 10)

-- 23️⃣ Add supplier_id column to products and set foreign key relation
ALTER TABLE products ADD COLUMN supplier_id INT;

ALTER TABLE products ADD CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(suppier_id); 


-- 24️⃣ Assign suppliers to products

UPDATE products SET supplier_id = CASE WHEN category = 'Electronics' THEN 1 WHEN category = 'Home' THEN 2 WHEN category = 'Books' THEN 3 WHEN category = 'Apparel' THEN 4 END;

UPDATE products SET supplier_id = CASE WHEN category = 'Office' THEN 5 END;

--  Perform an INNER JOIN to show product with supplier name

SELECT p.name AS product_name, p.category, p.price, s.supplier_name FROM products p JOIN suppliers S ON s.suppier_id = p.supplier_id;

SELECT p.name AS product_name, p.category, p.price, p.mfg, s.supplier_name, s.contact_email FROM products p JOIN suppliers S ON s.suppier_id = p.supplier_id;


-- LEFT JOIN to include suppliers even if they have no products


SELECT s.supplier_name, p.name AS product_name FROM suppliers s LEFT JOIN products p ON s.suppier_id = p.supplier_id;

-- RIGHT JOIN
SELECT s.supplier_name, s.contact_email, p.name AS product_name FROM suppliers s RIGHT JOIN products p ON s.suppier_id = p.supplier_id;


CREATE TABLE sales(sale_id SERIAL PRIMARY KEY, product_id INT REFERENCES products(id), quantity INT, sale_date DATE);

SELECT * FROM sales;

INSERT INTO sales (product_id, quantity, sale_date) VALUES (1, 3, '2023-06-10'),
(2, 1, '2023-06-11'),
(3, 5, '2023-06-11'),
(4, 2, '2023-06-12'),
(5, 4, '2023-06-13');

SELECT * FROM sales;

SELECT * FROM products;

-- Join products with sales to show total sales value

SELECT p.name, p.price, p.category, s.quantity, (p.price * s.quantity) AS tot_sales_value FROM products p JOIN sales s ON p.id = s.product_id;

-- Find total revenue per category

SELECT p.category, SUM(p.price * s.quantity) AS tot_revenue FROM products p JOIN sales s ON p.id = s.product_id GROUP BY p.category; 

-- Use a subquery to find products with sales above 5000

SELECT name, price, category, id FROM products WHERE id IN (SELECT product_id FROM sales GROUP BY product_id HAVING SUM(price * quantity)>5000);

-- Find top-selling product

SELECT p.name, SUM(s.quantity) AS tot_quantity FROM products p JOIN sales s ON p.id = s.product_id GROUP BY p.name ORDER BY tot_quantity DESC LIMIT 1;

-- Find least-selling product

SELECT p.name, SUM(s.quantity) AS tot_quantity FROM products p JOIN sales s ON p.id = s.product_id GROUP BY p.name ORDER BY tot_quantity ASC LIMIT 1;

-- Add constraint so price cannot be negative

ALTER TABLE products ADD CONSTRAINT chk_price_positive CHECK(price >= 0);

-- Create a function to get discount price

CREATE OR REPLACE FUNCTION get_discounted_price(original_price NUMERIC, discount_percent NUMERIC) RETURNS NUMERIC AS $$ BEGIN RETURN original_price - (original_price * discount_percent / 100); END; $$ LANGUAGE plpgsql;

SELECT name, price, get_discounted_price(price, 15) AS discounted_price FROM products;

-- Create a function to get calculate_gst

CREATE OR REPLACE FUNCTION calculate_gst(original_price NUMERIC, gst_percent NUMERIC) RETURNS NUMERIC AS $$ BEGIN RETURN original_price + (original_price * gst_percent/100); END; $$ LANGUAGE plpgsql;

SELECT name, category, mfg, price, calculate_gst(price, 15) AS calculated_price FROM products;

-- Create a function to get_price_category

CREATE OR REPLACE FUNCTION get_price_category(price NUMERIC) RETURNS TEXT AS $$ BEGIN 
IF price >= 50000 THEN RETURN 'Expensive'; 
ELSEIF price >= 5000 THEN RETURN 'Moderate';
ELSE RETURN 'Budget';
END IF;
END;
$$ LANGUAGE plpgsql;

SELECT name, category, mfg, price, get_price_category(price) AS price_category FROM products;

-- Function to Calculate Total Stock Value

CREATE OR REPLACE FUNCTION tot_stock_value(qty INT, price NUMERIC) RETURNs NUMERIC AS $$
BEGIN RETURN qty * price;
END;
$$ LANGUAGE plpgsql;

SELECT p.name, p.category, p.mfg, p.price, s.quantity, tot_stock_value(s.quantity, p.price) AS tot_stock FROM products p JOIN sales s ON p.id = s.product_id;


--- Function to Format Product Information

CREATE OR REPLACE FUNCTION format_product_information(p_name TEXT, p_price NUMERIC, p_category TEXT) RETURNS TEXT AS $$
BEGIN RETURN 'Product:' || p_name || 'Price:' || p_price || 'Category:' || p_category;
END;
$$ LANGUAGE plpgsql;

SELECT format_product_information(name, price, category) AS foramted_details FROM products;

--- Function to Get Age of a Product (in Days)

CREATE OR REPLACE FUNCTION get_age_of_product(mfg DATE) RETURNS INT AS $$
BEGIN RETURN (CURRENT_DATE - mfg );
END;
$$ LANGUAGE plpgsql;

SELECT name, price, category, mfg, get_age_of_product(mfg) AS age_of_product FROM products;

--- Function to Check if Product is Newly Launched

CREATE OR REPLACE FUNCTION newly_launched(mfg DATE) RETURNS TEXT AS $$
BEGIN 
IF (CURRENT_DATE - mfg) <= 660 THEN RETURN 'New';
ELSE RETURN 'Old';
END IF;
END;
$$ LANGUAGE plpgsql;

SELECT name, price, category, mfg, newly_launched(mfg) AS newly_launched FROM products;

--- Function to Calculate Taxed Price

CREATE OR REPLACE FUNCTION get_taxed_price(price NUMERIC, tax_rate NUMERIC DEFAULT 18) RETURNS NUMERIC AS $$
BEGIN
RETURN price + (price * tax_rate / 100);
END;
$$ LANGUAGE plpgsql;


SELECT name, category, price, get_taxed_price(price, 18) AS taxed_price FROM products;

--- Function to Return Category-wise Message

CREATE OR REPLACE FUNCTION get_category_wise_message(category TEXT) RETURNS TEXT AS $$
BEGIN
CASE category
WHEN 'Electronics' THEN RETURN 'Handle with care - Fragile item';
WHEN 'Home' THEN RETURN 'Handle with care - general item';
WHEN 'Apparel' THEN RETURN 'Wash gently - Delicate fabric';
WHEN 'Books' then return 'Keep away from moisture';
ELSE RETURN 'General item';
END CASE;
END;
$$ LANGUAGE plpgsql;

SELECT name, price, category, get_category_wise_message(category) FROM products;

--- Function to Convert Price to USD

CREATE OR REPLACE FUNCTION convert_price_to_usd(price NUMERIC) RETURNS NUMERIC AS $$
DECLARE usd_rate NUMERIC := 8.23;
BEGIN
RETURN ROUND(price / usd_rate, 2);
END;
$$ LANGUAGE plpgsql;

SELECT name, price, category, convert_price_to_usd(price) AS converted_value FROM products;

CREATE VIEW supplier_revenue AS SELECT s.supplier_name, SUM(p.price * sa.quantity) AS total_revenue FROM suppliers s JOIN products p ON p.id = s.suppier_id JOIN sales s ON sa.product_id = p.id GROUP BY s.supplier_name;

SELECT * FROM supplier_revenue;

SELECT supplier_name, total_revenue FROM supplier_revenue ORDER BY total_revenue DESC LIMIT 1;

-- Add a trigger to automatically update price history

CREATE TABLE price_history( history_id SERIAL PRIMARY KEY, product_id INT, old_price NUMERIC(10, 2), new_price NUMERIC(10, 2), changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

SELECT * FROM price_history;

CREATE OR REPLACE FUNCTION log_price_change() RETURNS TRIGGER AS $$
BEGIN
IF NEW.price <> OLD.price THEN INSERT INTO price_history(product_id, old_price, new_price) VALUES (old.id, OLD.price, NEW.price);
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_price_update AFTER UPDATE OF price ON products FOR EACH ROW EXECUTE FUNCTION log_price_change();

-- Check price history log

UPDATE products SET price = price * 1.05 WHERE id = 1;

UPDATE products SET price = price * 1.06 WHERE id = 2;

UPDATE products SET price = price * 1.07 WHERE id = 3;

SELECT * FROM price_history;

--- Log inserted products into an audit table

CREATE TABLE product_audit(audit_id SERIAL PRIMARY KEY, product_id INT, name VARCHAR(100), price NUMERIC(10, 2), logged_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE OR REPLACE FUNCTION log_new_product() RETURNS TRIGGER AS $$
BEGIN 
INSERT INTO product_audit(product_id, name, price)
VALUES (NEW.id, NEW.name, NEW.price);

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_new_product
AFTER INSERT ON products 
FOR EACH ROW
EXECUTE FUNCTION log_new_product();

INSERT INTO products(name, category, price)
VALUES('Test Product', 'Electronics', 999);

SELECT * FROM product_audit;

--- Prevent negative quantity in sales (BEFORE INSERT)

CREATE OR REPLACE FUNCTION prevent_negative_quantity()
RETURNS TRIGGER AS $$
BEGIN 
IF NEW.quantity < 0 THEN 
RAISE EXCEPTION 'Quantity cannot be negative!';
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_negative_quantity
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_quantity();

INSERT INTO sales (product_id, quantity, sale_date)
VALUES (1, -7, '2024-01-01');

SELECT * FROM sales;

-- Automatically set sale_value in sales table

ALTER TABLE sales ADD COLUMN sale_value NUMERIC(10, 2);

CREATE OR REPLACE FUNCTION calculate_sale_value()
RETURNS TRIGGER AS $$
DECLARE product_price NUMERIC;
BEGIN
SELECT price INTO product_price FROM products WHERE id = NEW.product_id;

NEW.sale_value = product_price * NEW. quantity;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_sale_value()
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION calculate_sale_value();

INSERT INTO sales(product_id, quantity, sale_date)
VALUES (2, 4, '2024-01-01');

SELECT * FROM sales;

-- Save deleted product details into a deleted_products

CREATE TABLE deleted_products( del_id SERIAL PRIMARY KEY, product_id INT, name VARCHAR(100), price NUMERIC(10, 2), deleted_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE OR REPLACE FUNCTION log_deleted_product()
RETURNS TRIGGER AS $$
BEGIN 
INSERT INTO deleted_products(product_id, name, price)
VALUES (OLD.id, OLD.name, OLD.price);

RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_deleted_product
AFTER DELETE ON products
FOR EACH ROW
EXECUTE FUNCTION log_deleted_product();

DELETE FROM sales WHERE product_id = 3;
DELETE FROM products WHERE id = 3;

SELECT * FROM deleted_products;


ALTER TABLE products ADD COLUMN qty INT DEFAULT 0;

CREATE TABLE stock_history (log_id SERIAL PRIMARY KEY, product_id INT, old_qty INT, new_qty INT, changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE OR REPLACE FUNCTION log_stock_update()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.qty <> OLD.qty THEN 
    INSERT INTO stock_history(product_id, old_qty, new_qty)
    VALUES (OLD.id, OLD.qty, NEW.qty);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_stock_update
AFTER UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION log_stock_update()

UPDATE products SET qty = qty + 10 WHERE id = 19;

SELECT * FROM stock_history;

-- If someone tries to insert a negative price, automatically set it to 0.

CREATE OR REPLACE FUNCTION validate_price_before_insert()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.price < 0 THEN
   NEW.price := 0;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_price_before_insert
BEFORE INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION validate_price_before_insert();

INSERT INTO products(name, price,category, mfg)
VALUES ('Skirt', -599, 'Apparel', '2025-01-22');

SELECT * FROM products WHERE name = 'Skirt';

-- Create a trigger to automatically reduce product stock when a sale is made

CREATE OR REPLACE FUNCTION reduce_stock_on_sale()
RETURNS TRIGGER AS $$
BEGIN 
UPDATE products
SET qty = qty - NEW.quantity
WHERE id = NEW.product_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_reduce_stock_on_sale
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION reduce_stock_on_sale();

INSERT INTO sales (product_id, quantity, sale_date, sale_value)
VALUES (19, 1, CURRENT_DATE, '5800');

SELECT * FROM products WHERE ID = 19;

--- Create a function to calculate loyalty points

CREATE OR REPLACE FUNCTION calc_points(amount NUMERIC)
RETURNS NUMERIC AS $$
BEGIN 
RETURN(amount / 100) * 2;
END;
$$ LANGUAGE plpgsql;

SELECT calc_points(500) AS loyal_points;

--- Create a view showing total stock value (qty × price)

CREATE VIEW products_stock_value AS SELECT id, name, price, qty, (qty * price) AS stock_value FROM products; 

SELECT * FROM products_stock_value;

--- Write a query to find products with ZERO stock

SELECT * FROM products WHERE qty = 0;

--- Write a query to find suppliers with NO product using left join

SELECT s.supplier_name FROM suppliers s LEFT JOIN products p ON s.suppier_id = p.supplier_id WHERE p.id is NULL; 

--- Create a trigger to log low stock alerts (< 5 qty)

CREATE TABLE low_stock_alerts(alert_id SERIAL PRIMARY KEY, product_id INT, qty INT, alert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

SELECT * FROM low_stock_alerts;

CREATE OR REPLACE FUNCTION alert_low_stock()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.qty < 5 THEN
INSERT INTO low_stock_alerts(product_id, qty)
VALUES (NEW.product_id, NEW.qty);
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_low_stock_alerts
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION alert_low_stock();

UPDATE products SET qty = 3 WHERE id = 20;

SELECT * FROM low_stock_alerts;

--- Find the second highest product price without using LIMIT

SELECT * FROM products;

SELECT MAX(price) FROM products WHERE price < (SELECT MAX(price) FROM products);

--- Get products whose price is above the average price

SELECT * FROM products WHERE price < (SELECT AVG(price) FROM products);

--- Get duplicate product names (if any)

SELECT name, COUNT(*) FROM products GROUP BY name HAVING COUNT(*) > 1;

--- Rank products by price using RANK()

SELECT id, name, price, RANK() OVER (ORDER BY price DESC) AS price_rank FROM products;

--- Get top product per category using ROW_NUMBER()

SELECT * FROM (SELECT id, name, price, category, ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS rn FROM products) x WHERE rn = 1;

--- Recursive CTE to generate numbers from 1 to 100

WITH RECURSIVE nums(n) AS (
SELECT 1
UNION ALL SELECT n + 1 FROM nums WHERE n < 100
)
SELECT * FROM nums;

--- Function to execute any SQL passed as input

CREATE OR REPLACE FUNCTION run_dynamic(q text) 
RETURNS SETOF products AS $$
BEGIN
RETURN QUERY EXECUTE q;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM run_dynamic('SELECT * FROM products');
AS t(id INT, name TEXT, price NUMERIC, category TEXT, qty INT);

DROP FUNCTION IF EXISTS run_dynamic(text);

--- Dynamic INSERT Into Any Table

CREATE OR REPLACE FUNCTION dynamic_insert(tbl TEXT, cols TEXT, vals TEXT)
RETURNS void AS $$
BEGIN
EXECUTE format('INSERT INTO %I (%s) VALUES (%s)', tbl, cols, vals);
END;
$$ LANGUAGE plpgsql;

SELECT dynamic_insert( 'products', 'name, price, category, qty',quote_literal('Dynamic Pen') || ', 15.50, ' || quote_literal('Office') || ', 100');

SELECT * FROM products;

CREATE OR REPLACE FUNCTION dyc_update(tbl TEXT, set_sql TEXT, cond TEXT)
RETURNS void AS $$
BEGIN 
EXECUTE format('UPDATE %I SET %s WHERE %s', tbl, set_sql, cond);
END;
$$ LANGUAGE plpgsql;

SELECT dyc_update('products', 'price = price * 2.10', 'category = ''Books''');

SELECT * FROM products WHERE category = 'Books';
--- ANALYTICS QUERIES (WINDOW + AGGREGATION)
--- Month-wise sales revenue trend (with running total)

SELECT date_trunc('month', sale_date) AS month, SUM(quantity * p.price) AS month_revenue, SUM(SUM(quantity * p.price)) OVER (ORDER BY date_trunc('month', sale_date)) AS cummulative_revenue
FROM sales s JOIN products p ON p.id = s.product_id GROUP BY month;

--- Daily sales difference compared to previous day (LAG)

SELECT sale_date, SUM(quantity) AS qty_sold, LAG(SUM(quantity)) OVER (ORDER BY sale_date) AS prev_day_qty, SUM(quantity)-LAG(SUM(quantity)) OVER (ORDER BY sale_date) AS diff FROM sales GROUP BY sale_date;

--- STOCK INTELLIGENCE QUERIES
--- Find products that are selling fast but stock hasn't been updated recently

SELECT p.id, p.name, p.qty, (SELECT SUM(quantity) FROM sales where product_id = p.id) AS total_sales, (SELECT MAX(changed_on) FROM stock_history WHERE product_id = p.id) AS last_stock_update FROM products p WHERE p.qty < 20 
AND NOT EXISTS (SELECT 1 FROM stock_history sh  WHERE sh.product_id = p.id AND sh.changed_on > NOW() - INTERVAL '7 days');

--- Detect stock mismatch between “active_inventory” and “products”

SELECT p.id, p.name, p.qty AS product_qty, ai.stock AS inventory_qty FROM products p JOIN active_inventory ai ON ai.name = p.name WHERE p.qty <> ai.stock; 

SELECT
    date_trunc('month', s.sale_date) AS month,
    SUM(s.quantity * p.price) AS month_revenue,
    SUM(SUM(s.quantity * p.price)) OVER (
        ORDER BY date_trunc('month', s.sale_date)
    ) AS running_total
FROM sales s
JOIN products p ON p.id = s.product_id
GROUP BY date_trunc('month', s.sale_date)
ORDER BY month;


/* products whose monthly sales quantity increases every month */

WITH monthly_sales AS ( SELECT product_id, date_trunc('month', sale_date) AS month, SUM(quantity) AS total_qty FROM sales GROUP BY product_id, date_trunc('month', sale_date)),
trend AS (SELECT product_id, month, total_qty, LAG(total_qty) OVER (PARTITION BY product_id ORDER BY month) AS prev_qty FROM monthly_sales) 
SELECT * FROM trend WHERE prev_qty IS NOT NULL AND total_qty > prev_qty;

/* products that have never been sold */

SELECT p.* FROM products p LEFT JOIN sales s ON s.product_id = p.id WHERE s.product_id IS NULL;

SELECT id, name FROM products ORDER BY id;

/* Insert December 2024 Sales*/
INSERT INTO sales(product_id, quantity, sale_date) VALUES (1, 10, '2024-12-05'),(2, 5,  '2024-12-10'),(4, 7,  '2024-12-15');

/* Insert january 2025 sales*/
INSERT INTO sales(product_id, quantity, sale_date) VALUES (1, 20, '2025-01-05'),(2, 12, '2025-01-08'),(5, 3,  '2025-01-18');

/* Insert februry 2025 sales*/
INSERT INTO sales(product_id, quantity, sale_date) VALUES (1, 8, '2025-02-01'),(2, 15, '2025-02-12'),(4, 4, '2025-02-20');

/* find 'consistent perfrmers' -> products that sold every month */

WITH months AS (SELECT DISTINCT date_trunc('month', sale_date) AS month FROM sales WHERE sale_date >= '2024-12-01' AND sale_date <= '2025-02-28'), 
sales_per_month AS (SELECT product_id, date_trunc('month', sale_date) AS month FROM sales WHERE sale_date >= '2024-12-01' AND sale_date <= '2025-02-28' GROUP BY product_id, date_trunc('month', sale_date))
SELECT product_id FROM sales_per_month GROUP BY product_id HAVING COUNT(*) = (SELECT COUNT(*) FROM months);

SELECT DISTINCT date_trunc('month', sale_date) AS month FROM sales ORDER BY month;

/* find top 2 selling products per category using window functions */

WITH total_sales AS (SELECT p.category, p.name, SUM(s.quantity) AS total_qty FROM products p JOIN sales s ON p.id= s.product_id GROUP BY p.category, p.name)
SELECT * FROM (SELECT category, name, total_qty, ROW_NUMBER() OVER (PARTITION BY category ORDER  BY total_qty DESC) AS rn FROM total_sales) t WHERE rn <=2;

/* rolling 3 - onth sales average(moving average)*/

WITH ms AS (SELECT date_trunc('month', sale_date) AS month, SUM(quantity) AS qty FROM sales GROUP BY date_trunc('month', sale_date))
SELECT month, qty, AVG(qty) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3_month FROM ms;

/*Identity Price Increase Events(Compare with price history)*/

SELECT product_id, old_price, new_price, (new_price - old_price) AS difference, changed_on FROM price_history WHERE new_price > old_price;

/*Detect inventory mismatch between product.qty and active_inventory.stock*/

SELECT p.id, p.name, p.qty AS product_qty, ai.stock AS inventory_stock FROM products p JOIN active_inventory ai ON ai.name = p.name WHERE p.qty <> ai.stock;

/*get total revenue per supplier*/

SELECT s.supplier_name, SUM(p.price * sa.quantity) AS revenue FROM suppliers s JOIN products p ON p.supplier_id = s.supplier_id JOIN sales sa ON sa.product_id = p.id GROUP BY s.supplier_name ORDER BY revenue DESC;

/*Find out of stock products (qty = 0) + last time they sold*/

SELECT p.name, p.category, p.qty, MAX(s.sale_date) AS last_sold_date FROM products p LEFT JOIN sales s ON p.id = s.product_id WHERE qty = 0 GROUP BY p.name, p.category, p.qty;

/*detect products deleted after they had sales*/

SELECT dp.product_id, dp.name, dp.price, (SELECT COUNT(*) FROM sales WHERE product_id = dp.product_id) AS total_sales FROM deleted_products dp; 

/*recursive category report (hierarcy simulation)*/

WITH RECURSIVE cat AS (SELECT id, category, 1 AS level FROM products UNION ALL SELECT p.id, p.category, c.level + 1 FROM products p JOIN cat c ON p.category = c.category WHERE c.level < 3) SELECT * FROM cat;

/* find the fasted selling product */

SELECT id, name, (SELECT SUM(quantity) FROM sales WHERE product_id = p.id) / (CURRENT_DATE - mfg) AS sales_speed FROM products p;/*check for price anomalies - products priced far above category avg*/

WITH cat_avg AS (SELECT category, AVG(price) AS avg_price FROM products GROUP BY category) SELECT p.name, p.price, c.avg_price, (p.price - c.avg_price) AS differnec FROM products p JOIN cat_avg c ON p.category = c.category WHERE p.price > c.avg_price * 1.5;

/*find days with no sales (calendr join)*/

WITH RECURSIVE dates AS (SELECT MIN(sale_date)::timestamp AS dt FROM sales UNION ALL SELECT dt + INTERVAL '1 day'FROM dates WHERE dt + INTERVAL '1 day' <= (SELECT MAX(sale_date) FROM sales)) SELECT dt FROM dates d LEFT JOIN sales s ON s.sale_date = d.dt WHERE s.sale_date IS NULL;

/* Create a materialized view for fast analytics*/

CREATE MATERIALIZED VIEW product_sales_summary AS SELECT p.id, p.name, SUM(s.quantity) AS total_qty, SUM(s.quantity * p.price) AS total_revenue FROM products p LEFT JOIN sales s ON s.product_id = p.id GROUP BY p.id, p.name;

REFRESH MATERIALIZED VIEW product_sales_summary;

/* calculate cumulative sales by month using Range window frame*/

SELECT product_id, date_trunc('month', sale_date) AS month, SUM(quantity) AS monthly_qty, SUM(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY date_trunc('month', sale_date) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM sales GROUP BY product_id, month ORDER BY product_id, month;


/* window function with GROUPS*/
/* Rank only when the price price gap is >= 50 using GROUPS frame*/

SELECT id, name, price, RANK() OVER(ORDER BY price DESC GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS group_rank FROM products;

/*LATERAL JOIN */
/* get each product + its latest pice from price_history*/

SELECT p.id, p.name, ph.latest_price FROM products p CROSS JOIN LATERAL (SELECT price as latest_price FROM price_history WHERE product_id = p.id ORDER BY changed_on DESC LIMIT 1)ph;

/*Lateral Join with filtering*/
/*get the highest sale quantity per product*/

SELECT p.id, p.name, s.max_qty FROM products p LEFT JOIN LATERAL (SELECT quantity AS max_qty FROM sales WHERE product_id = p.id ORDER BY quantity DESC LIMIT 1) s ON true;

/* PIVOT (using FILTER) - Convert rows -> columns*/
/* show sales for each month in columns */

SELECT product_id, 
SUM(quantity) FILTER (WHERE date_part('month', sale_date) = 12) AS dec_sales, 
SUM(quantity) FILTER (WHERE date_part('month', sale_date) = 1) AS jan_sales,
SUM(quantity) FILTER (WHERE date_part('month', sale_date) = 2) AS fab_sales FROM sales GROUP BY product_id;

/* UNPIVOT -> convert column -> rows */
/* manual unpivot using UNION ALL */

WITH sales_monthly AS (SELECT product_id, to_char(sale_date, 'YYYY-MM') AS month, SUM(quantity) AS qty FROM sales GROUP BY product_id, to_char(sale_date, 'YYYY-MM')),
pivoted AS (SELECT product_id, 
SUM(CASE WHEN month = '2024-10' THEN qty END) AS oct,
SUM(CASE WHEN month = '2024-11' THEN qty END) AS nov,
SUM(CASE WHEN month = '2024-12' THEN qty END) AS dec,
SUM(CASE WHEN month = '2025-01' THEN qty END) AS jan,
SUM(CASE WHEN month = '2025-02' THEN qty END) AS feb,
SUM(CASE WHEN month = '2025-03' THEN qty END) AS march
FROM sales_monthly GROUP BY product_id)SELECT * FROM pivoted;

/* convert full product recorrd to json*/

SELECT id, to_json(products.*) AS product_json FROM products;

/* json aggregation - products grouped by category*/

SELECT category, json_agg(json_build_object('id', id, 'name', name, 'price', price)) AS product_list FROM products GROUP BY category;

/* full text search - find products with 'books' or similar words */

SELECT * FROM products WHERE to_tsvector(name) @@ to_tsquery('books:*');

/* index optimization - find missing indexs */

SELECT relname, seq_scan, idx_scan FROM pg_stat_user_tables ORDER BY seq_scan DESC;

/* Locking & Concurrency - see current locks */

SELECT pid, locktype, mode, granted, relation::regclass FROM pg_locks WHERE NOT granted;


/* Trigger on multiple tables - aduit sales + products */

CREATE OR REPLACE FUNCTION audit_product_and_sales()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO product_audit(product_id, action, event_name)
VALUES (NEW.product_id, TG_OP, NOW());
RETURN NEW;
END;
$$ LANGUAGE plpgsql;