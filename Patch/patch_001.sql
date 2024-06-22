/*
4	Tambahan note pd device penawaran penjualan	30 Jan 2021	17 Feb 2021	done
5	Perubahan nilai target dr 130jt ke 150jt	30 Jan 2021	12 Feb 2021	Done
6	Menghilangkan nilai ppn di invoice dan penawaran jika customernya SMC bukan surya gemilang	30 Jan 2021	16 Feb 2021	done

daftar update web file:
activities.asmx
opr_sales.aspx
opr_service.aspx
service_confirm.aspx
sales_confirm.aspx
sales_offering.rpt
service_offering.rpt
*/

ALTER TABLE opr_sales_device ADD marketing_note text
GO

ALTER VIEW [dbo].[v_opr_sales_device]
AS
SELECT        dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, dbo.tec_device.device, dbo.opr_sales_device.qty, 
                         ISNULL(dbo.opr_sales_device.description, '') AS description, CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, 
                         dbo.opr_sales_device.principal_price, dbo.opr_sales_device.price * (dbo.opr_sales.ppn / 100 + 1) AS price_customer, dbo.opr_sales_device.marketing_note
FROM            dbo.opr_sales_device INNER JOIN
                         dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
                         dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
                         dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id
GO

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
@marketing_note text = null
as begin
set nocount on
set transaction isolation level read committed
declare @keterangan varchar(8000)
set @keterangan=@description
set @description=case when @keterangan='' then null else @description end

update opr_sales_device set cost=@cost, principal_price=@principal_price,price=@price, qty=@qty,pph21_sts=@pph21_sts, description=@description, vendor_id=case when @vendor_id=0 then null else @vendor_id end, marketing_note=@marketing_note  where sales_id=@sales_id and device_id=@device_id
if @@ROWCOUNT=0
	insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price)values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price )
end
go

ALTER VIEW [dbo].[v_opr_sales_device]
AS
SELECT        dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, 
                         dbo.tec_device.device, dbo.opr_sales_device.qty, ISNULL(dbo.opr_sales_device.description, '') AS description, 
                         CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, 
                         dbo.opr_sales_device.principal_price,
						 dbo.opr_sales_device.price * ((opr_sales.ppn/100)+1)  as price_customer
FROM            dbo.opr_sales_device INNER JOIN
                         dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
                         dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
                         dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id

GO

ALTER proc [dbo].[rpt_opr_sales_rekap]
@sales_id bigint
as begin
select sales_id,1 id,'Discount' keterangan, ket_discount,total_discount from v_opr_sales where total_discount>0 and sales_id=@sales_id
--union
--select sales_id,2,'PPH 23' keterangan, cast(pph21 as varchar(10))+'%',total_pph21 from v_opr_sales where total_pph21>0 and sales_id=@sales_id
--union select sales_id,3,'PPN',cast(ppn as varchar(10))+'%',total_ppn from v_opr_sales where total_ppn>0 and sales_id=@sales_id
union
select sales_id,4,'Total','', grand_price from v_opr_sales where grand_price>0 and sales_id=@sales_id
end
GO


ALTER VIEW [dbo].[v_opr_service_device]
AS
SELECT        dbo.opr_service_device.service_id, dbo.opr_service_device.service_device_id, dbo.opr_service_device.service_cost, dbo.v_tec_service_device.sn, 
                         dbo.v_tec_service_device.device, dbo.v_tec_service_device.customer_name, ISNULL(dtl.total_price, 0) + dbo.opr_service_device.service_cost AS total_price, 
                         ISNULL(dtl.total_cost, 0) AS total_cost, ISNULL(dtl.total_price_pph21, 0) AS total_price_pph21, dbo.opr_service_device.service_cancel, 
                         dbo.v_tec_service_device.user_name, 
                         dbo.v_tec_service_device.device + ' sn.' + dbo.v_tec_service_device.sn + CASE WHEN isnull(dbo.v_tec_service_device.user_name, '') 
                         = '' THEN '' ELSE ' user.' + dbo.v_tec_service_device.user_name END + CASE WHEN opr_service.service_status_id IN ('4', '5') 
                         THEN ' (' + appCommonParameter.keterangan + ')' WHEN dbo.opr_service.service_status_id = '3' THEN '(Service)' ELSE '' END AS print_description, 
                         dbo.v_tec_service_device.service_device_sts, dbo.v_tec_service_device.service_device_sts_id, dbo.v_tec_service_device.guarantee_sts, 
                         dbo.opr_service.offer_date, dbo.opr_service.service_status_id, dbo.v_tec_service_device.customer_id, 
						 dtl.total_price_customer + (dbo.opr_service_device.service_cost * ((ppn/100)+1)) as total_price_customer,
						 dbo.opr_service_device.service_cost * ((ppn/100)+1) as service_cost_customer
