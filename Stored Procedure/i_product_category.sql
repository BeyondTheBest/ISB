USE [ISB]
GO

/****** Object:  StoredProcedure [dbo].[i_product_category]    Script Date: 2/13/2017 7:30:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[i_product_category](@category_name nvarchar(50)
									,@description nvarchar(max)
									,@photo_location nvarchar(max)
									,@created_by nvarchar(50)
									,@created_date datetime
									,@last_updated_by nvarchar(50)
									,@last_updated_date datetime
									,@Ret_Flag nvarchar(2) output
									,@Ret_Msg nvarchar(200) output																		
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into product_category values(@category_name,@description,@photo_location,@created_by,@created_date,@last_updated_by,@last_updated_date)
		commit transaction;
		select @Ret_Flag='0',@Ret_Msg='Submitted Sucessfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message() 
	end catch
END

GO


