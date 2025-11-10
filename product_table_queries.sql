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



