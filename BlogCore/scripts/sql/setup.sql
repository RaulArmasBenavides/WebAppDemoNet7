USE [master]
GO

-- Terminate all existing connections to the database
ALTER DATABASE [CONSULTORIO2] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Restore the database from the .bak file
RESTORE DATABASE [CONSULTORIO2]
FROM DISK = N'/usr/src/app/CONSULTORIO2.bak'
WITH FILE = 1, 
MOVE N'LogicalName_Data' TO N'/var/opt/mssql/data/CONSULTORIO2.mdf',
MOVE N'LogicalName_Log' TO N'/var/opt/mssql/data/CONSULTORIO2_log.ldf',
NOUNLOAD, REPLACE, STATS = 5;
GO

-- Set the database back to multi-user mode
ALTER DATABASE [CONSULTORIO2] SET MULTI_USER;
GO