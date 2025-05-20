use homework1;
go


-- Step 1: Create the WorkLog table and insert sample data (for testing)

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName NVARCHAR(50),
    Department NVARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked) VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

GO
-- Step 2: Create the view that summarizes work per employee and department

CREATE VIEW vw_MonthlyWorkSummary AS
SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.Department,
    SUM(E.HoursWorked) AS TotalHoursWorked,
    D.TotalHoursDepartment,
    D.AvgHoursDepartment
FROM WorkLog E
JOIN (
    SELECT 
        Department,
        SUM(HoursWorked) AS TotalHoursDepartment,
        AVG(CAST(HoursWorked AS FLOAT)) AS AvgHoursDepartment
    FROM WorkLog
    GROUP BY Department
) D ON E.Department = D.Department
GROUP BY E.EmployeeID, E.EmployeeName, E.Department, D.TotalHoursDepartment, D.AvgHoursDepartment;

-- Step 3: Retrieve records from the view
SELECT * FROM vw_MonthlyWorkSummary;
