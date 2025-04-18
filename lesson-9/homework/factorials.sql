DROP TABLE IF EXISTS FactorialResults;
CREATE TABLE FactorialResults (
    Num INT PRIMARY KEY,
    Factorial BIGINT
);

WITH Factorials AS (
    SELECT
        1 AS Num,
        CAST(1 AS BIGINT) AS Factorial
    UNION ALL
    SELECT
        Num + 1,
        CAST((Num + 1) AS BIGINT) * Factorial
    FROM Factorials
    WHERE Num < 10 
)


SELECT
    Num, Factorial
FROM Factorials
ORDER BY Num;