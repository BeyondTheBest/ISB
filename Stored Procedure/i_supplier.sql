USE [ISB]
GO

/****** Object:  StoredProcedure [dbo].[i_supplier]    Script Date: 2/14/2017 10:31:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[i_supplier]	(@contact_name nvarchar(50)
					,@company_name nvarchar(50)
					,@phone nvarchar(50)
					,@email nvarchar(50)
					,@created_by nvarchar(50)
					,@created_date datetime
					,@last_updated_by nvarchar(50)
					,@last_updated_date datetime
					,@RetFlag nvarchar(2) output
					,@RetMsg nvarchar(200) output
					)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into supplier values(@contact_name,@company_name,@phone,@email,@created_by,@created_date,@last_updated_by,@last_updated_date);
		commit transaction;
		select @RetFlag='0',@RetMsg='Succesfully supplier Added';
	end try
	begin catch
		select @RetFlag='-1',@RetMsg=error_message();
	end catch

END

GO


