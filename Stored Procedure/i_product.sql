USE [ISB]
GO

/****** Object:  StoredProcedure [dbo].[i_product]    Script Date: 2/13/2017 7:07:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[i_product](	@prod_cat_id int 
							,@product_name nvarchar(50)
							,@product_price money
							,@quantity int
							,@description nvarchar(max) 
							,@manufactured_by nvarchar(50)
							,@manufactured_date datetime
							,@expired_date datetime
							,@created_by nvarchar(50)
							,@created_date datetime
							,@last_updated_by nvarchar(50)
							,@last_updated_date datetime
							,@Ret_Flag nvarchar(2) output
							,@Ret_Msg nvarchar(200)	output				
							)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into product values(@prod_cat_id,@product_name,@product_price,@quantity,@description,@manufactured_by,@manufactured_date,@expired_date,@created_by,@created_date,@last_updated_by,@last_updated_date);
		commit transaction;
		select @Ret_Flag='0',@Ret_Msg='Submitted Sucessfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message() 
	end catch
END

GO


