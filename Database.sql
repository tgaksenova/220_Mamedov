USE [master]
GO
/****** Object:  Database [220_Mamedov_Exam]    Script Date: 27.12.2023 16:31:40 ******/
CREATE DATABASE [220_Mamedov_Exam]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'220_Mamedov_Exam', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\220_Mamedov_Exam.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'220_Mamedov_Exam_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\220_Mamedov_Exam_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [220_Mamedov_Exam] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [220_Mamedov_Exam].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [220_Mamedov_Exam] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET ARITHABORT OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [220_Mamedov_Exam] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [220_Mamedov_Exam] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET  DISABLE_BROKER 
GO
ALTER DATABASE [220_Mamedov_Exam] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [220_Mamedov_Exam] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [220_Mamedov_Exam] SET  MULTI_USER 
GO
ALTER DATABASE [220_Mamedov_Exam] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [220_Mamedov_Exam] SET DB_CHAINING OFF 
GO
ALTER DATABASE [220_Mamedov_Exam] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [220_Mamedov_Exam] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [220_Mamedov_Exam] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [220_Mamedov_Exam] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [220_Mamedov_Exam] SET QUERY_STORE = OFF
GO
USE [220_Mamedov_Exam]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 27.12.2023 16:31:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IsTeacher] [bit] NOT NULL,
	[StudentId] [int] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 27.12.2023 16:31:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionType] [nvarchar](50) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[Var1] [nvarchar](max) NOT NULL,
	[Var2] [nvarchar](max) NOT NULL,
	[Var3] [nvarchar](max) NOT NULL,
	[Var4] [nvarchar](max) NOT NULL,
	[CorrectVariant] [int] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 27.12.2023 16:31:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudyGroup] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestQuestion]    Script Date: 27.12.2023 16:31:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestQuestion](
	[QuestionId] [int] NOT NULL,
	[TestId] [int] NOT NULL,
	[Answer] [int] NOT NULL,
 CONSTRAINT [PK_TestQuestion] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC,
	[TestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestReports]    Script Date: 27.12.2023 16:31:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TestDate] [datetime2](7) NULL,
	[StudentID] [int] NULL,
 CONSTRAINT [PK_TestReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([Id], [Login], [Password], [IsTeacher], [StudentId]) VALUES (1, N'ruslan', N'123', 0, 1)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [IsTeacher], [StudentId]) VALUES (2, N'teacher', N'123', 1, NULL)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [IsTeacher], [StudentId]) VALUES (3, N'student1', N'123', 0, 2)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [IsTeacher], [StudentId]) VALUES (4, N'student2', N'321', 0, 3)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [IsTeacher], [StudentId]) VALUES (5, N'student3', N'666', 0, 4)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [IsTeacher], [StudentId]) VALUES (6, N'laststudent', N'555', 0, 5)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([Id], [QuestionType], [Text], [Var1], [Var2], [Var3], [Var4], [CorrectVariant]) VALUES (1, N'Вопрос', N'2+2?', N'1', N'2', N'3', N'4', 4)
INSERT [dbo].[Questions] ([Id], [QuestionType], [Text], [Var1], [Var2], [Var3], [Var4], [CorrectVariant]) VALUES (2, N'Вопрос', N'Столица России?', N'Лондон', N'Париж', N'Москва', N'Берлин', 3)
INSERT [dbo].[Questions] ([Id], [QuestionType], [Text], [Var1], [Var2], [Var3], [Var4], [CorrectVariant]) VALUES (3, N'Вопрос', N'Сколько цифр существует', N'1', N'0', N'10', N'Бесконечно много', 3)
INSERT [dbo].[Questions] ([Id], [QuestionType], [Text], [Var1], [Var2], [Var3], [Var4], [CorrectVariant]) VALUES (4, N'Вопрос', N'Год развала СССР?', N'1991', N'1989', N'2000', N'1997', 1)
INSERT [dbo].[Questions] ([Id], [QuestionType], [Text], [Var1], [Var2], [Var3], [Var4], [CorrectVariant]) VALUES (5, N'Вопрос', N'На каком я курсе?', N'1', N'4', N'3', N'2', 2)
SET IDENTITY_INSERT [dbo].[Questions] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [StudyGroup], [Surname], [Name], [Patronymic]) VALUES (1, N'220', N'Mamedov', N'Ruslan', N'Elshanovich')
INSERT [dbo].[Students] ([Id], [StudyGroup], [Surname], [Name], [Patronymic]) VALUES (2, N'220', N'Ivanov', N'Ivan', N'Ivanych')
INSERT [dbo].[Students] ([Id], [StudyGroup], [Surname], [Name], [Patronymic]) VALUES (3, N'320', N'Petrov', N'Petr', N'')
INSERT [dbo].[Students] ([Id], [StudyGroup], [Surname], [Name], [Patronymic]) VALUES (4, N'320', N'Nikolaev', N'Nikolay', N'Nikolaevich')
INSERT [dbo].[Students] ([Id], [StudyGroup], [Surname], [Name], [Patronymic]) VALUES (5, N'120', N'Ivanov', N'Petr', N'Nikolaevich')
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (1, 1, 2)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (1, 2, 4)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (1, 3, 4)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (1, 6, 1)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (2, 1, 3)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (3, 3, 2)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (3, 4, 2)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (4, 2, 2)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (4, 3, 3)
INSERT [dbo].[TestQuestion] ([QuestionId], [TestId], [Answer]) VALUES (5, 3, 1)
GO
SET IDENTITY_INSERT [dbo].[TestReports] ON 

INSERT [dbo].[TestReports] ([Id], [TestDate], [StudentID]) VALUES (1, CAST(N'2022-02-11T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[TestReports] ([Id], [TestDate], [StudentID]) VALUES (2, CAST(N'2022-02-11T00:00:00.0000000' AS DateTime2), 5)
INSERT [dbo].[TestReports] ([Id], [TestDate], [StudentID]) VALUES (3, CAST(N'2022-02-11T00:00:00.0000000' AS DateTime2), 2)
INSERT [dbo].[TestReports] ([Id], [TestDate], [StudentID]) VALUES (4, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[TestReports] ([Id], [TestDate], [StudentID]) VALUES (6, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), 3)
SET IDENTITY_INSERT [dbo].[TestReports] OFF
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Students]
GO
ALTER TABLE [dbo].[TestQuestion]  WITH CHECK ADD  CONSTRAINT [FK_TestQuestion_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[TestQuestion] CHECK CONSTRAINT [FK_TestQuestion_Questions]
GO
ALTER TABLE [dbo].[TestQuestion]  WITH CHECK ADD  CONSTRAINT [FK_TestQuestion_TestReports] FOREIGN KEY([TestId])
REFERENCES [dbo].[TestReports] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TestQuestion] CHECK CONSTRAINT [FK_TestQuestion_TestReports]
GO
ALTER TABLE [dbo].[TestReports]  WITH CHECK ADD  CONSTRAINT [FK_TestReports_Students] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[TestReports] CHECK CONSTRAINT [FK_TestReports_Students]
GO
USE [master]
GO
ALTER DATABASE [220_Mamedov_Exam] SET  READ_WRITE 
GO
