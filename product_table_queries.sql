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






