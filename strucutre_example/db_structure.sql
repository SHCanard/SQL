#### For Central Server move tempdb SQL ####

USE [tempdb]
GO
DBCC SHRINKFILE (N'temp2', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp2]
GO
DBCC SHRINKFILE (N'temp3', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp3]
GO
DBCC SHRINKFILE (N'temp4', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp4]
GO
DBCC SHRINKFILE (N'temp5', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp5]
GO
DBCC SHRINKFILE (N'temp6', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp6]
GO
DBCC SHRINKFILE (N'temp7', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp7]
GO
DBCC SHRINKFILE (N'temp8', EMPTYFILE)
GO
ALTER DATABASE [tempdb]  REMOVE FILE [temp8]
GO
ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev, NEWNAME = tempdb_1, FILENAME = 'M:\tempdb_1\mnt\SQLData\tempdb.mdf');
GO
ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdb_1, SIZE = 40000 MB, MAXSIZE = 64 GB, FILEGROWTH = 4000 MB);
GO
ALTER DATABASE tempdb
ADD FILE (NAME = tempdb_2, FILENAME = 'M:\tempdb_2\mnt\SQLData\tempdb.ndf', SIZE = 40000 MB, MAXSIZE = 64 GB, FILEGROWTH = 4000 MB);
GO
ALTER DATABASE tempdb
MODIFY FILE (NAME = templog, FILENAME = 'M:\templog\mnt\SQLData\templog.ldf', SIZE = 8000 MB, MAXSIZE = 64 GB, FILEGROWTH = 500 MB);
GO

#### For Central Server DB add ndf after install ####

ALTER DATABASE CentralServer
ADD FILE (NAME = CentralServer_2, FILENAME = 'M:\Central_Server_2\mnt\SQLData\CentralServer_2.ndf', SIZE = 25 GB, MAXSIZE = 80 GB, FILEGROWTH = 256 MB);
GO
ALTER DATABASE CentralServer
ADD FILE (NAME = CentralServer_3, FILENAME = 'M:\Central_Server_3\mnt\SQLData\CentralServer_3.ndf', SIZE = 25 GB, MAXSIZE = 80 GB, FILEGROWTH = 256 MB);
GO
ALTER DATABASE CentralServer
ADD FILE (NAME = CentralServer_4, FILENAME = 'M:\Central_Server_4\mnt\SQLData\CentralServer_4.ndf', SIZE = 25 GB, MAXSIZE = 80 GB, FILEGROWTH = 256 MB);
GO

#### For Central Server DB grow logs ####

ALTER DATABASE CentralServer
MODIFY FILE (NAME=CentralServer_log, SIZE=8000MB)
ALTER DATABASE CentralServer
MODIFY FILE (NAME=CentralServer_log, SIZE=16000MB)
ALTER DATABASE CentralServer
MODIFY FILE (NAME=CentralServer_log, SIZE=24000MB)
ALTER DATABASE CentralServer
MODIFY FILE (NAME=CentralServer_log, SIZE=32000MB)
