/*
pada menu OPJ proses penjualan item pada device ditambahkan status draft tujuannya adalah memberikan kemudahan
   pada operation/marketing dalam memenej perubahan pada penawaran
*/
use TEST4
alter table opr_sales_device add  draft_sts bit
go

update opr_sales_device set draft_sts=0
go

alter table tec_onsite add guarantee_onsite_id int
go

alter table tec_onsite_workorders add guarantee_date date null
go

update tec_onsite set guarantee_onsite_id=1 
go

if not exists(select 'x' from appCommonParameter where type='onsitests' and code='5')
  insert into appCommonParameter(Code,keterangan,type)values('5','Batal','onsitests')
go


ALTER proc tec_onsite_add
@customer_id int,
@an_id int,
@note text,
@guarantee_onsite_id int,
@user_id varchar(25),
@ret bigint out
as begin
declare @onsite_no varchar(50),@marketing_id varchar(15), @req_date date

set @req_date=GETDATE()

select @marketing_id=marketing_id from act_marketing where [user_id]=@user_id
if @@ROWCOUNT>0
	begin
	insert into tec_onsite(customer_id,request_date,note, onsitests_id, marketing_id, an_id, guarantee_onsite_id)
		values(@customer_id,@req_date,@note, '1', @marketing_id, @an_id, @guarantee_onsite_id)
	set @ret=@@IDENTITY

	update tec_onsite set onsite_no = dbo.f_set_receipt_number(@ret,@req_date,'onsitecode','SMC') where onsite_id=@ret
	end
else
	set @ret=0
end
GO

ALTER proc tec_onsite_edit1
@onsite_id bigint,
@note text,
@onsitests_id varchar(1),
@guarantee_onsite_id int
as begin
update tec_onsite set note=@note, onsitests_id=@onsitests_id, guarantee_onsite_id=@guarantee_onsite_id where onsite_id=@onsite_id
end
GO

ALTER proc tec_onsite_edit2
@onsite_id bigint,
@note text,
@onsite_date varchar(10),
@onsite_date2 varchar(10),
@technician_name varchar(50),
--@done_sts bit,
@onsitests_id varchar(2)
as begin
--declare @onsitests_id varchar(2)
--set @onsitests_id=case when @done_sts=1 then '4' else '3' end

update tec_onsite set note=@note, onsite_date=dbo.f_ConverToDate103(@onsite_date), 
	onsite_date2=dbo.f_ConverToDate103(@onsite_date2), technician_name=@technician_name,
	onsitests_id=@onsitests_id, done_date=  case when  @onsitests_id='4' then GETDATE() else null end 
	where onsite_id=@onsite_id
end
GO





