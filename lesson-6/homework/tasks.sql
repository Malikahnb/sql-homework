DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT NULL,
    Salary DECIMAL(10,2) NOT NULL
	CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

DROP TABLE IF EXISTS Projects;
CREATE TABLE Projects (
    ProjectsID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectsName VARCHAR(50) NOT NULL,
    EmployeeID INT NULL
);

ALTER TABLE Projects
ADD CONSTRAINT FK_Projects_Employees
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);



INSERT INTO Departments (DepartmentID, DepartmentName) VALUES 
    (101, 'IT'),
    (102, 'HR'),
    (103, 'Finance'),
    (104, 'Marketing');

INSERT INTO Employees (Name, DepartmentID, Salary) VALUES
    ('Alice', 101, 50000),
    ('Bob', 102, 60000),
    ('Charlie', 101, 70000),
    ('David', 103, 80000),
    ('Eve', NULL, 90000);

INSERT INTO Projects (ProjectsName, EmployeeID) VALUES
	('Alpha', 1),
	('Beta', 2),
	('Gamma', 1),
	('Delta', 4),
	('Omega', NULL);


-- INNER JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- LEFT JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- RIGHT JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID;


-- FULL OUTER JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- JOIN WITH AGGREGATION
SELECT d.DepartmentName, SUM(e.Salary) AS TotalSalary
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-- CROSS HJOIN
SELECT d.DepartmentName, p.ProjectsName
FROM Departments d
CROSS JOIN Projects p;

-- MULTIPE JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName, p.ProjectsName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN Projects p ON e.EmployeeID = p.EmployeeID;
