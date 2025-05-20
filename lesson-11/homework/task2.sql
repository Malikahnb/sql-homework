
DROP TABLE IF EXISTS Orders_DB1;
CREATE TABLE Orders_DB1 (
    OrderID INT,
    CustomerName NVARCHAR(50),
    Product NVARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

DROP TABLE IF EXISTS Orders_DB2;
CREATE TABLE Orders_DB2 (
    OrderID INT,
    CustomerName NVARCHAR(50),
    Product NVARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

-- Step 2: Declare the table variable for missing orders
DECLARE @MissingOrders TABLE (
    OrderID INT,
    CustomerName NVARCHAR(50),
    Product NVARCHAR(50),
    Quantity INT
);

-- Step 3: Insert missing orders from Orders_DB1 not found in Orders_DB2
INSERT INTO @MissingOrders (OrderID, CustomerName, Product, Quantity)
SELECT o1.OrderID, o1.CustomerName, o1.Product, o1.Quantity
FROM Orders_DB1 o1
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders_DB2 o2
    WHERE o1.OrderID = o2.OrderID
);

-- Step 4: Retrieve the missing orders
SELECT * FROM @MissingOrders;
