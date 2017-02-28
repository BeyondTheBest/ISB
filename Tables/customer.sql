USE [ISB]
GO

/****** Object:  Table [dbo].[customers]    Script Date: 2/28/2017 10:59:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_fname] [nvarchar](50) NULL,
	[customer_mname] [nvarchar](50) NULL,
	[customer_lname] [nvarchar](50) NULL,
	[u_name] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[mobile] [numeric](18, 0) NULL,
	[phone] [nvarchar](20) NULL,
	[mail] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NULL,
	[city] [nvarchar](50) NULL,
	[state_name] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[zipcode] [numeric](10, 0) NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY]

GO




