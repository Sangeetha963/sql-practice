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

