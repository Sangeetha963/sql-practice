-- ShopEase SQL Practice

CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL,
    category TEXT
);

INSERT INTO products (name, price, category) VALUES
('Laptop', 55000, 'Electronics'),
('T-shirt', 799, 'Fashion'),
('Cooker', 2500, 'Home'),
('Book - Flutter Guide', 499, 'Books');

SELECT * FROM products;

-- Create customers table
CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    city TEXT
);

-- Insert sample customers
INSERT INTO customers (name, email, city) VALUES
('Sangeetha', 'sangeetha@example.com', 'Bangalore'),
('Ravi', 'ravi@example.com', 'Chennai'),
('Divya', 'divya@example.com', 'Hyderabad'),
('Arun', 'arun@example.com', 'Bangalore');

SELECT * FROM customers;

-- Create orders table
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    order_date TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert some sample orders
INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2025-10-30'),  -- Sangeetha bought a Laptop
(2, 2, 3, '2025-10-29'),  -- Ravi bought 3 T-shirts
(3, 4, 1, '2025-10-28'),  -- Divya bought a Flutter book
(4, 3, 2, '2025-10-27');  -- Arun bought 2 Cookers

SELECT * FROM orders;