FROM            dbo.opr_service INNER JOIN
                         dbo.opr_service_device ON dbo.opr_service.service_id = dbo.opr_service_device.service_id INNER JOIN
                         dbo.v_tec_service_device ON dbo.opr_service_device.service_device_id = dbo.v_tec_service_device.service_device_id LEFT OUTER JOIN
                             (SELECT        a.service_id, a.service_device_id, SUM(a.price * a.total) AS total_price, SUM(b.cost * b.total) AS total_cost, 
                                                         SUM(CASE WHEN pph21 = 1 THEN price ELSE 0 END) AS total_price_pph21,
														 sum(a.price_customer * a.total) total_price_customer 
                               FROM            dbo.v_opr_service_device_component AS a LEFT OUTER JOIN
                                                         dbo.tec_service_device_component AS b ON a.service_device_id = b.service_device_id AND a.device_id = b.device_id
                               GROUP BY a.service_id, a.service_device_id) AS dtl ON dtl.service_id = dbo.opr_service_device.service_id AND 
                         dtl.service_device_id = dbo.opr_service_device.service_device_id INNER JOIN
                         dbo.appCommonParameter ON dbo.appCommonParameter.Code = dbo.opr_service.service_status_id AND dbo.appCommonParameter.Type = 'oprservicests'
GO


ALTER VIEW [dbo].[v_opr_service_device_component]
AS
SELECT        dbo.opr_service_device_component.service_id, dbo.opr_service_device_component.service_device_id, dbo.opr_service_device_component.device_id, 
                         dbo.opr_service_device_component.price, dbo.opr_service_device_component.total, dbo.tec_device.device, dbo.opr_service_device_component.PPH21,
						 dbo.opr_service_device_component.price * ((dbo.opr_service.ppn/100)+1) price_customer
FROM            dbo.opr_service_device_component 
	INNER JOIN  dbo.tec_device ON dbo.opr_service_device_component.device_id = dbo.tec_device.device_id
	inner join dbo.opr_service_device on dbo.opr_service_device.service_device_id=dbo.opr_service_device_component.service_device_id
	inner join dbo.opr_service on dbo.opr_service.service_id=dbo.opr_service_device.service_id
GO

ALTER proc [dbo].[rpt_fin_service_device_detail]
@service_id bigint,
@service_device_id bigint
as begin

select 1 urut, '(user: ' +user_name+')' keterangan, 0 qty,0 nilai from v_opr_service_device where service_id=@service_id and service_device_id=@service_device_id and isnull(user_name,'')<>''
union
--select 2,'Service Fee',1,service_cost from v_opr_service_device where service_id=@service_id and service_device_id=@service_device_id and service_cost>0
select 2,'Service Fee',1,service_cost_customer from v_opr_service_device where service_id=@service_id and service_device_id=@service_device_id and service_cost>0
union
select 3,'Cancel Fee',1,service_cancel from v_opr_service_device where service_id=@service_id and service_device_id=@service_device_id and service_cancel>0
union
--select 4,device,total,price from v_opr_service_device_component where service_id=@service_id and service_device_id=@service_device_id
select 4,device,total,price_customer from v_opr_service_device_component where service_id=@service_id and service_device_id=@service_device_id



end
go

ALTER proc [dbo].[rpt_opr_service_rekap]
@service_id bigint
as begin
select service_id,1 id,'Discount' keterangan, ket_discount,total_discount from v_opr_service where total_discount>0 and service_id=@service_id
--union
--select service_id,2,'PPH 23' keterangan, cast(pph21 as varchar(10))+'%',total_pph21 from v_opr_service where total_pph21>0 and service_id=@service_id
--union select service_id,3,'PPN',cast(ppn as varchar(10))+'%',total_ppn from v_opr_service where total_ppn>0 and service_id=@service_id
union
select service_id,4,'Total','', grand_price from v_opr_service where grand_price>0 and service_id=@service_id
end
go

ALTER proc [dbo].[xml_opr_service_device_component_list]
@service_id bigint,
@service_device_id bigint

as begin
set nocount on

select device_id,device,
sum(case when tipe=1 then nilai else 0 end)cost,
sum(case when tipe=1 then ttl else 0 end)tec_total,
sum(case when tipe=2 then nilai else 0 end)price,
sum(case when tipe=2 then price_cust else 0 end)price_customer,
sum(case when tipe=2 then ttl else 0 end)total,
max(pph21)pph21,
cast(case when sum(case when tipe=1 then 1 else 0 end)>0 then 1 else 0 end as bit) real_data_sts
from(
select 1 tipe,device_id,device,cost nilai ,total ttl,0 pph21, 0 price_cust from v_tec_service_device_component where service_device_id=@service_device_id 
union all
select 2 tipe,device_id,device,price,total,PPH21,price_customer from v_opr_service_device_component where service_id=@service_id and service_device_id=@service_device_id 
)a group by device_id,device for xml auto,xmldata
end