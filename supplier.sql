USE [ISB]
GO

/****** Object:  Table [dbo].[Supplier]    Script Date: 2/13/2017 3:06:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Supplier](
	[supplier_id] [int] NULL,
	[contact_name] [nvarchar](50) NULL,
	[company_name] [nvarchar](100) NULL,
	[phone] [numeric](10, 0) NULL,
	[email] [nvarchar](50) NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY]

GO


