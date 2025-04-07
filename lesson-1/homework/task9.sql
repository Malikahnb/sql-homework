/*
Book (Stores information about books)
book_id (Primary Key)
title (Text)
author (Text)
published_year (Integer)

Member (Stores information about library members)
member_id (Primary Key)
name (Text)
email (Text)
phone_number (Text)

Loan (Tracks which members borrow which books)
loan_id (Primary Key)
book_id (Foreign Key ? References book.book_id)
member_id (Foreign Key ? References member.member_id)
loan_date (Date)
return_date (Date, can be NULL if not returned yet)
 */

 drop table Loan; 
CREATE TABLE Book (
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL CHECK (title <> ''),
    published_year INT,
    author VARCHAR(255)
);


CREATE TABLE Member (
    member_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY IDENTITY(1,1),
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);


-- Inserting data 
INSERT INTO Book (title, author, published_year)
VALUES
('The Catcher in the Rye', 'J.D. Salinger', 1951),
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949);


INSERT INTO Member (name, email, phone_number)
VALUES
('Alice Johnson', 'alice@example.com', '555-1234'),
('Bob Smith', 'bob@example.com', '555-5678'),
('Charlie Davis', 'charlie@example.com', '555-9012');


INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES
(1, 1, '2025-04-01', '2025-04-07'),
(2, 1, '2025-04-03', NULL),
(3, 2, '2025-04-02', NULL);
