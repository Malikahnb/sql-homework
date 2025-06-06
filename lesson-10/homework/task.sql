use class1;
go

DROP TABLE IF EXISTS Shipments;
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

-- inserting the values given in the table
INSERT INTO Shipments (N, Num) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 6),
(33, 7);

--- finding theh median
WITH AllDays AS (
    SELECT TOP (40) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS DayNum
    FROM sys.all_objects -- This is just a big table used to generate 40 rows
),
ShipmentsWithZeros AS (
    SELECT 
        a.DayNum,
        ISNULL(s.Num, 0) AS Num
    FROM 
        AllDays a
    LEFT JOIN 
        Shipments s ON a.DayNum = s.N
)
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Num) OVER () AS MedianValue
FROM 
    ShipmentsWithZeros;
