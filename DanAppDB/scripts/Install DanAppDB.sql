/****************************************************************************
*	Project             : DanAp												*
*   Filename            : Install DanAppDB.sql								*
*	Application Version : 1.0.0												*
*	Compatibility       : MS SQL Server 2008								*
*	Execute script as   : Database owner or sa								*
*																			*
*	Description			: Script creates the DandAppDB, tables,				*
*						  indexes, table constraints and foreign keys.		*
*	IMPORTANT NOTE!		:													*
*																			*
*****************************************************************************
*  Script sections:															*
*  1.0 Create database														*
*  2.0 Create tables, default constraints									*
*  3.0 Populate dimensions and Translations table							*
*  4.0 Add primary keys														*
*  5.0 Create indexes														*
*  6.0 Add foreign key constraints											*
*  7.0 Create views															*
*  8.0 Create functions														*
*  9.0 Create stored procedures												*
*  10.0 Create roles and users												*
*  																			*
*****************************************************************************
*     (c) Copyright  2015  Intelligent Currency Solutions					*
****************************************************************************/
USE master;
GO

-- ******************************************************
-- 1.0 Create database
-- ******************************************************
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DanAppDB')
	DROP DATABASE DanAppDB;
GO
--Get the data files path for DB creation
DECLARE 
@filePath nvarchar(max),
@dataFilePath nvarchar(max),
@logFilePath nvarchar(max);

SELECT @filePath = substring(Filename,1,LEN(filename) - 10) FROM sysfiles
WHERE name = 'master';

SET @dataFilePath = @filePath + N'DanAppDB.mdf';
SET @logFilePath = @filePath + N'DanAppDB_log.ldf';

EXEC ('CREATE DATABASE DanAppDB
		ON  PRIMARY 
	   ( NAME = N''DanAppDB'' ,FILENAME = N'''+ @dataFilePath +''' ,SIZE = 10240KB ,MAXSIZE = UNLIMITED ,FILEGROWTH = 1024KB )
		LOG ON
	   ( NAME = N''DanAppDB_log'' ,FILENAME = N'''+ @logFilePath +''' ,SIZE = 1024KB ,MAXSIZE = 2048GB ,FILEGROWTH = 10% );'
	 );
GO

ALTER DATABASE DanAppDB SET COMPATIBILITY_LEVEL = 130;
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
EXEC DanAppDB.dbo.sp_fulltext_database @action = 'enable'
END
GO

ALTER DATABASE DanAppDB SET ANSI_NULL_DEFAULT OFF;
GO
ALTER DATABASE DanAppDB SET ANSI_NULLS OFF;
GO
ALTER DATABASE DanAppDB SET ANSI_PADDING OFF;
GO
ALTER DATABASE DanAppDB SET ANSI_WARNINGS OFF; 
GO
ALTER DATABASE DanAppDB SET ARITHABORT OFF;
GO
ALTER DATABASE DanAppDB SET AUTO_CLOSE OFF;
GO
ALTER DATABASE DanAppDB SET AUTO_CREATE_STATISTICS ON;
GO
ALTER DATABASE DanAppDB SET AUTO_SHRINK OFF;
GO
ALTER DATABASE DanAppDB SET AUTO_UPDATE_STATISTICS ON;
GO
ALTER DATABASE DanAppDB SET CURSOR_CLOSE_ON_COMMIT OFF; 
GO
ALTER DATABASE DanAppDB SET CURSOR_DEFAULT  GLOBAL;
GO
ALTER DATABASE DanAppDB SET CONCAT_NULL_YIELDS_NULL OFF;
GO
ALTER DATABASE DanAppDB SET NUMERIC_ROUNDABORT OFF;
GO
ALTER DATABASE DanAppDB SET QUOTED_IDENTIFIER OFF;
GO
ALTER DATABASE DanAppDB SET RECURSIVE_TRIGGERS OFF; 
GO
ALTER DATABASE DanAppDB SET  ENABLE_BROKER;
GO
ALTER DATABASE DanAppDB SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
GO
ALTER DATABASE DanAppDB SET DATE_CORRELATION_OPTIMIZATION OFF; 
GO
ALTER DATABASE DanAppDB SET TRUSTWORTHY OFF;
GO
ALTER DATABASE DanAppDB SET ALLOW_SNAPSHOT_ISOLATION ON;
GO
ALTER DATABASE DanAppDB SET PARAMETERIZATION SIMPLE;
GO
ALTER DATABASE DanAppDB SET READ_COMMITTED_SNAPSHOT ON;
GO
ALTER DATABASE DanAppDB SET HONOR_BROKER_PRIORITY OFF;
GO
ALTER DATABASE DanAppDB SET RECOVERY SIMPLE;
GO
ALTER DATABASE DanAppDB SET  MULTI_USER;
GO
ALTER DATABASE DanAppDB SET PAGE_VERIFY CHECKSUM;
GO
ALTER DATABASE DanAppDB SET DB_CHAINING OFF;
GO
ALTER DATABASE DanAppDB SET  READ_WRITE;
GO

-- ******************************************************
-- 2.0 Create tables, default constraints
-- ******************************************************
USE DanAppDB;
GO

drop table if exists dbo.Registration
go
CREATE TABLE dbo.Registration
(
	RegistrationId int IDENTITY(0,1) NOT NULL,
	FirstName nvarchar(255) NOT NULL,
	LastName nvarchar(255) NOT NULL,
	Email nvarchar(255) NOT NULL,
	Password nvarchar(50) NOT NULL,
	Gender nvarchar(50) NOT NULL,
	Age tinyint NOT NULL,
	Country nvarchar(250) NOT NULL CONSTRAINT DF_Registration_Country default (''),
	City nvarchar(250) NOT NULL CONSTRAINT DF_Registration_City default (''),
	PostCode nvarchar(50) NOT NULL CONSTRAINT DF_Registration_PostCode default (''),
	UserDescription nvarchar(4000) NOT NULL CONSTRAINT DF_Registration_UserDescription default (''),
	FBLink nvarchar(255) NOT NULL CONSTRAINT DF_Registration_FBLink default (''),
	IGLink nvarchar(255) NOT NULL CONSTRAINT DF_Registration_IGLink default (''),
	Picture nvarchar(max) NOT NULL CONSTRAINT DF_Registration_Picture default (''),
	ModifiedDate smalldatetime NOT NULL CONSTRAINT DF_Registration_ModifiedDate DEFAULT (GETDATE())
 CONSTRAINT PK_Registration PRIMARY KEY CLUSTERED (RegistrationId ASC)
)
GO

-- ******************************************************
-- 5.0 Create indexes
-- ******************************************************
drop index if exists UX_Registration on dbo.Registration
go
CREATE UNIQUE NONCLUSTERED INDEX UX_Registration
ON dbo.Registration (FirstName, LastName, Email);
GO

-- ******************************************************
-- 10.0 Create roles and users
-- ******************************************************
USE master
GO
CREATE LOGIN DanAdmin WITH PASSWORD=N'QQwwEE!!22££', DEFAULT_DATABASE=master, CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER SERVER ROLE sysadmin ADD MEMBER DanAdmin
GO
USE DanAppDB
GO
CREATE USER DanAdmin FOR LOGIN DanAdmin
GO
USE DanAppDB
GO
ALTER ROLE db_owner ADD MEMBER DanAdmin
GO