CREATE TABLE [dbo].[tec_onsite_guarantee](
	[guarantee_onsite_id] [int] IDENTITY(1,1) NOT NULL,
	[guarantee_onsite_name] [varchar](50) NOT NULL,
	[guarantee_sts] [bit] NOT NULL,
 CONSTRAINT [PK_tec_guarantee_onsite] PRIMARY KEY CLUSTERED 
(
	[guarantee_onsite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

insert into [tec_onsite_guarantee](guarantee_onsite_name,guarantee_sts) values('Sales',1),('Service',1),('None',0)
go

create view v_tec_onsite_guarantee as
select dbo.[tec_onsite_guarantee].guarantee_onsite_id,dbo.[tec_onsite_guarantee].guarantee_onsite_name, dbo.[tec_onsite_guarantee].guarantee_sts from dbo.[tec_onsite_guarantee]
go

ALTER VIEW [dbo].[v_tec_onsite]
AS
SELECT dbo.tec_onsite.onsite_id, dbo.tec_onsite.onsite_no, dbo.tec_onsite.onsite_date, dbo.tec_onsite.request_date, dbo.tec_onsite.technician_name, dbo.tec_onsite.done_date, dbo.tec_onsite.note, dbo.tec_onsite.onsitests_id, dbo.v_act_customer.customer_name, 
             dbo.tec_onsite.customer_id, dbo.v_act_customer.marketing_id, dbo.v_act_customer.customer_address, dbo.v_act_customer.customer_address_location, dbo.appCommonParameter.Keterangan AS onsitests, dbo.tec_onsite.an_id, dbo.act_customer_contact.contact_name, 
             dbo.tec_onsite.onsite_date2, CASE WHEN EXISTS
                 (SELECT 'x'
                 FROM    tec_onsite_workorders
                 WHERE tec_onsite_workorders.onsite_id = dbo.tec_onsite.onsite_id) THEN 'Ya' ELSE 'None' END AS workorder_sts, 
				 dbo.tec_onsite.guarantee_onsite_id, dbo.tec_onsite_guarantee.guarantee_onsite_name, dbo.tec_onsite_guarantee.guarantee_sts
FROM   dbo.tec_onsite INNER JOIN
             dbo.v_act_customer ON dbo.tec_onsite.customer_id = dbo.v_act_customer.customer_id INNER JOIN
             dbo.appCommonParameter ON dbo.appCommonParameter.Code = dbo.tec_onsite.onsitests_id AND dbo.appCommonParameter.Type = 'onsitests' INNER JOIN
             dbo.act_customer_contact ON dbo.act_customer_contact.contact_id = dbo.tec_onsite.an_id
			 inner join dbo.tec_onsite_guarantee on dbo.tec_onsite_guarantee.guarantee_onsite_id=dbo.tec_onsite.guarantee_onsite_id
GO



--penambahan po no di menu inquery penjualan
ALTER VIEW [dbo].[v_opr_sales] AS
select 
--cast(total_price - total_discount - total_pph21 + total_ppn as money) as grand_price,
--nilai total pph21 atau pph23 tidak dimasukan nilai tsb akan dimasukan di finance
cast(total_price - total_discount + total_ppn as money) as grand_price,
--cast(total_price - total_discount - total_pph21 + total_ppn as money) - total_cost - total_ppn - fee as  net
cast(total_price - total_discount + total_ppn as money) - total_cost - total_ppn - fee - additional_fee - additional_cost  as  net
,cast(total_price - total_discount + total_ppn as money) - total_principal - total_ppn -  fee as principal_net
,*
from(
SELECT        dbo.opr_sales.sales_id, dbo.opr_sales.offer_date, dbo.opr_sales.broker_id, dbo.opr_sales.discount_type_id, 
                         dbo.appCommonParameter.Keterangan AS discount_type, dbo.opr_sales.discount_value, dbo.opr_sales.tax_sts, dbo.opr_sales.opr_note, dbo.opr_sales.offer_no, 
                         dbo.v_act_sales.fee, dbo.opr_sales.sales_status_id, appCommonParameter_1.Keterangan AS sales_status, dbo.opr_sales.sales_status_marketing_id, 
                         appCommonParameter_2.Keterangan AS sales_status_marketing, dbo.opr_sales.ppn, dbo.opr_sales.pph21, dbo.v_act_sales.customer_name, 
                         dbo.opr_broker.broker_name, dbo.v_act_sales.customer_id,
						 isnull(dtl.total_cost,0)total_cost, isnull(dtl.total_price,0) total_price, 
						 --(isnull(dtl.total_price,0)-isnull(dtl.total_cost,0) - v_act_sales.fee - isnull(dtl.total_price,0) * case when opr_sales.tax_sts=1 then (isnull(dbo.opr_sales.ppn,0)/100) else 0 end) net,
						 isnull(total_price_pph21,0)total_price_pph21,
						 isnull(dtl.total_price_pph21,0) * (isnull(dbo.opr_sales.pph21,0)/100) total_pph21,
						 case when opr_sales.discount_type_id='1' then isnull(dtl.total_price,0) * (opr_sales.discount_value/100) else opr_sales.discount_value end total_discount,						 

						 --cast((isnull(dtl.total_price,0)-case when opr_sales.discount_type_id='1' then isnull(dtl.total_price,0) * (opr_sales.discount_value/100) else opr_sales.discount_value end) * case when opr_sales.tax_sts=1 then (isnull(dbo.opr_sales.ppn,0)/100) else 0 end as money)total_ppn,
						 --cast((isnull(dtl.total_price,0)*(1-case when opr_sales.discount_type_id='1' then opr_sales.discount_value/100 else opr_sales.discount_value end)) * case when opr_sales.tax_sts=1 then cast(isnull(dbo.opr_sales.ppn,0) as float)/100 else 0 end as money)total_ppn,
						 (isnull(total_price,0) - case when discount_type_id='1' then isnull(total_price,0)*(cast(discount_value as float)/100) else discount_value end)*case when tax_sts=1 then cast(dbo.opr_sales.ppn as float)/100 else 0 end total_ppn,

						 v_act_sales.marketing_id,opr_broker.initial,CASE WHEN discount_type_id = '1' THEN CAST(CONVERT(int, discount_value) AS varchar(15)) + '%' ELSE '' END AS ket_discount,
						 dbo.v_act_sales.group_customer_id, case when isnull(v_act_sales.npwp,'')<>'' then 1 else 0 end npwp_sts,
						 fin.invoice_no,dbo.v_act_sales.branch_id, dbo.v_act_sales.branch_name, opr_sales.pcg_principal_price,
						 v_act_sales.sales_call_date,dbo.opr_sales.update_status_date,dbo.opr_sales.reason_marketing_id,
						 app_parameter_user.description reason_marketing,
						 isnull(dtl.total_principal,0) total_principal,v_act_sales.an_id, dbo.opr_sales.additional_fee,dbo.opr_sales.additional_fee_note,
						 v_act_sales.marketing_id_real, dbo.opr_sales.sales_status_marketing_updatedate,dbo.opr_sales.limit_approve_sts,
						 isnull(adcost.additional_cost,0)additional_cost, isnull(fin.po_no,'')po_no,
						 dbo.opr_sales.ctgsales_id, appCommonParameter_3.Keterangan ctgsales
						 
FROM            dbo.opr_sales INNER JOIN
                         dbo.opr_broker ON dbo.opr_sales.broker_id = dbo.opr_broker.broker_id INNER JOIN
                         dbo.appCommonParameter ON dbo.opr_sales.discount_type_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'discountype' INNER JOIN
                         dbo.appCommonParameter AS appCommonParameter_1 ON dbo.opr_sales.sales_status_id = appCommonParameter_1.Code AND 
                         appCommonParameter_1.Type = 'oprsalessts' INNER JOIN
                         dbo.appCommonParameter AS appCommonParameter_2 ON dbo.opr_sales.sales_status_marketing_id = appCommonParameter_2.Code AND 
                         appCommonParameter_2.Type = 'mktservicests' INNER JOIN
                         dbo.v_act_sales ON dbo.opr_sales.sales_id = dbo.v_act_sales.sales_id
						 left join dbo.appCommonParameter as appCommonParameter_3 on appCommonParameter_3.Code=dbo.opr_sales.ctgsales_id and appCommonParameter_3.Type='ctgsales'
						 left join(
							select sales_id, sum(principal_price * qty) total_principal,sum(cost * qty)total_cost, sum(price * qty)total_price,sum(case when pph21_sts=1 then price*qty else 0 end)total_price_pph21 
								from v_opr_sales_device where draft_sts=0 group by sales_id
						 )dtl on dtl.sales_id=dbo.opr_sales.sales_id
						 left join(
							select sales_id,min(invoice_no)invoice_no,min(po_no)po_no  from fin_sales_opr
								inner join fin_sales on fin_sales_opr.invoice_sales_id=fin_sales.invoice_sales_id
								group by fin_sales_opr.sales_id
						 )fin on fin.sales_id=opr_sales.sales_id
						 left join app_parameter_user on app_parameter_user.type_id='1' and app_parameter_user.code=opr_sales.reason_marketing_id
						 left join(
							select sales_id,sum(addicost_value)additional_cost from opr_sales_addicost group by sales_id
						 )adcost on adcost.sales_id=dbo.opr_sales.sales_id
)a
GO

ALTER VIEW [dbo].[v_opr_sales_device]
AS
SELECT dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, dbo.tec_device.device, dbo.opr_sales_device.qty, ISNULL(dbo.opr_sales_device.description, '') AS description, 
             CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, dbo.opr_sales_device.principal_price, dbo.opr_sales_device.price AS price_customer, 
             dbo.opr_sales_device.marketing_note, dbo.opr_sales_device.creator_id, dbo.opr_sales_device.create_date, dbo.opr_sales_device.update_id, dbo.opr_sales_device.update_date,
			 dbo.opr_sales_device.draft_sts
FROM   dbo.opr_sales_device INNER JOIN
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
@marketing_note text = null,
@user_id varchar(25) = null,
@draft_sts bit = 0
as begin
set nocount on
set transaction isolation level read committed
declare @keterangan varchar(8000)
set @keterangan=@description
set @description=case when @keterangan='' then null else @description end

update opr_sales_device set draft_sts=@draft_sts,cost=@cost, principal_price=@principal_price,price=@price, qty=@qty,pph21_sts=@pph21_sts, description=@description, vendor_id=case when @vendor_id=0 then null else @vendor_id end, marketing_note=@marketing_note, update_id=@user_id, update_date=getdate()  where sales_id=@sales_id and device_id=@device_id
if @@ROWCOUNT=0
	insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price, creator_id, create_date, draft_sts)values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price,@user_id, getdate(),@draft_sts )
end
GO

ALTER VIEW [dbo].[v_tec_onsite_workorders]
AS
SELECT workorder_id, onsite_id, dbo.tec_onsite_workorders.device_id, sn, note, complient_note, dbo.tec_device.device, dbo.tec_onsite_workorders.segeldate,
dbo.tec_onsite_workorders.onsitedevicests_id, par.Keterangan onsitedevicests,dbo.tec_onsite_workorders.guarantee_date
FROM   dbo.tec_onsite_workorders
inner join dbo.tec_device on dbo.tec_device.device_id=dbo.tec_onsite_workorders.device_id
inner join appCommonParameter par on par.Code = dbo.tec_onsite_workorders.onsitedevicests_id and par.type='onsitedevicests'
GO




ALTER proc [dbo].[tec_onsite_workorders_add]
@onsite_id bigint,
@device_id int,
@sn varchar(50),
@note text,
@complient_note text,
@onsitedevicests_id varchar(1),
@segeldate varchar(10),
@guarantee_date varchar(10),
@ret bigint out
as begin
declare @d_guarantee_date date
set @d_guarantee_date=case when @guarantee_date='' then dbo.f_ConverToDate103(@guarantee_date) else null end
insert into tec_onsite_workorders(onsite_id,device_id, sn, note, complient_note, onsitedevicests_id, segeldate, guarantee_date)values(@onsite_id,@device_id,@sn,@note,@complient_note,@onsitedevicests_id, dbo.f_ConverToDate103( @segeldate), @d_guarantee_date)
set @ret=@@IDENTITY
end
GO

ALTER proc [dbo].[tec_onsite_workorders_edit]
@workorder_id bigint,
@device_id int,
@sn varchar(50),
@note text,
@complient_note text,
@onsitedevicests_id varchar(1),
@guarantee_date varchar(10),
@segeldate varchar(10)
as begin
declare @d_guarantee_date date
set @d_guarantee_date=case when @guarantee_date !='' then dbo.f_ConverToDate103(@guarantee_date) else null end
update tec_onsite_workorders set device_id=@device_id, sn=@sn, note=@note, complient_note=@complient_note, segeldate=dbo.f_ConverToDate103(@segeldate),
	onsitedevicests_id=@onsitedevicests_id, guarantee_date=@d_guarantee_date
	where workorder_id=@workorder_id
end
GO

alter table tmp_dashboard_income_duedate add marketing_id varchar(50)
go

ALTER proc [dbo].[dashboard_income_duedate] as
begin
declare @cur_date date
set @cur_date=dbo.f_getAplDate()

if not exists(select 'x' from tmp_dashboard_income_duedate where [date]=@cur_date) 
begin
truncate table  tmp_dashboard_income_duedate

insert into tmp_dashboard_income_duedate([description],marketing_id,invoice_value,profit_value,quantity,[date])
	select 'Service'Keterangan,marketing_id, sum(grand_price)grand_price,sum(total_net)total_net,count(*)qty,@cur_date tanggal 
		from v_fin_service where paid_sts=0 and due_date<=@cur_date
		group by marketing_id
	union
	select 'Sales' Keterangan,marketing_id,sum(grand_price)grand_price,sum(total_net)total_net,count(*)qty,@cur_date 
		from v_fin_sales where paid_sts=0 and due_date<=@cur_date
		group by marketing_id
/*
	select 'Service'Keterangan,sum(grand_price)grand_price,sum(total_net)total_net,count(*)qty,@cur_date tanggal from v_fin_service where paid_sts=0 and due_date<=@cur_date
	union
	select 'Sales' Keterangan,sum(grand_price)grand_price,sum(total_net)total_net,count(*)qty,@cur_date from v_fin_sales where paid_sts=0 and due_date<=@cur_date
insert into tmp_dashboard_income_duedate
	select 'TOTAL',sum(invoice_value),sum(profit_value),null,@cur_date from tmp_dashboard_income_duedate
*/
end

select * from tmp_dashboard_income_duedate
end



