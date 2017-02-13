USE [ISB]
GO

/****** Object:  Table [dbo].[product_category]    Script Date: 2/13/2017 4:15:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product_category](
	[category_id] [int] IDENTITY(10,1) NOT NULL,
	[category_name] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[photo_location] [image] NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


