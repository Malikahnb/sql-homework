DECLARE @DatabaseName NVARCHAR(128);
DECLARE @SQL NVARCHAR(MAX);

-- Table to store results
IF OBJECT_ID('tempdb..#ColumnDetails') IS NOT NULL
    DROP TABLE #ColumnDetails;

CREATE TABLE #ColumnDetails (
    DatabaseName SYSNAME,
    SchemaName SYSNAME,
    TableName SYSNAME,
    ColumnName SYSNAME,
    DataType NVARCHAR(128)
);
 
DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
      AND state_desc = 'ONLINE';

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DatabaseName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = '
    USE ' + QUOTENAME(@DatabaseName) + ';

    INSERT INTO #ColumnDetails (DatabaseName, SchemaName, TableName, ColumnName, DataType)
    SELECT 
        DB_NAME() AS DatabaseName,
        s.name AS SchemaName,
        t.name AS TableName,
        c.name AS ColumnName,
        ty.name AS DataType
    FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.types ty ON c.user_type_id = ty.user_type_id
    WHERE t.is_ms_shipped = 0;';

    EXEC sp_executesql @SQL;

    FETCH NEXT FROM db_cursor INTO @DatabaseName;
END


CLOSE s;
DEALLOCATE db_cursor;

SELECT * FROM #ColumnDetails
ORDER BY DatabaseName, SchemaName, TableName, ColumnName;
