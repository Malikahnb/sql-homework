DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
    id INT PRIMARY KEY,
    image VARBINARY(MAX)
);

INSERT INTO photos (id, image)
select 1, BulkColumn from openrowset(
	BULK 'E:\MAAB\sql-homeworks\lesson-2\homework\apple.png', SINGLE_BLOB
) AS img;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
