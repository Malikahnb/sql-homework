/*
All at once
Create a books table with:
book_id (integer, primary key, auto-increment)
title (string, must not be empty)
price (decimal, must be greater than 0)
genre (string, default should be 'Unknown')
Insert data and test if all constraints work as expected.
 */

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL CHECK (title <> ''),
    price DECIMAL(10,2) CHECK (price > 0),
    genre VARCHAR(255) DEFAULT 'Unknown'
);

-- Insert test data
INSERT INTO books (title, price, genre) VALUES ('The Great Gatsby', 10.99, 'Fiction');
INSERT INTO books (title, price) VALUES ('1984', 9.99);

-- Verify constraints
SELECT * FROM books;


