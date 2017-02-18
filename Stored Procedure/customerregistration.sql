USE [Ecommerce2]
GO

/****** Object:  StoredProcedure [dbo].[customer_registration]    Script Date: 2/18/2017 7:18:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[customer_registration](@customer_fname nvarchar(50)
										,@customer_mname nvarchar(50)
										,@customer_lname nvarchar(50)
										,@user_name nvarchar(50)
										,@password nvarchar(50)
										,@mobile numeric(18,0)
										,@phone nvarchar(50)
										,@mail nvarchar(50)
										,@address nvarchar(50)
										,@city nvarchar(50)
										,@state_name nvarchar(50)
										,@country nvarchar(50)
										,@zipcode numeric(18,0)	
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
		if(select count(1) from customers where u_name=@user_name) IS NOT NULL
		begin
			if (select count(1) from customers where customer_fname=@customer_fname and customer_mname=@customer_mname and customer_lname=@customer_lname and mobile=@mobile and mail=@mail) IS NOT NULL
			begin
				if(select count(1) from customers where mobile=@mobile) IS NOT NULL
				begin
					insert into customers values(@customer_fname,@customer_mname,@customer_lname,@user_name,@password,@mobile,@phone,@mail,@address,@city,@state_name,@country,@zipcode,@created_by,@created_date,@last_updated_by,@last_updated_date);
					select @Ret_Flag='0',@Ret_Msg='Regitration Successfully Completed'
				end
				else
				begin
					select @Ret_Flag='1',@Ret_Msg='Mobile Number Already Registered' --if moble number already registered
				end
			end
			else
			begin
				select @Ret_Flag='2',@Ret_Msg='Customer Already Registered' --if Customer already registered
			end
		end
		else
			begin
				select @Ret_Flag='3',@Ret_Msg='User Name Already Exist' --if Username Exist
			end
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=ERROR_MESSAGE();
	end catch
	if(@Ret_Flag='0')
	begin 
		commit transaction;
	end
END

GO


