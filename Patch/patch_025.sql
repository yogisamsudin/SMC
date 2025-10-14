alter table act_customer add top_id char(1)
alter table act_customer add top_value int
GO
update act_customer set top_value=0
go
create TABLE [dbo].[act_customer_toplog](
	[user_id] [varchar](50) not null,
	[customer_id] [bigint] NOT NULL,
	[createdate] [datetime] NOT NULL,
	[top_id] [char](1) NOT NULL,
	[top_value] [int] NOT NULL
) ON [PRIMARY]
GO



ALTER proc [dbo].[act_customer_finance_update]
@customer_id bigint,
@npwp varchar(50),
@tkuid varchar(50),
@jenisidpembeli_id varchar(15),
@top_id char(1) = null,
@top_value int = 0,
@user_id varchar(50) = 'sa'
as begin
declare @l_top_id char(1), @l_top_value int

select @l_top_id=top_id,@l_top_value=top_value from act_customer where customer_id=@customer_id

if(@l_top_id!=@top_id or @l_top_value!=@top_value)
	insert into [act_customer_toplog](user_id,customer_id,createdate,top_id,top_value)values
	(@user_id,@customer_id,GETDATE(),@l_top_id,@l_top_value)

update act_customer set npwp=@npwp, tkuid=@tkuid, jenisidpembeli_id=@jenisidpembeli_id,
	top_id=@top_id, top_value=@top_value
	where customer_id=@customer_id
end
go

ALTER VIEW [dbo].[v_act_customer]
AS
SELECT dbo.act_customer.customer_id, dbo.act_customer.customer_name, dbo.act_customer.customer_phone, dbo.act_customer.customer_fax, dbo.act_customer.marketing_id, dbo.act_customer.customer_email, dbo.act_marketing.marketing_name, dbo.act_marketing.marketing_phone, 
             dbo.act_marketing.all_access, dbo.act_customer.customer_address, dbo.act_customer.customer_address_location_id, dbo.exp_location.location_address AS customer_address_location, ISNULL(dbo.exp_location.distance, 0) AS distance, dbo.act_customer.group_customer_id, 
             act_customer_1.customer_name AS group_customer, dbo.act_customer.npwp, dbo.act_customer.address_id, dbo.exp_address.latitude, dbo.exp_address.longitude, dbo.act_customer.branch_id, dbo.par_branch.branch_name, dbo.act_customer.user_device_mandatory, 
             dbo.act_customer.jenisidpembeli_id, dbo.act_jenisidpembeli.jenisidpembeli_name, dbo.act_customer.tkuid, dbo.act_customer.alt_code, dbo.act_customer.status,
			 dbo.act_customer.top_id,dbo.act_customer.top_value,ttop.Keterangan top_name
FROM   dbo.act_customer INNER JOIN
             dbo.act_marketing ON dbo.act_customer.marketing_id = dbo.act_marketing.marketing_id INNER JOIN
             dbo.act_customer AS act_customer_1 ON dbo.act_customer.group_customer_id = act_customer_1.customer_id LEFT OUTER JOIN
             dbo.par_branch ON dbo.act_customer.branch_id = dbo.par_branch.branch_id LEFT OUTER JOIN
             dbo.exp_address ON dbo.act_customer.address_id = dbo.exp_address.address_id LEFT OUTER JOIN
             dbo.exp_location ON dbo.act_customer.customer_address_location_id = dbo.exp_location.location_id LEFT OUTER JOIN
             dbo.act_jenisidpembeli ON dbo.act_jenisidpembeli.jenisidpembeli_id = dbo.act_customer.jenisidpembeli_id
			 left join dbo.appCommonParameter ttop on ttop.Code=dbo.act_customer.top_id and ttop.Type='top'
GO

create VIEW [dbo].[v_act_customer_toplog]
AS
SELECT dbo.act_customer_toplog.user_id, dbo.act_customer_toplog.customer_id, dbo.act_customer_toplog.createdate, dbo.act_customer_toplog.top_id, dbo.act_customer_toplog.top_value, dbo.appCommonParameter.Keterangan AS top_name
FROM   dbo.act_customer_toplog INNER JOIN
             dbo.appCommonParameter ON dbo.act_customer_toplog.top_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'top'
GO

