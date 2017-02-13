USE [ISB]
GO

/****** Object:  Table [dbo].[order]    Script Date: 2/13/2017 4:14:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[order](
	[order_id] [int] IDENTITY(1000,1) NOT NULL,
	[customer_id] [int] NULL,
	[orderdate] [datetime] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[cost] [money] NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


