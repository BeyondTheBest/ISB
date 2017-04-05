/****** Object:  StoredProcedure [dbo].[Assigning_Order_Shipper]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Assigning_Order_Shipper](@Order_Id int
										,@Shipper_Id int
										,@Assigned_By int
										,@Assigned_Date datetime
										,@Dispatched_Date datetime
										,@Expected_Delivery_Date datetime
										,@Delivery_Confirmation_Flagn nvarchar(1)
										,@Ret_Flag nvarchar(1) output
										,@Ret_Msg nvarchar(200) output
										)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if(@Order_Id IS NOT NULL)
		begin
			if(@Shipper_Id IS NOT NULL)
			begin
				insert into Order_To_Shipper(Order_Id,Shipper_Id,Assigned_By,Assigned_Date,Dispatched_Date,Expected_Delivery_Date,Delivery_Confirmation_Flag)
				values(@Order_Id,@Shipper_Id,@Assigned_By,@Assigned_Date,@Dispatched_Date,@Expected_Delivery_Date,@Delivery_Confirmation_Flagn)	
				select @Ret_Flag='0',@Ret_Msg='Added Successfully'
			end
			else
				select @Ret_Flag='2',@Ret_Msg='Please Provide Shipper Details'
		end
		else
			select @Ret_Flag='1',@Ret_Msg='Please Provide Order Details'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[Customer_Registration]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Customer_Registration](@customer_fname nvarchar(50)
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
		if not exists(select * from Customers where User_Name=@user_name)
		begin
			if not exists(select * from Customers where  Mail=@mail)
			begin
				if not exists(select * from Customers where Mobile=@mobile)
				begin
					insert into Customers(Customer_FName,Customer_MName,Customer_LName,User_Name,Password,Mobile,Phone,Mail,Address,City,State_Name,Country,Zipcode,Created_By,Created_Date)
					values(@customer_fname,@customer_mname,@customer_lname,@user_name,@password,@mobile,@phone,@mail,@address,@city,@state_name,@country,@zipcode,@created_by,@created_date);
					select @Ret_Flag='0',@Ret_Msg='Regitration Successfully Completed'
				end
				else
				begin
					select @Ret_Flag='1',@Ret_Msg='Mobile Number Already Registered' --if moble number already registered
				end
			end
			else
			begin
				select @Ret_Flag='2',@Ret_Msg='Mail Already Registered' --if Customer Mail Id already registered
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
		--print 'Registration Completed 
		--WELLCOME to "xyz Shopping"
	end
END





GO
/****** Object:  StoredProcedure [dbo].[d_Product_from_Cart]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[d_Product_from_Cart](@Order_Id int
									,@Product_Id int
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		begin try
			if (@Order_Id IS NOT NULL)
			begin
				if(@Product_Id IS NOT NULL)
				begin
				 update Cart_Master set Active_Flag='0' where Order_Id=@Order_Id and Product_Id=@Product_Id
				 select @Ret_Flag='0',@Ret_Msg='Successfully Removed Product from your cart'
				end
				else
				select @Ret_Flag='2',@Ret_Msg='Please provide Product Id'
			end
			else
			select @Ret_Flag='1',@Ret_Msg='Please provide Order Id'
		end try
		begin catch
			select @Ret_Flag='-1',@Ret_Msg=error_message()
		end catch
	

    
END

GO
/****** Object:  StoredProcedure [dbo].[Delivery_Cinfirmation]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delivery_Cinfirmation](@Order_Shipper_Id int
										,@Delivery_Person_Name nvarchar(50)
										,@If_Delivery_Boy_Id int
										,@Received_By nvarchar(50)
										,@Received_Date datetime
										,@If_Others_Received_Relation nvarchar(50)
										,@Review_from_Customer nvarchar(50)
										,@Delivery_Status nvarchar(50)
										,@Added_By int
										,@Added_Date datetime
										,@Ret_Flag nvarchar(1) output
										,@Ret_Msg nvarchar(200) output
										)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if(@Order_Shipper_Id is NOT NULL)
		begin
			insert into Delivery_Confirmation(Order_To_Shipper_Id,Delivery_Person_Name,If_Delivery_Boy_Id,Received_By,Received_Date,If_Orthers_Received_Relation,Review_From_Customer,Added_By,Added_Date,Delivery_Status)
			values (@Order_Shipper_Id,@Delivery_Person_Name,@If_Delivery_Boy_Id,@Received_By,ISNULL(@Received_Date,getdate()),@If_Others_Received_Relation,@Review_from_Customer,@Added_By,IsNull(@Added_Date,getdate()),@Delivery_Status)
			select @Ret_Flag='0',@Ret_Msg='Thanks For Your Delivery Confirmation'
		end
		else
		select @Ret_Flag='1',@Ret_Msg='please provide Order to Shipper Id'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
 --   -- Insert statements for procedure here
	--SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Courier_Details]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Courier_Details](@Courier_SNo int
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if(@Courier_SNo is NOT NULL)
		begin 
			IF exists(select * from Transport_By_Courier where Courier_SNo=@Courier_SNo)
			begin
				select (select Courier_Name from Courier_Master where Courier_Id=c.Courier_Id) 'Courier Service Name',POD_No,Courier_Weight from Transport_By_Courier c
				where Courier_SNo=@Courier_SNo and Active_Flag=1
			end
			else
			select @Ret_Flag='2',@Ret_Msg='Courier Details are Empty Please try Another'
		end
		else
		select @Ret_Flag='1',@Ret_Msg='Please provide Courier Details'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Order_Cart]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_Order_Cart](@Order_Id int
								,@Ret_Flag nvarchar(1) output
								,@Ret_Msg nvarchar(200) output
								)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	if(@Order_Id is not null)
	begin
		if exists(select * from Cart_Master where Order_Id=@Order_Id)
		begin
			-- Insert statements for procedure here
			SELECT Product_Id,Product_Qty from Cart_Master where Order_Id=@Order_Id and Active_Flag='1'
		end
		else
		select @Ret_Flag='1',@Ret_Msg='Invalid Order Id'
	end
	else
	select @Ret_Flag='2',@Ret_Msg='Please Enter Order_Id'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END


GO
/****** Object:  StoredProcedure [dbo].[Get_Transport_Vehicle_Details]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Transport_Vehicle_Details](@Transport_Vehicle_Id int
							,@Ret_Flag nvarchar(1) output
								,@Ret_Msg nvarchar(200) output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON; 
	begin try
	if(@Transport_Vehicle_Id IS NOT NULL)
		begin
		if exists(select * from Transport_By_Vehicle where Transport_Vehicle_Id=@Transport_Vehicle_Id)
			begin
			select Transport_Vehicle_Type,Vehicle_Number,LR_Number,Driver_Name,Mobile from Transport_By_Vehicle where Transport_Vehicle_Id=@Transport_Vehicle_Id and Active_Flag=1
			end
		else
			select @Ret_Flag='2',@Ret_Msg='Invalid Transport_Vehicle_Id'
		end
	else
		select @Ret_Flag='1',@Ret_Msg='Please Enter Transport_Vehicle_Id'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Bill_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[i_Bill_Master](@Order_Id int
								,@Added_By int
								,@Added_Date datetime
								,@Ret_Flag nvarchar(1) output
								,@Ret_Msg nvarchar(1) output
								)

AS
declare @Bill money
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if (@Order_Id IS NOT NULL)
			begin
			select @Bill=sum(Product_Price) from products_in_cart where @Order_Id=@Order_Id
			insert into Bill_Master(Order_Id,Customer_Id,Bill_Amount,Bill_Date,Added_By,Added_Date)
			Values(@Order_Id,(select Customer_Id from Customer_Order where Order_Id=@Order_Id),@Bill,getdate(),@Added_By,ISNULL(@Added_Date,getdate()))
			select @Ret_Flag='0',@Ret_Msg='Bill Submitted'
		end
		else
			select @Ret_Flag='1',@Ret_Msg='Please Provide Order Id'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
    
END


GO
/****** Object:  StoredProcedure [dbo].[i_Courier_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Courier_Master](@Courier_Name nvarchar(50)
									,@Contact_Person nvarchar(50)
									,@Mobile numeric(10,0)
									,@Mail nvarchar(50)
									,@Added_By int
									,@Added_Date datetime
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Courier_Master(Courier_Name,Contact_Person,Mobile,Mail,Added_By,Added_Date)
						values(@Courier_Name,@Contact_Person,@Mobile,@Mail,@Added_By,ISNULL(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Added Successfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Employee]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Employee](@Emp_Type_Id int
							,@Emp_Name nvarchar(50)
							,@Gender nvarchar(10)
							,@Education_Level nvarchar(50)
							,@Job nvarchar(50)
							,@Hiredate date
							,@DOB date
							,@Mobile numeric(10,0)
							,@Telephone nvarchar(20)
							,@Email nvarchar(50)
							,@Address nvarchar(100)
							,@City nvarchar(50)
							,@Pincode Numeric(10,0)
							,@Salary money
							,@Bonus money
							,@Commisions money
							,@Added_By int
							,@Added_Date date
							,@Ret_Flag nvarchar(1) output
							,@Ret_Msg nvarchar(200) output
							)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	if not exists(select * from Employees where Mobile_No=@Mobile or Email=@Email)
	begin
		insert into Employees(Emp_Type_Id,Emp_Name,Gender,Educationlevel,Job,Hiredate,Dateofbirth,Mobile_No,Telephone,Email,Address,City,Pincode,Salary,Bonus,Commission,Added_By,Added_Date)
					   values(@Emp_Type_Id,@Emp_Name,@Gender,@Education_Level,@Job,@Hiredate,@DOB,@Mobile,@Telephone,@Email,@Address,@City,@Pincode,@Salary,@Bonus,@Commisions,@Added_By,@Added_Date)
		select @Ret_Flag='0',@Ret_Msg='Employee Added Successfully'
		select Emp_Id from Employees where Emp_Type_Id=@Emp_Type_Id and Emp_Name=@Emp_Name and Dateofbirth=@DOB and Mobile_No=@Mobile and Email=@Email
		end
	else
	select @Ret_Flag='1',@Ret_Msg='With Mobile/Email details Empoloyee already exists '
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Employee_Type]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Employee_Type](@Description nvarchar(50)
								,@Added_By int
								,@Added_Date datetime
								,@Ret_Flag nvarchar(1) output
								,@Ret_Msg nvarchar(200) output
								)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Employee_Type_Master(Description,Added_By,Added_Date) values(@Description,@Added_By,@Added_Date)
		select @Ret_Flag='0',@Ret_Msg='Employee Type Added Successfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Material_Supply_Company]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Material_Supply_Company](@Company_Name nvarchar(50)
											,@Contact_Person nvarchar(50)
											,@Mobile numeric(10,0)
											,@Mail nvarchar(50)
											,@Added_By int
											,@Added_Date datetime
											,@Ret_Flag nvarchar(1) output
											,@Ret_Msg nvarchar(200) output
											)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into MaterialSupplyCompany(Company_Name,Contact_Person,Mobile,Mail,Added_By,Added_Date)
		values(@Company_Name,@Contact_Person,@Mobile,@Mail,@Added_By,ISNULL(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Added Successfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch

END

GO
/****** Object:  StoredProcedure [dbo].[i_Order_to_Cart]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Order_to_Cart] (@Order_Id int
									,@Product_Id int
									,@Product_Qty int
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if (@Order_Id is NOT NULL)
		begin
			if (@Product_Id IS NOT NULL)
			begin
				if (@Product_Qty IS NOT NULL)
				begin
					insert into Cart_Master(Order_Id,Product_Id,Product_Qty,Order_Date)
					values(@Order_Id,@Product_Id,@Product_Qty,getdate())
					select @Ret_Flag='0',@Ret_Msg='Product Added to Cart Successfuly'
				end
				else
				select @Ret_Flag='3',@Ret_Msg='Please Provide Quantity of Product'
			END
			else
			select @Ret_Flag='2',@Ret_Msg='Please Provide Product Id'
		end
		else
		select @Ret_Flag='1',@Ret_Msg='Please Provide Order_Id'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Product_Category]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Product_Category](@category_name nvarchar(50)
									,@description nvarchar(max)
									,@photo_location nvarchar(max)
									,@created_by nvarchar(50)
									,@created_date datetime
									,@Ret_Flag nvarchar(2) output
									,@Ret_Msg nvarchar(200) output																		
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Product_Category(Category_Name,Description,Photo_Location,Added_By,Added_Date)
		values(@category_name,@description,@photo_location,@created_by,@created_date)
		commit transaction;
		select @Ret_Flag='0',@Ret_Msg='Submitted Sucessfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message() 
	end catch
END


GO
/****** Object:  StoredProcedure [dbo].[i_Product_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Product_Master](	@prod_cat_id int 
							,@product_name nvarchar(50)
							,@description nvarchar(max) 
							,@if_product_weight numeric(18,0)
							,@if_product_colour nvarchar(50)
							,@product_price money
							,@pieces_per_unit int
							,@price_per_unit money
							,@manufactured_by nvarchar(50)
							,@manufactured_date datetime
							,@expired_date datetime
							,@created_by nvarchar(50)
							,@created_date datetime
							,@Ret_Flag nvarchar(2) output
							,@Ret_Msg nvarchar(200)	output				
							)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Product_Master(Category_Id,Product_Name,Product_Description,If_Product_Weight,If_Product_Colour,Product_Price,Pieces_Per_Unit,Price_Per_Unit,Manufactured_By,Manufactured_Date,Expiry_Date,Added_By,Added_Date)
							values(@prod_cat_id,@product_name,@description,@if_product_weight,@if_product_colour,@product_price,@pieces_per_unit,@price_per_unit,@manufactured_by,@manufactured_date,@expired_date,@created_by,@created_date);
		commit transaction;
		select @Ret_Flag='0',@Ret_Msg='Submitted Sucessfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message() 
	end catch
END


GO
/****** Object:  StoredProcedure [dbo].[i_Shipper_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Shipper_Master](@Shipper_Name nvarchar(50)
									,@Address nvarchar(100)
									,@City nvarchar(50)
									,@Zipcode numeric(18,0)
									,@Contact_Person nvarchar(50)
									,@Mobile numeric(10,0)
									,@Mail nvarchar(50)
									,@FAX nvarchar(50)
									,@Licence_Copy nvarchar(max)
									,@Added_By int
									,@Added_Date datetime
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Shipper_Master(Shipper_Name,Address,City,Zipcode,Contact_Person,Mobile,Mail_Id,FAX,Licence_Copy,Added_By,Added_Date)
		values(@Shipper_Name,@Address,@City,@Zipcode,@Contact_Person,@Mobile,@Mail,@FAX,@Licence_Copy,@Added_By,ISNULL(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Added Successfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Tax_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Tax_Master](@Description	nvarchar(50)
							,@Percentage nvarchar(20)
							,@Added_By int
							,@Added_Date datetime
							,@Ret_Flag nvarchar(1) output
							,@Ret_Msg nvarchar(200) output
							)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if(@Percentage is NOT NULL)
		begin 
			insert into Taxes_Master(Description,Percentage,Added_By,Added_Date) values(@Description,@Percentage,@Added_By,ISNULL(@Added_Date,getdate()))
			select @Ret_Flag='0',@Ret_Msg='Tax added successfully'
		end
		else
			select @Ret_Flag='1',@Ret_Msg='Please provide Tax Percentage'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Tax_Order]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Tax_Order](@Tax_Id int
							,@Order_Id int
							,@Added_By int
							,@Added_Date datetime
							,@Ret_Flag nvarchar(1) output
							,@Ret_Msg nvarchar(200) output
							)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if(@Tax_Id is NOT NULL)
		begin
			if(@Order_Id is NOT NULL)
			begin
				insert into Tax_Order(Tax_Id,Order_Id,Added_By,Added_Date)values(@Tax_Id,@Order_Id,@Added_By,ISNULL(@Added_Date,getdate()))
				select @Ret_Flag='0',@Ret_Msg='Successfully Assign Tax to Order'
			end
			else
			select @Ret_Flag='2',@Ret_Msg='Please Provide Order Details'
		end
		else
		select @Ret_Flag='1',@Ret_Msg='Please Provide Tax Details'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
    
END

GO
/****** Object:  StoredProcedure [dbo].[i_Transport_By_Courier]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Transport_By_Courier](@Courier_Id int
										,@POD_No nvarchar(50)
										,@Courier_Weight numeric(18,3)
										,@Added_By int
										,@Added_Date datetime
										,@Ret_Flag nvarchar(1) output
										,@Ret_Msg nvarchar(200) output
										)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if(@Courier_Id IS NOT NULL)
		begin
			if(@POD_No IS NOT NULL)
			begin 
				insert into Transport_By_Courier(Courier_Id,POD_No,Courier_Weight,Added_By,Added_Date)
										values(@Courier_Id,@POD_No,@Courier_Weight,@Added_By,ISNULL(@Added_Date,getdate()))
				select @Ret_Flag='0',@Ret_Msg='Process Successfully Completed'
			end
			else
			 select @Ret_Flag='2',@Ret_Msg='Please Provide POD Number'
		end
		else
		select @Ret_Flag='1',@Ret_Msg='Please Provide Courier Details'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Transport_By_Vehicle]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Transport_By_Vehicle](@Transport_Vehicle_Type int
										,@Vehicle_Number nvarchar(20)
										,@LR_Number nvarchar(50)
										,@Driver_Name nvarchar(50)
										,@Mobile numeric(10,0)
										,@Added_By int 
										,@Added_Date datetime
										,@Ret_Flag nvarchar(1) output
										,@Ret_Msg nvarchar(200) output
										)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Transport_By_Vehicle(Transport_Vehicle_Type,Vehicle_Number,LR_Number,Driver_Name,Mobile,Added_By,Added_Date)
			values(@Transport_Vehicle_Type,@Vehicle_Number,@LR_Number,@Driver_Name,@Mobile,@Added_By,ISNULL(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Successfully Completed'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Transportation]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Transportation](@Transport_Type nvarchar(50)
								,@Added_By int
								,@Added_Date datetime
								,@Ret_Flag nvarchar(1) output
								,@Ret_Msg nvarchar(200) output
								)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Transportation(Transport_type,Added_By,Added_Date) values(@Transport_Type,@Added_By,ISNULL(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Transportation type Added Successfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
    
END

GO
/****** Object:  StoredProcedure [dbo].[i_Trasnport_By_Hand]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Trasnport_By_Hand](@Person_Name nvarchar(50)
									,@Mobile numeric(10,0)
									,@Photo_Location nvarchar(max)
									,@Identity_Proff nvarchar(50)
									,@Identity_Proff_Id nvarchar(50)
									,@Added_By int
									,@Added_Date datetime
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Transport_By_Hand(Person_Name,Mobile,Photo,Identity_Proff,Identity_Proff_Id,Added_By,Added_Date)
			values(@Person_Name,@Mobile,@Photo_Location,@Identity_Proff,@Identity_Proff_Id,@Added_By,ISNULL(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Successfully Completed'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[i_Vehicle_Type_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[i_Vehicle_Type_Master](@Description nvarchar(50)
										,@Added_By int
										,@Added_Date datetime
										,@Ret_Flag nvarchar(1) output
										,@Ret_Msg nvarchar(200) output
										)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		insert into Vehicle_Type_Master(Description,Added_By,Added_Date)
				values(@Description,@Added_By,isnull(@Added_Date,getdate()))
		select @Ret_Flag='0',@Ret_Msg='Successfully Added'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[u_Product_in_Cart]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[u_Product_in_Cart](@Order_Id int
									,@Product_Id int
									,@Updated_Qty int
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(200) output
									)
AS
declare @Old_Qty int;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		begin try
			if (@Order_Id IS NOT NULL)
			begin
				if(@Product_Id IS NOT NULL)
				begin
				select @Old_Qty=Product_Qty from Cart_Master where Order_Id=@Order_Id and Product_Id=@Product_Id
				if (@Old_Qty<>@Updated_Qty)
					begin
						 update Cart_Master set Product_Qty=@Updated_Qty where Order_Id=@Order_Id and Product_Id=@Product_Id
						 select @Ret_Flag='0',@Ret_Msg='Updated Successfully'
					end
					else
					select @Ret_Flag='3',@Ret_Msg='Product Quantity is same as Old Quantity NO need to change'
				end
				else
				select @Ret_Flag='2',@Ret_Msg='Please provide Product Id'
			end
			else
			select @Ret_Flag='1',@Ret_Msg='Please provide Order Id'
		end try
		begin catch
			select @Ret_Flag='-1',@Ret_Msg=error_message()
		end catch
	

    
END

GO
/****** Object:  UserDefinedFunction [dbo].[Get_Courier_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Courier_Name](@Courier_Id int
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Name nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Name=Courier_Name from Courier_Master where Courier_Id=@Courier_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Name

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Customer_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Get_Customer_Name](@Customer_Id int)

RETURNS nvarchar(200)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Customer_Name nvarchar(200)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Customer_Name=Customer_FName + ' ' +Customer_MName + ' ' +Customer_LName from Customers where Customer_Id=@Customer_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Customer_Name

END



GO
/****** Object:  UserDefinedFunction [dbo].[Get_Customer_User_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Get_Customer_User_Name](@Customer_Id int)

RETURNS nvarchar(200)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @User_Name nvarchar(200)

	-- Add the T-SQL statements to compute the return value here
	SELECT @User_Name=User_Name from Customers where Customer_Id=@Customer_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @User_Name

END



GO
/****** Object:  UserDefinedFunction [dbo].[Get_Employee_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Employee_Name](@Emp_Id int)

RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Emp_Name nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Emp_Name=Emp_Name from Employees where Emp_Id=@Emp_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Emp_Name

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Product_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Product_Name](@Product_Id int)

RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Product_Name nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Product_Name=Product_Name from Product_Master where Product_Id=@Product_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Product_Name

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Product_Price]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Product_Price](@Product_Id int)

RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Product_Price nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Product_Price=Product_Price from Product_Master where Product_Id=@Product_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Product_Price

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Shipper_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Shipper_Name](@Shipper_Id int)

RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Shipper_Name nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Shipper_Name=Shipper_Name from Shipper_Master where Shipper_Id=@Shipper_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Shipper_Name

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Transportation_Type]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Transportation_Type](@Transportation_Id int)
RETURNS nvarchar
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Transport_type nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Transport_type=Transport_type from Transportation where Transportation_Id=@Transportation_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Transport_type

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Transporter_Mobile]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Transporter_Mobile](@Transporter_Id int
)
RETURNS numeric(10,0)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @No numeric(10,0)

	-- Add the T-SQL statements to compute the return value here
	SELECT @No=Mobile from Transport_By_Hand where Transporter_Id=@Transporter_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @No

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Transporter_Name]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Transporter_Name](@Transporter_Id int
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Name nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Name=Person_Name from Transport_By_Hand where Transporter_Id=@Transporter_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Name

END


GO
/****** Object:  UserDefinedFunction [dbo].[Get_Vehicle_Type]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Get_Vehicle_Type](@Vehicle_Type_Id int)
RETURNS nvarchar
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Vehicle_Type nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Vehicle_Type=Description from Vehicle_Type_Master where Vehicle_Type_Id=@Vehicle_Type_Id and Active_Flag=1

	-- Return the result of the function
	RETURN @Vehicle_Type

END


GO
/****** Object:  Table [dbo].[Bill_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill_Master](
	[Bill_Id] [int] identity(1000,1) primary key,
	[Order_Id] [int] references Customer_Order(Order_Id),
	[Customer_Id] [int] references Customers(Customer_Id),
	[Taxes_Amount] [money] NULL,
	[Bill_Amount] [money] NULL,
	[Bill_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) Default ('1'),
	[Payment_Confirmation_Flag] [nvarchar](1) NULL,
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cart_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart_Master](
	[Cart_Id] [int] identity(1000,1) primary key,
	[Order_Id] [int] references Customer_Order(Order_Id),
	[Product_Id] [int] references Product_Master(Product_Id),
	[Product_Qty] [int] NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Order_Date] [datetime] default(getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Courier_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courier_Master](
	[Courier_Id] [int] identity(100,1) primary key,
	[Courier_Name] [nvarchar](50) NULL,
	[Contact_Person] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Mail] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer_Order]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Order](
	[Order_Id] [int] identity(1000,1) primary key,
	[Customer_Id] [int] references Customers(Customer_Id),
	[Active_Flag] [nvarchar](1) default('1')
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Customer_Id] [int] Identity(1000,1) primary key,
	[Customer_FName] [nvarchar](50) NULL,
	[Customer_MName] [nvarchar](50) NULL,
	[Customer_LName] [nvarchar](50) NULL,
	[User_Name] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Mobile] [numeric](18, 0) NULL,
	[Phone] [nvarchar](20) NULL,
	[Mail] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[State_Name] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Zipcode] [numeric](10, 0) NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_Date] [datetime] Default(getdate()),
	[Last_Updated_By] [nvarchar](50) NULL,
	[Last_Updated_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) default('1')
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Delivery_Confirmation]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery_Confirmation](
	[SNo] [int] NULL,
	[Order_To_Shipper_Id] [int] NULL,
	[Delivery_Person_Name] [nvarchar](50) NULL,
	[If_Delivery_Boy_Id] [int] NULL,
	[Received_By] [nvarchar](50) NULL,
	[Received_Date] [datetime] NULL,
	[If_Orthers_Received_Relation] [nvarchar](50) NULL,
	[Review_From_Customer] [nvarchar](100) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL,
	[Delivery_Status] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee_Type_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Type_Master](
	[Emp_Type_Id] [int] IDENTITY(10,1) primary key,
	[Description] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](50) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Emp_Id] [int] identity(100,1) primary key,
	[Emp_Type_Id] [int] references Employee_Type_Master(Emp_Type_Id),
	[Emp_Name] [nvarchar](50) NULL,
	[Gender] [nvarchar](10) NULL,
	[Educationlevel] [nvarchar](100) NULL,
	[Job] [nvarchar](50) NULL,
	[Hiredate] [date] NULL,
	[Dateofbirth] [date] NULL,
	[Mobile_No] [numeric](10, 0) NULL,
	[Telephone] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Pincode] [numeric](10, 0) NULL,
	[Salary] [money] NULL,
	[Bonus] [money] NULL,
	[Commission] [money] NULL,
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id) NULL,
	[Last_Updated_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) default('1')
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice_Bill]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Bill](
	[Invoice_Bill_Id] [int] identity(1000,1) primary key,
	[Invoice_Id] [int] references Invoice_Master(Invoice_Id),
	[Total_Amount] [money] NULL,
	[Vat_Amount] [money] NULL,
	[Swach_Bharat_Tax] [money] NULL,
	[Other_Taxes] [money] NULL,
	[Grand_Total] [money] NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Master](
	[Invoice_Id] [int] identity(1000,1) primary key,
	[Dispatch_To] [nvarchar](50) NULL,
	[Supplier_Id] [int] NULL,
	[Total_Amount] [money] NULL,
	[Invoice_Copy_Image_Location] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inward_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inward_Master](
	[Inward_SNo] [int] identity(1000,1) primary key,
	[Invoice_Id] [int]  references Invoice_Master(Invoice_Id),
	[Material_Type] [nvarchar](50) NULL,
	[Product_Id] [int] references Product_Master(Product_Id),
	[Quantity] [nvarchar](50) NULL,
	[If_Weight] [numeric](18, 0) NULL,
	[If_Coloured] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [money] NULL,
	[Amount] [money] NULL,
	[Transport_Ttype_Id] [int] NULL,
	[Company_Id] [int] NULL,
	[Inward_By] [int] NULL,
	[Inward_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaterialSupplyCompany]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialSupplyCompany](
	[Company_Id] [int] identity(100,1) primary key,
	[Company_Name] [nvarchar](50) NOT NULL,
	[Contact_Person] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Mail] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[updated_By] [int] references Employees(Emp_Id),
	[updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_To_Shipper]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_To_Shipper](
	[Order_To_Shipper_Id] [int] Identity(1000,1) primary key,
	[Order_Id] [int] references Customer_Order(Order_Id),
	[Shipper_Id] [int] references Shipper_Master(Shipper_Id),
	[Assigned_By] [int] references Employees(Emp_Id),
	[Assigned_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Dispatched_Date] [datetime] NULL,
	[Expected_Delivery_Date] [datetime] NULL,
	[Delivery_Confirmation_Flag] [nvarchar](1) default('0'),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_By_Card]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_By_Card](
	[Id] [int] identity(1,1) primary key,
	[Order_Id] [int]  references Customer_Order(Order_Id),
	[Card_No] [numeric](16, 0) NULL,
	[Name_On_Card] [nvarchar](100) NULL,
	[Card_Type_Name] [nvarchar](50) NULL,
	[Month_Valid] [int] NULL,
	[Year_Valid] [int] NULL,
	[CVV] [int] NULL,
	[Pin] [numeric](18, 0) NULL,
	[OTP] [nvarchar](20) NULL,
	[Active_Flag] [nvarchar](1) default('1')
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_By_Internet_Banking]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_By_Internet_Banking](
	[Id] [int] identity(1,1) primary key,
	[Bank_Name] [nvarchar](50) NULL,
	[URL] [nvarchar](max) NULL,
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL,
	Active_Flag nvarchar(1) default('1')
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_Confirmation]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Confirmation](
	[Id] [int] identity(1,1) primary key,
	[Order_Id] [int]  references Customer_Order(Order_Id),
	[Payment_Mode_Id] [int] NULL,
	[Paid_Amount] [money] NULL,
	[Payment_Refference_Number] [nvarchar](50) NULL,
	[Date_Of_Payment] [datetime] NULL,
	[Payment_Success_Flag] [nvarchar](1) NULL,
	[Active_Flag] [nvarchar](1) default('1')
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_Type_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Type_Master](
	[Payment_Method_Type_Id] [int] identity(100,1),
	[Payment_Type] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Category]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Category](
	[Category_Id] [int] IDENTITY(10,1) primary key,
	[Category_Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Photo_Location] [nvarchar](max) NULL,
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) default('1')
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Master](
	[Product_Id] [int] identity(1,1) primary key,
	[Category_Id] [int] references Product_Category(Category_Id),
	[Product_Name] [nvarchar](100) NULL,
	[Product_Description] [nvarchar](200) NULL,
	[If_Product_Weight] [numeric](18, 3) NULL,
	[If_Product_Colour] [nvarchar](50) NULL,
	[Product_Price] [money] NULL,
	[Pieces_Per_Unit] [int] NULL,
	[Price_Per_Unit] [money] NULL,
	[Manufactured_By] [nvarchar](50) NULL,
	[Manufactured_Date] [datetime] NULL,
	[Expiry_Date] [datetime] NULL,
	[Quantities_In_Store] [int] NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] int references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipper_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipper_Master](
	[Shipper_Id] [int] identity(100,1) primary key,
	[Shipper_Name] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Zipcode] [numeric](18, 0) NULL,
	[Contact_Person] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Mail_Id] [nvarchar](50) NULL,
	[FAX] [nvarchar](50) NULL,
	[Licence_Copy] [nvarchar](max) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tax_Order]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tax_Order](
	[Tax_Order_Id] [int] identity(1,1) primary key,
	[Tax_Id] [int] references Taxes_Master(Tax_Id),
	[Order_Id] [int] references Customer_Order(Order_Id),
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Taxes_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Taxes_Master](
	[Tax_Id] [int] identity(1,1) primary key,
	[Description] [nvarchar](50) NULL,
	[Percentage] [nvarchar](20) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Last_Updated_By] [int] references Employees(Emp_Id),
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transport_By_Courier]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport_By_Courier](
	[Courier_SNo] [int] identity(100,1),
	[Courier_Id] [int] references Courier_Master(Courier_Id),
	[POD_No] [nvarchar](50) NULL,
	[Courier_Weight] [numeric](18, 3) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Updated_By] [int] references Employees(Emp_Id),
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transport_By_Hand]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport_By_Hand](
	[Transporter_Id] [int] identity(100,1) primary key,
	[Person_Name] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Photo] [nvarchar](max) NULL,
	[Identity_Proff] [nvarchar](50) NULL,
	[Identity_Proff_Id] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) Default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Updated_By] [int] references Employees(Emp_Id),
	[Updated_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transport_By_Vehicle]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport_By_Vehicle](
	[Transport_Vehicle_Id] [int] identity(100,1) primary key,
	[Transport_Vehicle_Type] [int] references Vehicle_Type_Master(Vehicle_Type_Id),
	[Vehicle_Number] [nvarchar](20) NULL,
	[LR_Number] [nvarchar](50) NULL,
	[Driver_Name] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Updated_By] [int] references Employees(Emp_Id),
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transportation]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transportation](
	[Transportation_Id] [int] identity(1000,1) primary key,
	[Transport_type] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Updated_By] [int] references Employees(Emp_Id),
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vehicle_Type_Master]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle_Type_Master](
	[Vehicle_Type_Id] [int] identity(100,1) primary key,
	[Description] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) default('1'),
	[Added_By] [int] references Employees(Emp_Id),
	[Added_Date] [datetime] default(getdate()),
	[Updated_By] [int] references Employees(Emp_Id),
	[Updated_Date] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[products_in_cart]    Script Date: 4/4/2017 3:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[products_in_cart]
as
select c.Order_Id,c.Product_Id,p.Product_Price from Product_Master p,Cart_Master c
					where  c.Product_Id=p.Product_Id
GO
ALTER TABLE [dbo].[Bill_Master] ADD  DEFAULT (getdate()) FOR [Bill_Date]
GO
ALTER TABLE [dbo].[Cart_Master] ADD  DEFAULT (getdate()) FOR [Order_Date]
GO
ALTER TABLE [dbo].[Courier_Master] ADD  DEFAULT ('1') FOR [Active_Flag]
GO
ALTER TABLE [dbo].[Courier_Master] ADD  DEFAULT (getdate()) FOR [Added_Date]
GO
