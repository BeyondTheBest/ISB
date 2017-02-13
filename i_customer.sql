USE [ISB]
GO

/****** Object:  StoredProcedure [dbo].[i_customer]    Script Date: 2/13/2017 4:59:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[i_customer]( @customer_first_name nvarchar(50)
							,@customer_last_name nvarchar(50)
							,@phone numeric(18,0)
							,@mail_id nvarchar(50)
							,@Address nvarchar(max)
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
		insert into customer values(@customer_first_name,@customer_last_name,@phone,@mail_id,@Address,@created_by,@created_date,@last_updated_by,@last_updated_date);
		select @Ret_Flag='0',@Ret_Msg='Submitted Sucessfully'  
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message() 
	end catch
END

GO


