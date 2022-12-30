use master;
go
DECLARE DBCursor Cursor
FOR
-- Selecting only user database
select name as DatabaseName
from sys.sysdatabases
where ([dbid] > 4) and ([name] not like '$')
OPEN DBCursor
DECLARE @dbName varchar(100);
DECLARE @compatQuery varchar(500);
  
Fetch NEXT FROM DBCursor INTO @dbName
While (@@FETCH_STATUS <> -1)
BEGIN
-- set database compatibility level SQL Server 2019
set @compatQuery =  'ALTER DATABASE ' + @dbName + ' SET COMPATIBILITY_LEVEL = 150;'
-- Print SQL statement
print @compatQuery
-- Execute compatability script
EXEC (@compatQuery)
-- Get next database
Fetch NEXT FROM DBCursor INTO @dbName
END
CLOSE DBCursor
DEALLOCATE DBCursor
GO
