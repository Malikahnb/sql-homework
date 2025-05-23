CREATE PROCEDURE sp_ListProceduresAndFunctions
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    -- Create temp table to store results
    IF OBJECT_ID('tempdb..#RoutineDetails') IS NOT NULL
        DROP TABLE #RoutineDetails;

    CREATE TABLE #RoutineDetails (
        DatabaseName SYSNAME,
        SchemaName SYSNAME,
        RoutineName SYSNAME,
        RoutineType NVARCHAR(60),
        ParameterName SYSNAME,
        DataType NVARCHAR(128),
        MaxLength INT
    );

    -- Cursor to loop through databases
    DECLARE db_cursor CURSOR FOR
    SELECT name FROM sys.databases
    WHERE state_desc = 'ONLINE'
          AND name NOT IN ('master', 'tempdb', 'model', 'msdb')
          AND (@DatabaseName IS NULL OR name = @DatabaseName);

    DECLARE @DB SYSNAME;
    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @DB;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = '
        INSERT INTO #RoutineDetails (DatabaseName, SchemaName, RoutineName, RoutineType, ParameterName, DataType, MaxLength)
        SELECT
            ''' + @DB + ''' AS DatabaseName,
            s.name AS SchemaName,
            r.name AS RoutineName,
            r.type_desc AS RoutineType,
            p.name AS ParameterName,
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM ' + QUOTENAME(@DB) + '.sys.objects r
        JOIN ' + QUOTENAME(@DB) + '.sys.schemas s ON r.schema_id = s.schema_id
        LEFT JOIN ' + QUOTENAME(@DB) + '.sys.parameters p ON r.object_id = p.object_id
        LEFT JOIN ' + QUOTENAME(@DB) + '.sys.types t ON p.user_type_id = t.user_type_id
        WHERE r.type IN (''P'', ''FN'', ''IF'', ''TF'', ''FS'', ''FT'');';

        EXEC sp_executesql @SQL;

        FETCH NEXT FROM db_cursor INTO @DB;
    END

    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    -- Return result
    SELECT * FROM #RoutineDetails
    ORDER BY DatabaseName, SchemaName, RoutineName, ParameterName;

    DROP TABLE #RoutineDetails;
END
