-- To create the database / table with verification
USE master;
GO
IF NOT EXISTS (SELECT * FROM sys.objects 
         WHERE object_id = OBJECT_ID(N'[dbo].[IWSLogger]')
         AND type in (N'U'))
CREATE DATABASE IWSLogger;
GO
USE IWSLogger;
GO
IF NOT EXISTS (SELECT * FROM sys.objects 
         WHERE object_id = OBJECT_ID(N'[dbo].[IWSLogger]')
         AND type in (N'U'))
CREATE TABLE "quickstart-source" (id INT PRIMARY KEY, value INT NOT NULL);
GO

-- To delete the already created database / table
USE IWSLogger;
SELECT * FROM sys.objects 
         WHERE object_id = OBJECT_ID(N'[dbo].[IWSLogger]')
         AND type in (N'U')
DROP TABLE dbo.[quickstart-source]
GO
USE master;;
SELECT * FROM sys.objects 
         WHERE object_id = OBJECT_ID(N'[dbo].[IWSLogger]')
         AND type in (N'U')
DROP DATABASE IWSLogger;
GO
 
-- To create the database / table simply (without any verification) 
USE master;  
GO
CREATE DATABASE IWSLogger;
GO
USE IWSLogger;
GO
CREATE TABLE "quickstart-source" (id INT PRIMARY KEY, value INT NOT NULL);
GO
