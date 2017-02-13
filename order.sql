USE [ISB]
GO

/****** Object:  Table [dbo].[order]    Script Date: 2/13/2017 3:04:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[order](
	[order_id] [int] NULL,
	[customer_id] [int] NULL,
	[orderdate] [datetime] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[cost] [money] NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY]

GO


