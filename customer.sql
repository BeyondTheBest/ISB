USE [ISB]
GO

/****** Object:  Table [dbo].[customer]    Script Date: 2/13/2017 3:03:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customer](
	[customer_id] [int] NULL,
	[customer_first_name] [nvarchar](50) NULL,
	[customer_last_name] [nvarchar](50) NULL,
	[Phone] [numeric](10, 0) NULL,
	[mail_id] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


