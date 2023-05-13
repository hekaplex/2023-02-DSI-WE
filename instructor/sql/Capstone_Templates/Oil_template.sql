USE [OilTankers]
GO

/****** Object:  Table [dbo].[Calls_template]    Script Date: 9/12/2022 12:30:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Calls_template](
	[callid] [int] NULL,
	[lrno] [int] NULL,
	[arrdate] [datetime2](7) NULL,
	[saildate] [datetime2](7) NULL,
	[portname] [nvarchar](max) NULL,
	[countryname] [nvarchar](max) NULL,
	[priorportname] [nvarchar](100) NULL,
	[priorcountryname] [nvarchar](100) NULL,
	[movetype] [nvarchar](max) NULL,
	[datecreated] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [OilTankers]
GO

/****** Object:  Table [dbo].[ShipDetails_template]    Script Date: 9/12/2022 12:30:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ShipDetails_template](
	[nimo] [varchar](50) NULL,
	[dageminutes] [varchar](50) NULL,
	[dlat] [varchar](50) NULL,
	[dlon] [varchar](50) NULL,
	[dheading] [varchar](50) NULL,
	[dsog] [varchar](50) NULL,
	[nwidth] [varchar](50) NULL,
	[nlength] [varchar](50) NULL,
	[ndraught] [varchar](50) NULL,
	[sname] [varchar](50) NULL,
	[sdestination] [varchar](50) NULL,
	[dteta] [varchar](50) NULL,
	[sstatus] [varchar](50) NULL,
	[change_date] [varchar](50) NULL
) ON [PRIMARY]
GO
USE [OilTankers]
GO

/****** Object:  Table [dbo].[Ships_template]    Script Date: 9/12/2022 12:30:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Ships_template](
	[lrno] [int] NOT NULL,
	[vesselname] [nvarchar](max) NOT NULL,
	[owner] [nvarchar](max) NOT NULL,
	[shipmanager] [nvarchar](max) NOT NULL,
	[operator] [nvarchar](max) NOT NULL,
	[flag] [nvarchar](50) NOT NULL,
	[dwt] [int] NOT NULL,
	[loa] [float] NOT NULL,
	[breadth] [float] NOT NULL,
	[depth] [float] NOT NULL,
	[statdecode] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



--example bulk insert
BULK INSERT ShipDetails_template
FROM 'C:\divergence\Oil\Details_Incremental.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
--      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');



