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

