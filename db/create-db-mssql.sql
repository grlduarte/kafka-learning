-- Verify and create the database / table 
IF DB_ID('IWSLogger') IS NOT NULL
   PRINT 'db exists'
ELSE 
    CREATE DATABASE "IWSLogger"
    GO
    CREATE TABLE [IWSLogger].[dbo].[quickstart-source] (id INT PRIMARY KEY, value INT NOT NULL)
    GO
GO
