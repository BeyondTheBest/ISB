USE [ISB]
GO

/****** Object:  Table [dbo].[product]    Script Date: 2/13/2017 3:05:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product](
	[product_id] [int] NULL,
	[product_category_id] [int] NULL,
	[product_name] [nvarchar](50) NULL,
	[product_price] [money] NULL,
	[quantity] [int] NULL,
	[desription] [nvarchar](max) NULL,
	[manufactured_by] [nvarchar](50) NULL,
	[manufactured_date] [datetime] NULL,
	[expired_date] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


