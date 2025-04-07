DROP TABLE IF EXISTS worker;
CREATE TABLE worker (
    id INT,
    name VARCHAR(100)
);

BULK INSERT worker
FROM 'E:\MAAB\sql-homeworks\lesson-2\homework\worker.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1
);

SELECT * FROM worker;


