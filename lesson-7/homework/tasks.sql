use class1;
go

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-- Insert Customers
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Davis'),
(4, 'Diana Moore');

-- Insert Products
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Office Chair', 'Furniture'),
(4, 'Coffee Mug', 'Kitchenware');

-- Insert Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-04-10'),
(2, 2, '2025-04-11'),
(3, 1, '2025-04-12'),
(4, 3, '2025-04-13');

-- Insert OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 999.99),
(2, 1, 4, 2, 9.99),
(3, 2, 2, 1, 699.99),
(4, 3, 3, 1, 149.99),
(5, 4, 4, 3, 8.99);


----- 1. Retrieve all customers with the orders
SELECT 
    Customers.CustomerID,
    Customers.CustomerName,
    Orders.OrderID,
    Orders.OrderDate
FROM 
    Customers
LEFT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY 
    Customers.CustomerID;


	---- 2 
SELECT 
    Customers.CustomerID,
    Customers.CustomerName
FROM 
    Customers
LEFT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
WHERE 
    Orders.OrderID IS NULL;


	--- 3
SELECT 
    Orders.OrderID,
    Orders.CustomerID,
    Products.ProductName,
    OrderDetails.Quantity
FROM 
    Orders
INNER JOIN 
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
ORDER BY 
    Orders.OrderID;


	--- 4
SELECT 
    Customers.CustomerID,
    Customers.CustomerName,
    COUNT(Orders.OrderID) AS TotalOrders
FROM 
    Customers
INNER JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY 
    Customers.CustomerID, Customers.CustomerName
HAVING 
    COUNT(Orders.OrderID) > 1;


	---5
SELECT 
    o.OrderID,
    p.ProductName,
    od.Price
FROM 
    OrderDetails od
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
INNER JOIN 
    Orders o ON od.OrderID = o.OrderID
WHERE 
    od.Price = (
        SELECT MAX(Price)
        FROM OrderDetails
        WHERE OrderID = od.OrderID
    )
ORDER BY 
    o.OrderID;


	--- 6
SELECT 
    o.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.CustomerID = c.CustomerID
WHERE 
    o.OrderDate = (
        SELECT MAX(OrderDate)
        FROM Orders
        WHERE CustomerID = o.CustomerID
    )
ORDER BY 
    o.CustomerID;


	-- 7 
SELECT 
    c.CustomerID,
    c.CustomerName
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(DISTINCT CASE WHEN p.Category <> 'Electronics' THEN p.ProductID END) = 0;


--- 8 
SELECT DISTINCT 
    c.CustomerID,
    c.CustomerName
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.Category = 'Stationery'
ORDER BY 
    c.CustomerID;


	--- 9 
SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CustomerName
ORDER BY 
    TotalSpent DESC;

