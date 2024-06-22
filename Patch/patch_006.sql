/*
update list
D:\source\smc\testing\v_4\App_Code\activities.cs
D:\source\smc\testing\v_4\activities\operation\opr_sales.aspx
*/
alter table opr_sales_device add creator_id varchar(25)
alter table opr_sales_device add create_date datetime
alter table opr_sales_device add update_id varchar(25)
alter table opr_sales_device add update_date datetime
go

ALTER proc [dbo].[opr_sales_device_save]
@sales_id bigint,
@device_id int,
@cost money,
@price money,
@qty smallint,
@pph21_sts bit,
@description text = null,
@vendor_id int = null,
@principal_price money = 0,
@marketing_note text = null,
@user_id varchar(25) = null
as begin
set nocount on
set transaction isolation level read committed
declare @keterangan varchar(8000)
set @keterangan=@description
set @description=case when @keterangan='' then null else @description end

update opr_sales_device set cost=@cost, principal_price=@principal_price,price=@price, qty=@qty,pph21_sts=@pph21_sts, description=@description, vendor_id=case when @vendor_id=0 then null else @vendor_id end, marketing_note=@marketing_note, update_id=@user_id, update_date=getdate()  where sales_id=@sales_id and device_id=@device_id
if @@ROWCOUNT=0
	insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price, creator_id, create_date)values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price,@user_id, getdate() )
end
go

ALTER VIEW [dbo].[v_opr_sales_device]
AS
SELECT dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, dbo.tec_device.device, dbo.opr_sales_device.qty, ISNULL(dbo.opr_sales_device.description, '') AS description, 
             CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, dbo.opr_sales_device.principal_price, dbo.opr_sales_device.price AS price_customer, 
             dbo.opr_sales_device.marketing_note, dbo.opr_sales_device.creator_id, dbo.opr_sales_device.create_date, dbo.opr_sales_device.update_id, dbo.opr_sales_device.update_date
FROM   dbo.opr_sales_device INNER JOIN
             dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
             dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
             dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id
GO

