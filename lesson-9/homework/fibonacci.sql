DROP TABLE IF EXISTS FibonacciNumbers;
CREATE TABLE FibonacciNumbers (
    n INT,
    Fibonacci_Number BIGINT
);


TRUNCATE TABLE FibonacciNumbers;

WITH FibonacciRes (n, Fibonacci_Number, Prev_Number) AS (
    SELECT 1, 1, 0  -- Start from n=1
    UNION ALL
    SELECT n + 1, Fibonacci_Number + Prev_Number, Fibonacci_Number
    FROM FibonacciRes
    WHERE n < 10
)
INSERT INTO FibonacciNumbers (n, Fibonacci_Number)
SELECT n, Fibonacci_Number
FROM FibonacciRes
ORDER BY n;

SELECT * FROM FibonacciNumbers
ORDER BY n;







