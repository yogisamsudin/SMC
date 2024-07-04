

select * from appCommonParameter where type='guaranteedevsts'
go
if @@ROWCOUNT=0
	insert into appCommonParameter(code,Keterangan,type)values('1','None','guaranteedevsts'),('2','Garansi','guaranteedevsts')
go

select * from appCommonParameter where type='availability'
go
if @@ROWCOUNT=0
	insert into appCommonParameter(code,Keterangan,type)values('1','Ready','availability'),('2','Inden','availability')
go


alter table opr_sales_device add  guarantee_id varchar(1)
alter table opr_sales_device add availability_id varchar(1)
alter table opr_sales_device add inden int
update opr_sales_device set inden=0
go

create function opr_vendor_validatorcheck(@vendor_id int) returns varchar(200)
as begin
return
isnull((select 
case 
	when vendor_location_id =0 then 'Lokasi vendor tidak diisi' 
	when contact_name is null or contact_name = '' then 'Nama kontak vendor tidak diisi'
	when phone1 is null or phone1 = '' then 'Telepon vendor tidak diisi'
	when not exists(select 'x' from opr_vendor_category where vendor_id=1092)  then 'Ketegori Vendor tidak diketahui'
	else ''
end as err_message
from opr_vendor where vendor_id=@vendor_id),'')
end
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
@user_id varchar(25) = null,
@draft_sts bit = 0,
@guarantee_id varchar(1) = null,
@availability_id varchar(1) = null,
@inden int = 0,
@retval varchar(200) out
as begin
set nocount on
set transaction isolation level read committed
declare @keterangan varchar(8000)
set @keterangan=@description
set @description=case when @keterangan='' then null else @description end

set @retval = dbo.opr_vendor_validatorcheck(@vendor_id)
if(@retval='')
	begin
	update opr_sales_device set draft_sts=@draft_sts,cost=@cost, principal_price=@principal_price,price=@price, qty=@qty,pph21_sts=@pph21_sts, description=@description, vendor_id=case when @vendor_id=0 then null else @vendor_id end, marketing_note=@marketing_note, update_id=@user_id, update_date=getdate(),
		guarantee_id=@guarantee_id, availability_id=@availability_id, inden=@inden where sales_id=@sales_id and device_id=@device_id
	if @@ROWCOUNT=0
		insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price, creator_id, create_date, draft_sts,
			guarantee_id,availability_id,inden)
			values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price,@user_id, getdate(),@draft_sts ,
			@guarantee_id,@availability_id,@inden)
	end
end
go

ALTER VIEW [dbo].[v_opr_sales_device]
AS
SELECT dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, dbo.tec_device.device, dbo.opr_sales_device.qty, ISNULL(dbo.opr_sales_device.description, '') AS description, 
             CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, dbo.opr_sales_device.principal_price, dbo.opr_sales_device.price AS price_customer, 
             dbo.opr_sales_device.marketing_note, dbo.opr_sales_device.creator_id, dbo.opr_sales_device.create_date, dbo.opr_sales_device.update_id, dbo.opr_sales_device.update_date, dbo.opr_sales_device.draft_sts, 
			 dbo.opr_sales_device.guarantee_id, dbo.opr_sales_device.availability_id, dbo.opr_sales_device.inden,
			 guaranteedevsts.Keterangan guarantee_name, availabile.Keterangan availability_name
FROM   dbo.opr_sales_device INNER JOIN
             dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
             dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
             dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id
			 left join appCommonParameter guaranteedevsts on guaranteedevsts.Code=dbo.opr_sales_device.guarantee_id and guaranteedevsts.Type='guaranteedevsts'
			 left join appCommonParameter availabile on availabile.Code=dbo.opr_sales_device.availability_id and availabile.Type='availability' 
GO

