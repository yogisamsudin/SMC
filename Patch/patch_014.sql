use test4
go

alter table act_marketing add assistant_user_id varchar(15)
go


ALTER VIEW [dbo].[v_act_marketing]
AS
SELECT dbo.act_marketing.marketing_id, dbo.act_marketing.marketing_name, dbo.act_marketing.marketing_phone, dbo.act_marketing.user_id, dbo.act_marketing.all_access, dbo.act_marketing.dashboard_visible, dbo.act_marketing.target_value, dbo.act_marketing.ttd_image, 
             dbo.act_marketing.file_type, dbo.act_marketing.marketing_group_id, dbo.act_marketing_group.marketing_group_name, dbo.act_marketing.assistant_user_id
FROM   dbo.act_marketing LEFT OUTER JOIN
             dbo.act_marketing_group ON dbo.act_marketing.marketing_group_id = dbo.act_marketing_group.marketing_group_id
GO

ALTER proc [dbo].[aspx_sales_list]
@customer varchar(50),
@user varchar(15),
@branch_id varchar(10) = '%'
as begin
declare @all_access bit,@marketing_id varchar(15)

select @all_access=all_access,@marketing_id=marketing_id from act_marketing where [user_id]=@user or assistant_user_id=@user

select sales_id,customer_id,dbo.f_convertDateToChar(sales_call_date) str_sales_call_date,sales_call_date,customer_name,an_id,contact_id,
	delivery_address,note,contact_name,an,marketing_id, delivery_address_location_id, delivery_address_location,fee,branch_name 
	from v_act_sales 
	where customer_name like @customer and (@all_access=1 or (@all_access=0 and marketing_id=@marketing_id)) 
	and sales_id not in (select sales_id from opr_sales) and branch_id like @branch_id
	order by sales_call_date, customer_name
end
go

ALTER proc [dbo].[aspx_service_list]
@customer varchar(50),
@user varchar(15),
@branch_id varchar(10) = '%'
as begin
declare @all_access bit,@marketing_id varchar(15)

select @all_access=all_access,@marketing_id=marketing_id from act_marketing where [user_id]=@user or assistant_user_id=@user

select service_id,dbo.f_convertDateToChar(service_call_date)str_service_call_date,service_call_date,customer_name,pickup_address_location, pickup_address,an,contact_name,dbo.f_convertDateToChar(pickup_date)str_pickup_date,pickup_date, branch_name from v_act_service 
	where expedition_type_id='2' and 	
	customer_name like @customer and 
	(@all_access=1 or (@all_access=0 and marketing_id=@marketing_id)) 
	and service_id not in (select service_id from exp_schedule_service) and branch_id like @branch_id
	order by service_call_date, customer_name
end
go


ALTER proc [dbo].[act_marketing_save]
@marketing_id varchar(15),
@marketing_name varchar(50),
@marketing_phone varchar(15),
@user_id varchar(15),
@all_access bit,
@dashboard_visible bit,
@target_value money,
@marketing_group_id int = null,
@ttd_image image = null,
@assistant_user_id varchar(15) = null
as begin
set transaction isolation level read committed
update act_marketing set marketing_name=@marketing_name, marketing_phone=@marketing_phone,[user_id]=@user_id,all_access=@all_access,
	dashboard_visible=@dashboard_visible,target_value=@target_value, marketing_group_id=@marketing_group_id,
	ttd_image=case when @ttd_image is null then ttd_image else @ttd_image end,assistant_user_id=case when @assistant_user_Id='' then null else @assistant_user_Id end
	where marketing_id=@marketing_id 
if @@rowcount=0
 insert into act_marketing(marketing_id,marketing_name,marketing_phone,[user_id],all_access, dashboard_visible,
	target_value, marketing_group_id, ttd_image, file_type, assistant_user_id)
	values(@marketing_id,@marketing_name,@marketing_phone,@user_id,@all_access, @dashboard_visible,
		@target_value, @marketing_group_id,@ttd_image,'image/jpeg',case when @assistant_user_Id='' then null else @assistant_user_Id end)
end
go
