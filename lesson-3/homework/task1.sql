use lesson3;
go
-- Creating the table structure
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- Inserting the data into the tables
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES 
    (1, 'Alice', 'Johnson', 'HR', 60000, '2019-03-15'),
    (2, 'Bob', 'Smith', 'IT', 85000, '2018-07-20'),
    (3, 'Charlie', 'Brown', 'Finance', 95000, '2017-01-10'),
    (4, 'David', 'Williams', 'HR', 50000, '2021-05-22'),
    (5, 'Emma', 'Jones', 'IT', 110000, '2016-12-02'),
    (6, 'Frank', 'Miller', 'Finance', 40000, '2022-06-30'),
    (7, 'Grace', 'Davis', 'Marketing', 75000, '2020-09-14'),
    (8, 'Henry', 'White', 'Marketing', 72000, '2020-10-10'),
    (9, 'Ivy', 'Taylor', 'IT', 95000, '2017-04-05'),
    (10, 'Jack', 'Anderson', 'Finance', 105000, '2015-11-12');

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status)
VALUES 
    (101, 'John Doe', '2023-01-15', 2500, 'Shipped'),
    (102, 'Mary Smith', '2023-02-10', 4500, 'Pending'),
    (103, 'James Brown', '2023-03-25', 6200, 'Delivered'),
    (104, 'Patricia Davis', '2023-05-05', 1800, 'Cancelled'),
    (105, 'Michael Wilson', '2023-06-14', 7500, 'Shipped'),
    (106, 'Elizabeth Garcia', '2023-07-20', 9000, 'Delivered'),
    (107, 'David Martinez', '2023-08-02', 1300, 'Pending'),
    (108, 'Susan Clark', '2023-09-12', 5600, 'Shipped'),
    (109, 'Robert Lewis', '2023-10-30', 4100, 'Cancelled'),
    (110, 'Emily Walker', '2023-12-05', 9800, 'Delivered');

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES 
    (1, 'Laptop', 'Electronics', 1200, 15),
    (2, 'Smartphone', 'Electronics', 800, 30),
    (3, 'Desk Chair', 'Furniture', 150, 5),
    (4, 'LED TV', 'Electronics', 1400, 8),
    (5, 'Coffee Table', 'Furniture', 250, 0),
    (6, 'Headphones', 'Accessories', 200, 25),
    (7, 'Monitor', 'Electronics', 350, 12),
    (8, 'Sofa', 'Furniture', 900, 2),
    (9, 'Backpack', 'Accessories', 75, 50),
    (10, 'Gaming Mouse', 'Accessories', 120, 20);


	-- Selects the top 10% highest-paid employees.
WITH RankedEmployees AS (
    SELECT *,
           NTILE(10) OVER (ORDER BY Salary DESC) AS SalaryTile
    FROM Employees
)
SELECT *
FROM RankedEmployees
WHERE SalaryTile = 1;


	-- Groups them by department and calculates the average salary per department.
WITH RankedEmployees AS (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
Top10Percent AS (
    SELECT *
    FROM RankedEmployees
    WHERE SalaryRank <= 0.10
)
SELECT Department,
       AVG(Salary) AS AverageSalary
FROM Top10Percent
GROUP BY Department;



	--Displays a new column SalaryCategory:
		--'High' if Salary > 80,000
		--'Medium' if Salary is between 50,000 and 80,000
		--'Low' otherwise.
WITH RankedEmployees AS (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
Top10Percent AS (
    SELECT *
    FROM RankedEmployees
    WHERE SalaryRank <= 0.10
),
Categorized AS (
    SELECT Department,
           Salary,
           CASE
               WHEN Salary > 80000 THEN 'High'
               WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
               ELSE 'Low'
           END AS SalaryCategory
    FROM Top10Percent
)
SELECT Department,
       SalaryCategory,
       AVG(Salary) AS AverageSalary
FROM Categorized
GROUP BY Department, SalaryCategory;

	-- Orders the result by AverageSalary descending.
WITH RankedEmployees AS (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
Top10Percent AS (
    SELECT *
    FROM RankedEmployees
    WHERE SalaryRank <= 0.10
),
Categorized AS (
    SELECT Department,
           Salary,
           CASE
               WHEN Salary > 80000 THEN 'High'
               WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
               ELSE 'Low'
           END AS SalaryCategory
    FROM Top10Percent
),
DepartmentAverages AS (
    SELECT Department,
           SalaryCategory,
           AVG(Salary) AS AverageSalary
    FROM Categorized
    GROUP BY Department, SalaryCategory
)
SELECT *
FROM DepartmentAverages
ORDER BY AverageSalary DESC;


	-- Skips the first 2 records and fetches the next 5.
WITH RankedEmployees AS (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
Top10Percent AS (
    SELECT *
    FROM RankedEmployees
    WHERE SalaryRank <= 0.10
),
Categorized AS (
    SELECT Department,
           Salary,
           CASE
               WHEN Salary > 80000 THEN 'High'
               WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
               ELSE 'Low'
           END AS SalaryCategory
    FROM Top10Percent
),
DepartmentAverages AS (
    SELECT Department,
           SalaryCategory,
           AVG(Salary) AS AverageSalary
    FROM Categorized
    GROUP BY Department, SalaryCategory
)
SELECT *
FROM DepartmentAverages
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;
