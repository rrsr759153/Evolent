USE [master]
GO
/****** Object:  Database [EvolentDB]    Script Date: 4/26/2017 12:58:43 AM ******/
CREATE DATABASE [EvolentDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EvolentDB', FILENAME = N'D:\RDSDBDATA\DATA\EvolentDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'EvolentDB_log', FILENAME = N'D:\RDSDBDATA\DATA\EvolentDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EvolentDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EvolentDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EvolentDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EvolentDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EvolentDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EvolentDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EvolentDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EvolentDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EvolentDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EvolentDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EvolentDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EvolentDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EvolentDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EvolentDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EvolentDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EvolentDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EvolentDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EvolentDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EvolentDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EvolentDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EvolentDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EvolentDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EvolentDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EvolentDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EvolentDB] SET RECOVERY FULL 
GO
ALTER DATABASE [EvolentDB] SET  MULTI_USER 
GO
ALTER DATABASE [EvolentDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EvolentDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EvolentDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EvolentDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EvolentDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EvolentDB] SET QUERY_STORE = OFF
GO
USE [EvolentDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [EvolentDB]
GO
/****** Object:  User [EvolentContacts]    Script Date: 4/26/2017 12:58:44 AM ******/
CREATE USER [EvolentContacts] FOR LOGIN [EvolentContacts] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [EvolentContacts]
GO
/****** Object:  Table [dbo].[EvolentContacts]    Script Date: 4/26/2017 12:58:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvolentContacts](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Phone] [numeric](18, 0) NOT NULL,
	[IsActive] [varchar](10) NOT NULL,
 CONSTRAINT [UK_EvolentContacts_Email] PRIMARY KEY NONCLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_EvolentContacts_Email]    Script Date: 4/26/2017 12:58:45 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_EvolentContacts_Email] ON [dbo].[EvolentContacts]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[CreateContact]    Script Date: 4/26/2017 12:58:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
	 Author:			Ranjith Reddy Surapu Reddy
	 Create date:		04/26/2017
	 parameter(s):		@first_name, @last_name, @email, @mobile, @status
	 Description:		CreateContact
	 LastUpdate:
 =============================================
*/

CREATE PROCEDURE [dbo].[CreateContact]
(
   
    @first_name  NVARCHAR(50),
    @last_name   NVARCHAR(50),
    @email NVARCHAR(50),
	@mobile Numeric(18,0),
@status NVARCHAR(10)
)
 
AS
Begin

insert into dbo.EvolentContacts (firstname,lastname,email,phone,isactive) values( @first_name,  @last_name,  @email, @mobile, @status)   

End

GO
/****** Object:  StoredProcedure [dbo].[DeleteContact]    Script Date: 4/26/2017 12:58:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
	 Author:			RANJITH REDDY SURAPU REDDY
	 Create date:		04/26/2017
	 parameter(s):	@ID
	 Description:		DeleteContact
	 LastUpdate:	-------
 =============================================
*/

CREATE PROCEDURE [dbo].[DeleteContact]
(
    @id  INT
)
 
AS
BEGIN
DELETE FROM EvolentContacts  WHERE contactid = @id
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllContacts]    Script Date: 4/26/2017 12:58:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
	 Author:			RANJITH REDDY SURAPU REDDY
	 Create date:		04/26/2017
	 parameter(s):	----
	 Description:		To get AllContacts
	 LastUpdate:
 =============================================
*/

CREATE PROCEDURE [dbo].[GetAllContacts]
 
AS
BEGIN
select * FROM EvolentContacts
END

GO
/****** Object:  StoredProcedure [dbo].[GetContact]    Script Date: 4/26/2017 12:58:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
	 Author:			RANJITH REDDY SURAPU REDDY
	 Create date:		04/26/2017
	 parameter(s):	----
	 Description:		GetContact a specific contact
	 LastUpdate:
 =============================================
*/

CREATE PROCEDURE [dbo].[GetContact]
(
    @id         INT
)
 
AS

BEGIN
select * FROM EvolentContacts  WHERE contactid = @id
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateContact]    Script Date: 4/26/2017 12:58:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
	 Author:			Ranjith Reddy Surapu Reddy
	 Create date:		04/26/2017
	 parameter(s):	 @first_name,@last_name , @email,@mobile,@status
	 Description:		UpdateContact
	 LastUpdate:
 =============================================
*/

CREATE PROCEDURE [dbo].[UpdateContact]
(
    @id         INT,
    @first_name  NVARCHAR(50),
    @last_name   NVARCHAR(50),
    @email NVARCHAR(50),
	@mobile NUMERIC(18,0),
	@status NVARCHAR(10)
)
 
AS


BEGIN
UPDATE EvolentContacts  SET
            firstname =  @first_name, lastname = @last_name, email=@email, phone= @mobile, isactive=@status         
      WHERE contactid = @id
END

GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 4/26/2017 12:58:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [rds_deny_backups_trigger] ON DATABASE WITH EXECUTE AS 'dbo' FOR
 ADD_ROLE_MEMBER, GRANT_DATABASE AS BEGIN
   SET NOCOUNT ON;
   SET ANSI_PADDING ON;
 
   DECLARE @data xml;
   DECLARE @user sysname;
   DECLARE @role sysname;
   DECLARE @type sysname;
   DECLARE @sql NVARCHAR(MAX);
   DECLARE @permissions TABLE(name sysname PRIMARY KEY);
   
   SELECT @data = EVENTDATA();
   SELECT @type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    
   IF @type = 'ADD_ROLE_MEMBER' BEGIN
      SELECT @user = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
       @role = @data.value('(/EVENT_INSTANCE/RoleName)[1]', 'sysname');

      IF @role IN ('db_owner', 'db_backupoperator') BEGIN
         SELECT @sql = 'DENY BACKUP DATABASE, BACKUP LOG TO ' + QUOTENAME(@user);
         EXEC(@sql);
      END
   END ELSE IF @type = 'GRANT_DATABASE' BEGIN
      INSERT INTO @permissions(name)
      SELECT Permission.value('(text())[1]', 'sysname') FROM
       @data.nodes('/EVENT_INSTANCE/Permissions/Permission')
      AS DatabasePermissions(Permission);
      
      IF EXISTS (SELECT * FROM @permissions WHERE name IN ('BACKUP DATABASE',
       'BACKUP LOG'))
         RAISERROR('Cannot grant backup database or backup log', 15, 1) WITH LOG;       
   END
END


GO
ENABLE TRIGGER [rds_deny_backups_trigger] ON DATABASE
GO
USE [master]
GO
ALTER DATABASE [EvolentDB] SET  READ_WRITE 
GO
