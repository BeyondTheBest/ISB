USE [ISB]
GO

/****** Object:  Table [dbo].[product_category]    Script Date: 2/13/2017 3:05:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product_category](
	[category_id] [int] NULL,
	[category_name] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[photo_location] [image] NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

