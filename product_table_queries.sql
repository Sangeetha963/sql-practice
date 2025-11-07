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






