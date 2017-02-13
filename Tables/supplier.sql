USE [ISB]
GO

/****** Object:  Table [dbo].[supplier]    Script Date: 2/13/2017 4:16:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[supplier](
	[supplier_id] [int] IDENTITY(100,1) NOT NULL,
	[contact_name] [nvarchar](50) NULL,
	[company_name] [nvarchar](100) NULL,
	[phone] [numeric](10, 0) NULL,
	[email] [nvarchar](50) NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


