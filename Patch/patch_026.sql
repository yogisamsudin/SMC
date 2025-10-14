ALTER TABLE [dbo].[tec_service_device_component] ADD  [vendorname] varchar(100)
go

ALTER VIEW [dbo].[v_tec_service_device_component]
AS
SELECT        dbo.tec_service_device_component.service_device_id, dbo.tec_service_device_component.device_id, dbo.tec_service_device_component.cost, 
                         dbo.tec_service_device_component.total, dbo.tec_device.device,
						 dbo.tec_service_device_component.reqpurchase_sts,dbo.tec_service_device_component.purchasedone_sts,
						 dbo.tec_service_device_component.vendorname
FROM            dbo.tec_service_device_component INNER JOIN
                         dbo.tec_device ON dbo.tec_service_device_component.device_id = dbo.tec_device.device_id
GO

ALTER proc [dbo].[tec_service_device_component_save]
@service_device_id bigint,
@device_id int,
@cost money,
@total smallint,
@reqpurchase_sts bit = 0,
@purchasedone_sts bit = 0,
@vendorname varchar(100)
as begin
set nocount on
set transaction isolation level read committed
update tec_service_device_component set cost=@cost, total=@total,
	reqpurchase_sts=@reqpurchase_sts,purchasedone_sts=@purchasedone_sts, vendorname=@vendorname
	where service_device_id=@service_device_id and device_id=@device_id
if @@rowcount=0
	insert into tec_service_device_component(service_device_id,device_id,cost,total,reqpurchase_sts,purchasedone_sts,vendorname)
		values(@service_device_id,@device_id,@cost,@total,@reqpurchase_sts,@purchasedone_sts,@vendorname)
end
go

-- selesai
ALTER TABLE [dbo].[tec_service_device_component] ADD  [reqpurchase_sts] bit
ALTER TABLE [dbo].[tec_service_device_component] ADD  [purchasedone_sts] bit
GO
update tec_service_device_component set [reqpurchase_sts]=0,[purchasedone_sts]=0
go

ALTER VIEW [dbo].[v_tec_service_device_component]
AS
SELECT        dbo.tec_service_device_component.service_device_id, dbo.tec_service_device_component.device_id, dbo.tec_service_device_component.cost, 
                         dbo.tec_service_device_component.total, dbo.tec_device.device,
						 dbo.tec_service_device_component.reqpurchase_sts,dbo.tec_service_device_component.purchasedone_sts,
						 dbo.tec_service_device_component.vendorname
FROM            dbo.tec_service_device_component INNER JOIN
                         dbo.tec_device ON dbo.tec_service_device_component.device_id = dbo.tec_device.device_id
GO



create proc xmlgrid_service_device_component
@sn varchar(100),
@customer_name varchar(100)
as begin
select * from (
select 
tec_service_device.sn,tec_service_device.device,tec_service_device.customer_name,
tec_device.device component, total, cost,tec_service_device_component.service_device_id,tec_service_device_component.device_id, tec_service_device.service_id
from tec_service_device_component 
inner join tec_device on tec_service_device_component.device_id=tec_device.device_id
inner join v_tec_service_device tec_service_device on tec_service_device_component.service_device_id=tec_service_device.service_device_id
where reqpurchase_sts=1 and purchasedone_sts=0 and sn like @sn and tec_service_device.customer_name like @customer_name
)a
for xml auto, xmldata
end
go