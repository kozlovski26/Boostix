USE [master]
GO
/****** Object:  Database [Boostix]    Script Date: 6/2/2017 4:32:51 PM ******/
CREATE DATABASE [Boostix]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Boostix', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Boostix.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Boostix_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Boostix_log.ldf' , SIZE = 7616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Boostix] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Boostix].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Boostix] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Boostix] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Boostix] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Boostix] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Boostix] SET ARITHABORT OFF 
GO
ALTER DATABASE [Boostix] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Boostix] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Boostix] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Boostix] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Boostix] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Boostix] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Boostix] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Boostix] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Boostix] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Boostix] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Boostix] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Boostix] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Boostix] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Boostix] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Boostix] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Boostix] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Boostix] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Boostix] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Boostix] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Boostix] SET  MULTI_USER 
GO
ALTER DATABASE [Boostix] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Boostix] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Boostix] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Boostix] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Boostix]
GO
/****** Object:  Table [dbo].[AprioriRules]    Script Date: 6/2/2017 4:32:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AprioriRules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Source] [nchar](255) NOT NULL,
	[Dest] [nchar](255) NULL,
 CONSTRAINT [PK_AprioriRules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Document]    Script Date: 6/2/2017 4:32:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[FilePath] [nvarchar](255) NULL,
	[DocumentContent] [ntext] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MainPage]    Script Date: 6/2/2017 4:32:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MainPage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SliderTitle] [nvarchar](max) NULL,
	[SliderDescription] [nvarchar](max) NULL,
	[AboutDescription] [nvarchar](max) NULL,
	[AboutPictureUrl] [nvarchar](max) NULL,
	[Counter1] [int] NULL,
	[Counter2] [int] NULL,
	[Counter3] [int] NULL,
	[Counter4] [int] NULL,
	[Counter5] [int] NULL,
	[Counter1Name] [nvarchar](50) NULL,
	[Counter2Name] [nvarchar](50) NULL,
	[Counter3Name] [nvarchar](50) NULL,
	[Counter4Name] [nvarchar](50) NULL,
	[Counter5Name] [nvarchar](50) NULL,
	[Counter1Icon] [nvarchar](50) NULL,
	[Counter2Icon] [nvarchar](50) NULL,
	[Counter3Icon] [nvarchar](50) NULL,
	[Counter4Icon] [nvarchar](50) NULL,
	[Counter5Icon] [nvarchar](50) NULL,
	[AboutTitle] [nvarchar](255) NULL,
 CONSTRAINT [PK_MainPage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearchHistory]    Script Date: 6/2/2017 4:32:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Words] [nvarchar](255) NULL,
 CONSTRAINT [PK_SearchHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SearchRecord]    Script Date: 6/2/2017 4:32:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SearchRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Word] [nvarchar](max) NULL,
	[Count] [int] NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_tbl_SearchRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 6/2/2017 4:32:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Experience] [int] NULL,
	[UserType] [varchar](50) NULL,
	[CreatedOn] [datetime2](7) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_User]
GO
USE [master]
GO
ALTER DATABASE [Boostix] SET  READ_WRITE 
GO
