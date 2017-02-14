USE [ISB]
GO

/****** Object:  StoredProcedure [dbo].[i_order]    Script Date: 2/13/2017 6:29:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[i_order](@customer_fname nvarchar(50)
				,@customer_lname nvarchar(50)
				,@customer_mobile numeric(10,0)
				,@product_name nvarchar(50)
				,@product_category_name nvarchar(50)
				,@quantity int
				,@created_by nvarchar(50)
				,@created_date datetime
				,@last_updated_by nvarchar(50)
				,@last_updated_date datetime
				,@Ret_Flag nvarchar(50) output
				,@Ret_Msg nvarchar(50) output
				)
AS
declare @custid int;
declare @prodid int;
declare @prodcatid int;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	--if non register user cannot do order
	if(select count(1) from customer where customer_first_name=@customer_fname and customer_last_name=@customer_lname and Phone=@customer_mobile) IS NULL
		select @Ret_Flag='1',@Ret_Msg='Please Register'
	else
	begin
		select @custid=customer_id from customer where customer_first_name=@customer_fname and customer_last_name=@customer_lname and Phone=@customer_mobile;--for retrive customer_id from customer table
		select @prodcatid=category_id from product_category where category_name=@product_category_name;--for retrive product category id from product category table using category name
		select @prodid=product_id from product where product_name=@product_name and product_category_id=@prodcatid;--For Retrive product id from product table using product name and product category id
		insert into orders values(@custid,getdate(),@prodid,@quantity,(select product_price from product where product_id=@prodid),@created_by,@created_date,@last_updated_by,@last_updated_date)
		commit transaction;
		select @Ret_Flag='0',@Ret_Msg='Order Sucessfully Placed ';
	end
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message();
	end catch

END

GO


