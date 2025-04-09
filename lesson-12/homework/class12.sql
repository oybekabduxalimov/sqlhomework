CREATE PROCEDURE GetProceduresAndFunctions
    @DatabaseName NVARCHAR(128) = NULL
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    -- If no database name is provided, retrieve for all databases
    IF @DatabaseName IS NULL
    BEGIN
        -- Loop through all user databases
        DECLARE db_cursor CURSOR FOR
        SELECT name 
        FROM sys.databases
        WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');  -- Exclude system databases
        
        OPEN db_cursor;
        DECLARE @dbname NVARCHAR(128);

        FETCH NEXT FROM db_cursor INTO @dbname;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Generate dynamic SQL for each database
            SET @sql = @sql + 
            'USE ' + QUOTENAME(@dbname) + ';
            SELECT ''' + @dbname + ''' AS database_name,
                   s.name AS schema_name,
                   p.name AS procedure_name,
                   pr.name AS parameter_name,
                   tp.name AS parameter_data_type
            FROM sys.procedures p
            INNER JOIN sys.schemas s ON p.schema_id = s.schema_id
            LEFT JOIN sys.parameters pr ON p.object_id = pr.object_id
            LEFT JOIN sys.types tp ON pr.user_type_id = tp.user_type_id
            ORDER BY s.name, p.name, pr.parameter_id;
            ';

            FETCH NEXT FROM db_cursor INTO @dbname;
        END;

        CLOSE db_cursor;
        DEALLOCATE db_cursor;

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql;
    END
    ELSE
    BEGIN
        -- If a specific database is provided, retrieve only for that database
        SET @sql = 'USE ' + QUOTENAME(@DatabaseName) + ';
        SELECT ''' + @DatabaseName + ''' AS database_name,
               s.name AS schema_name,
               p.name AS procedure_name,
               pr.name AS parameter_name,
               tp.name AS parameter_data_type
        FROM sys.procedures p
        INNER JOIN sys.schemas s ON p.schema_id = s.schema_id
        LEFT JOIN sys.parameters pr ON p.object_id = pr.object_id
        LEFT JOIN sys.types tp ON pr.user_type_id = tp.user_type_id
        ORDER BY s.name, p.name, pr.parameter_id;
        ';
        
        -- Execute the dynamic SQL for the provided database
        EXEC sp_executesql @sql;
    END
END;
