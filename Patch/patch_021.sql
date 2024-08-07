
select * from appCommonParameter where type='timetype'
go
if @@ROWCOUNT=0
	insert into appCommonParameter(code,Keterangan,type)values('1','days','timetype'),('2','weeks','timetype'),('3','months','timetype'),('4','years','timetype')
go

alter table opr_sales_device add guarantee_timetype_id varchar(1)
alter table opr_sales_device add availability_timetype_id varchar(1)
go
update opr_sales_device set guarantee_timetype_id='1', availability_timetype_id='1'
go

ALTER VIEW [dbo].[v_opr_sales_device] AS
SELECT dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, dbo.tec_device.device, dbo.opr_sales_device.qty, ISNULL(dbo.opr_sales_device.description, '') AS description, 
             CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, dbo.opr_sales_device.principal_price, dbo.opr_sales_device.price AS price_customer, 
             isnull(dbo.opr_sales_device.marketing_note,'')marketing_note, dbo.opr_sales_device.creator_id, dbo.opr_sales_device.create_date, dbo.opr_sales_device.update_id, dbo.opr_sales_device.update_date, dbo.opr_sales_device.draft_sts, 
			 dbo.opr_sales_device.guarantee_id, dbo.opr_sales_device.availability_id, dbo.opr_sales_device.inden,
			 guaranteedevsts.Keterangan guarantee_name, availabile.Keterangan availability_name,
			 dbo.opr_sales_device.guarantee_period, dbo.opr_sales_device.guarantee_timetype_id,dbo.opr_sales_device.availability_timetype_id,
			 timetype.Keterangan guarantee_timetype_name, availability_timetype.keterangan availability_timetype_name,
			 case when dbo.opr_sales_device.guarantee_id!='1' then guaranteedevsts.Keterangan + ' ' + cast(dbo.opr_sales_device.guarantee_period as varchar(10))+ ' ' +timetype.Keterangan else ' ' end
			 + case when dbo.opr_sales_device.guarantee_id!='1' then ', ' else '' end + 'Stock: ' + availabile.Keterangan
			 +case when dbo.opr_sales_device.availability_id!='1' then ' ' +cast(dbo.opr_sales_device.inden as varchar(10)) + ' ' + availability_timetype.Keterangan else ' ' end 
			 rpt_desct_guav
FROM   dbo.opr_sales_device INNER JOIN
             dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
             dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
             dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id
			 left join appCommonParameter guaranteedevsts on guaranteedevsts.Code=dbo.opr_sales_device.guarantee_id and guaranteedevsts.Type='guaranteedevsts'
			 left join appCommonParameter availabile on availabile.Code=dbo.opr_sales_device.availability_id and availabile.Type='availability' 
			 left join appCommonParameter timetype on timetype.Code=dbo.opr_sales_device.guarantee_timetype_id and timetype.Type='timetype' 
			 left join appCommonParameter availability_timetype on availability_timetype.Code=dbo.opr_sales_device.availability_timetype_id and availability_timetype.Type='timetype' 

go

ALTER view [dbo].[v_opr_sales_device_all] as
select 
sales_id, device_id, cost, price, device, pph21_sts,qty, description, draft_sts, guarantee_id, availability_id, inden, guarantee_period,
principal_price, price_customer, 
creator_id, cast(create_date as varchar(25))create_date, update_id, cast(update_date as varchar(25))update_date,
isnull(vendor_id,0) vendor_id, vendor_name, marketing_note, guarantee_timetype_id,guarantee_timetype_name, 
availability_timetype_id, availability_timetype_name

from v_opr_sales_device
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
@guarantee_period int = 0,
@availability_id varchar(1) = null,
@guarantee_timetype_id varchar(1) = '1',
@availability_timetype_id varchar(1) = '1',
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
		guarantee_id=@guarantee_id, availability_id=@availability_id, inden=@inden, guarantee_period = @guarantee_period,
		guarantee_timetype_id=@guarantee_timetype_id, availability_timetype_id=@availability_timetype_id
		where sales_id=@sales_id and device_id=@device_id
	if @@ROWCOUNT=0
		insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price, creator_id, create_date, draft_sts,
			guarantee_id,availability_id,inden, guarantee_period, guarantee_timetype_id, availability_timetype_id)
			values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price,@user_id, getdate(),@draft_sts ,
			@guarantee_id,@availability_id,@inden,@guarantee_period, @guarantee_timetype_id, @availability_timetype_id)
	end
end
go

--THE END
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

if not exists(select 'x' from appParameter where kode='pendingajusales')
	insert into appParameter (kode, nilai, Keterangan,field_type_id)values('pendingajusales', 3, 'Total hari dianggap terpending', 'N')
go

alter table opr_sales_device add guarantee_id varchar(1)
alter table opr_sales_device add guarantee_period int
alter table opr_sales_device add availability_id varchar(1)
alter table opr_sales_device add inden int
update opr_sales_device set inden=0, guarantee_id='1', availability_id='1', guarantee_period=0
go

alter function opr_vendor_validatorcheck(@vendor_id int) returns varchar(200)
as begin
declare @pesan varchar(200)
set @pesan=', Silahkan update data Vendor'

return ''
/*
isnull((select 
case 
	when vendor_location_id =0 then 'Lokasi vendor tidak diisi' + @pesan
	when contact_name is null or contact_name = '' then 'Nama kontak vendor tidak diisi' + @pesan
	when phone1 is null or phone1 = '' then 'Telepon vendor tidak diisi' + @pesan
	when not exists(select 'x' from opr_vendor_category where vendor_id=@vendor_id)  then 'Ketegori Vendor tidak diketahui' + @pesan
	when not exists(select 'x' from opr_vendor_bill where vendor_id=@vendor_id)  then 'No.Rekening tidak terdaftar' + @pesan
	else ''
end as err_message
from opr_vendor where vendor_id=@vendor_id),'')
*/
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
@guarantee_period int = 0,
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
		guarantee_id=@guarantee_id, availability_id=@availability_id, inden=@inden, guarantee_period = @guarantee_period where sales_id=@sales_id and device_id=@device_id
	if @@ROWCOUNT=0
		insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price, creator_id, create_date, draft_sts,
			guarantee_id,availability_id,inden, guarantee_period)
			values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price,@user_id, getdate(),@draft_sts ,
			@guarantee_id,@availability_id,@inden,@guarantee_period)
	end
end
go

ALTER VIEW [dbo].[v_opr_sales_device]
AS
SELECT dbo.opr_sales_device.sales_id, dbo.opr_sales_device.device_id, dbo.opr_sales_device.cost, dbo.opr_sales_device.price, dbo.opr_sales_device.pph21_sts, dbo.tec_device.device, dbo.opr_sales_device.qty, ISNULL(dbo.opr_sales_device.description, '') AS description, 
             CASE WHEN dbo.opr_sales_device.description IS NULL THEN 0 ELSE 1 END AS description_sts, dbo.opr_sales_device.vendor_id, dbo.opr_vendor.vendor_name, dbo.opr_sales_device.principal_price, dbo.opr_sales_device.price AS price_customer, 
             dbo.opr_sales_device.marketing_note, dbo.opr_sales_device.creator_id, dbo.opr_sales_device.create_date, dbo.opr_sales_device.update_id, dbo.opr_sales_device.update_date, dbo.opr_sales_device.draft_sts, 
			 dbo.opr_sales_device.guarantee_id, dbo.opr_sales_device.availability_id, dbo.opr_sales_device.inden,
			 guaranteedevsts.Keterangan guarantee_name, availabile.Keterangan availability_name,
			 dbo.opr_sales_device.guarantee_period
FROM   dbo.opr_sales_device INNER JOIN
             dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
             dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
             dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id
			 left join appCommonParameter guaranteedevsts on guaranteedevsts.Code=dbo.opr_sales_device.guarantee_id and guaranteedevsts.Type='guaranteedevsts'
			 left join appCommonParameter availabile on availabile.Code=dbo.opr_sales_device.availability_id and availabile.Type='availability' 
GO

ALTER proc [dbo].[aspx_opr_sales_list]
@cust varchar(50),
@no varchar(20),
@status char(1),
@fs char(1) = '%',
@branch_id varchar(10) = '%',
@ssm varchar(2) = '%',
@marketing_id varchar(15)='%',
@nopo varchar(20) = '%',
@followup char(1)
as begin
select top 1000 *,
dbo.f_convertDateToChar(proses_date)str_proses_date,proses_date,
dbo.f_convertDateToChar(cek_date)str_cek_date,cek_date,followupsts
from(
	select offer_no,sales_id,offer_date, dbo.f_convertDateToChar(offer_date)str_offer_date,customer_name,sales_status,sales_status_marketing,
	isnull((select top 1 '1' from fin_sales_opr where fin_sales_opr.sales_id=v_opr_sales.sales_id),'0')fs,sales_status_id,
	branch_id, branch_name, reason_marketing, sales_status_marketing_id, marketing_id_real, po_no,update_status_date,dbo.f_convertDateToChar(update_status_date)str_update_status_date,
	(select MAX(log_date)Proses_date from v_opr_sales_log where sales_status_id='6' and v_opr_sales_log.sales_id =v_opr_sales.sales_id) proses_date,
	(select MAX(log_date)cek_date from v_opr_sales_log where sales_status_id='7' and v_opr_sales_log.sales_id=v_opr_sales.sales_id)cek_date,
	case when v_opr_sales.sales_id not in(select sales_id from opr_sales_device) and datediff(day,offer_date,getdate())>cast(dbo.f_getAppParameterValue('pendingajusales') as int) then '0' else '1' end followupsts
	from v_opr_sales
)a
where customer_name like @cust and offer_no like @no and sales_status_id like @status
and fs like @fs and branch_id like @branch_id and sales_status_marketing_id like @ssm
and marketing_id_real like @marketing_id and po_no like @nopo
and followupsts like @followup
order by offer_date desc
end
go

create proc opr_sales_check_pending
@retval varchar(200) out
as begin
declare @total int 
set  @total= (select count('x') from v_opr_sales where sales_status_id='1' and sales_id not in (select sales_id from opr_sales_device) and datediff(day,offer_date,getdate())>cast(dbo.f_getAppParameterValue('pendingajusales') as int))
set @retval = case when @total>0 then 'Selesaikan dahulu pendingan sebanyak ' + cast(@total as varchar(10)) else '' end
end
go

CREATE TABLE [dbo].[fin_proforma_service](
	[proforma_service_id] [bigint] IDENTITY(1,1) NOT NULL,
	[proforma_date] [date] NOT NULL,
	[proforma_no] [varchar](50) NOT NULL,
	[term_of_payment_id] [char](1) NOT NULL,
	[po_no] [varchar](50) NULL,
	[afpo_no] [varchar](50) NULL,
	[create_date] [date] NOT NULL,
	[ctr] [int] NOT NULL,
	[term_of_payment_value] [int] NULL,
	[bill_id] [int] NOT NULL,
	[proforma_sts] [bit] NOT NULL,
	[proforma_note] [text] NULL,
	[pph_sts] [bit] NULL,
 CONSTRAINT [PK_fin_proforma_service] PRIMARY KEY CLUSTERED 
(
	[proforma_service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[fin_proforma_service_opr](
	[proforma_service_id] [bigint] NOT NULL,
	[service_id] [bigint] NOT NULL,
 CONSTRAINT [PK_fin_proforma_service_opr_1] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

create  VIEW [dbo].[v_fin_proforma_service]
AS
SELECT        dbo.fin_proforma_service.proforma_service_id, dbo.fin_proforma_service.proforma_date, CAST(dbo.fin_proforma_service.proforma_no AS varchar(50)) AS proforma_no, dbo.fin_proforma_service.term_of_payment_id, 
                         CAST(dbo.fin_proforma_service.po_no AS varchar(50)) AS po_no, dbo.fin_proforma_service.afpo_no, dbo.appCommonParameter.Keterangan AS term_of_payment_name, dtl.customer_id, dtl.an_id, 
                         dbo.fin_proforma_service.proforma_sts,dbo.fin_proforma_service.term_of_payment_value,

						 CASE WHEN pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END AS grand_price, 
						 
						 dtl.fee, dtl.customer_name, dbo.fin_proforma_service.ctr, dtl.broker_id, 
                         CASE WHEN fin_proforma_service.term_of_payment_id = '1' THEN dbo.f_convertDateToChar(DATEADD(day, fin_proforma_service.term_of_payment_value, fin_proforma_service.proforma_date)) 
                         WHEN fin_proforma_service.term_of_payment_id = '2' THEN CAST(fin_proforma_service.term_of_payment_value AS varchar(10)) END AS str_top_value, 
                         CASE WHEN fin_proforma_service.term_of_payment_id = '1' THEN CAST(DATEADD(day, fin_proforma_service.term_of_payment_value, fin_proforma_service.proforma_date) AS varchar(10)) 
                         WHEN fin_proforma_service.term_of_payment_id = '2' THEN CAST(fin_proforma_service.term_of_payment_value AS varchar(10)) + ' days' ELSE 'COD' END AS str_top_value_desc, 
                         dbo.fin_proforma_service.bill_id, dtl.pph21, dtl.ppn, dtl.ket_discount, dtl.total_ppn, dtl.total_pph21, dtl.total_discount, 
                         
						 dbo.f_terbilang(round(CASE WHEN pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END,0)) AS terbilang,
						 
						 DATEADD(day, ISNULL(dbo.fin_proforma_service.term_of_payment_value, 0), dbo.fin_proforma_service.proforma_date) AS due_date, 
						 
						 --dbo.fin_proforma_service.paid_sts, dbo.fin_proforma_service.paid_date, 
       --                  dbo.fin_proforma_service.send_sts, dbo.fin_proforma_service.invoice_sts, 
						 --ISNULL(dbo.exp_schedule_service_fin.schedule_id, 0) AS surat_jalan_id, 
						 
						 dbo.fin_proforma_service.proforma_note, 
                         ISNULL(dtl.total_net, 0) AS total_net, dtl.marketing_id, dbo.fin_proforma_service.pph_sts, dtl.branch_id, dtl.branch_name, 
						 
						 --dbo.fin_proforma_service.document_return_sts, 
       --                  dbo.fin_proforma_service.document_return_date, dbo.fin_proforma_service.claim_debt_id, dbo.fin_proforma_service.fee_payment, dbo.fin_proforma_service.fee_date, 
						 --CASE WHEN dbo.exp_schedule.done_sts = 1 THEN dbo.exp_schedule.schedule_date ELSE NULL END AS document_return_date_exp, 
						 --dbo.fin_proforma_service.amount_cut, 


                         --dbo.fin_receivable_service.fin_receivable_id, 
						 dbo.fin_bill.bill_name, dbo.fin_bill.bill_no,dbo.fin_bill.bill_bank_name
						 --(select top 1 service_id from fin_proforma_service_opr where fin_proforma_service_opr.proforma_service_id=fin_proforma_service.proforma_service_id) def_service_id

FROM            dbo.fin_proforma_service 
						INNER JOIN dbo.appCommonParameter ON dbo.fin_proforma_service.term_of_payment_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'top' 
						INNER JOIN dbo.fin_bill ON dbo.fin_proforma_service.bill_id = dbo.fin_bill.bill_id 
						 
						--LEFT OUTER JOIN dbo.fin_receivable_service ON dbo.fin_proforma_service.proforma_service_id = dbo.fin_receivable_service.proforma_service_id 
						 
						LEFT OUTER JOIN
                             (SELECT        a.proforma_service_id, MAX(b.broker_id) AS broker_id, MAX(b.customer_name) AS customer_name, MAX(b.customer_id) AS customer_id, MAX(b.an_id) 
                                                         AS an_id, SUM(b.grand_price) AS grand_price, SUM(b.fee) AS fee, MAX(b.initial) AS initial, MIN(b.pph21) AS pph21, MIN(b.ppn) AS ppn, 
                                                         MIN(b.ket_discount) AS ket_discount, SUM(b.total_ppn) AS total_ppn, SUM(b.total_pph21) AS total_pph21, SUM(b.total_discount) AS total_discount, 
                                                         SUM(b.net) AS total_net, MAX(b.marketing_id) AS marketing_id, b.branch_id, b.branch_name
                               FROM            dbo.fin_proforma_service_opr AS a INNER JOIN
                                                         dbo.v_opr_service AS b ON b.service_id = a.service_id
                               GROUP BY a.proforma_service_id, b.branch_id, b.branch_name) AS dtl ON dtl.proforma_service_id = dbo.fin_proforma_service.proforma_service_id 
							   
						--LEFT OUTER JOIN dbo.exp_schedule_service_fin ON dbo.fin_proforma_service.proforma_service_id = dbo.exp_schedule_service_fin.proforma_service_id 
						--LEFT OUTER JOIN dbo.exp_schedule ON dbo.exp_schedule.schedule_id = dbo.exp_schedule_service_fin.schedule_id
GO

create VIEW [dbo].[v_fin_proforma_service_opr] AS
SELECT        dbo.fin_proforma_service_opr.proforma_service_id, dbo.fin_proforma_service_opr.service_id, dbo.v_act_service.customer_id, dbo.v_act_service.an_id, dbo.v_opr_service.grand_price, 
                         dbo.v_opr_service.offer_date, dbo.v_opr_service.offer_no, dbo.v_opr_service.fee, dbo.v_opr_service.customer_name, dbo.v_opr_service.initial, 
                         dbo.v_opr_service.broker_id
FROM            dbo.fin_proforma_service_opr INNER JOIN
                         dbo.v_act_service ON dbo.fin_proforma_service_opr.service_id = dbo.v_act_service.service_id INNER JOIN
                         dbo.v_opr_service ON dbo.fin_proforma_service_opr.service_id = dbo.v_opr_service.service_id

GO

create proc [dbo].[aspx_fin_proforma_service_list]
@proforma_no varchar(35) = '%',
@customer_name varchar(100) = '%',
@offer_no varchar(35) = '%'
as begin
SELECT dbo.fin_proforma_service.proforma_service_id, proforma_date, dbo.f_convertDateToChar(proforma_date)str_proforma_date,proforma_no, term_of_payment_id, po_no, afpo_no, ctr, term_of_payment_value, bill_id, proforma_sts, proforma_note, 
	dtl.customer_name, dtl.marketing_name
FROM   dbo.fin_proforma_service
inner join (
	select fin_proforma_service_opr.proforma_service_id,act_customer.customer_name, act_service.marketing_id,act_marketing.marketing_name from fin_proforma_service_opr
	inner join opr_service on fin_proforma_service_opr.service_id=opr_service.service_id
	inner join act_service on opr_service.service_id=act_service.service_id
	inner join act_customer on act_service.customer_id=act_customer.customer_id
	inner join act_marketing on act_marketing.marketing_id=act_service.marketing_id
	group by fin_proforma_service_opr.proforma_service_id,act_customer.customer_name,act_service.marketing_id, act_marketing.marketing_name
)dtl on dtl.proforma_service_id=dbo.fin_proforma_service.proforma_service_id
where proforma_no like @proforma_no

end
go

create proc [dbo].[rpt_fin_proforma_service]
@proforma_service_id bigint
as begin
select proforma_service_id,1 id,'Discount' keterangan, ket_discount,total_discount from v_fin_proforma_service where total_discount>0 and proforma_service_id=@proforma_service_id
union
select proforma_service_id,2,'PPH 23' keterangan, cast(pph21 as varchar(10))+'%',total_pph21 from v_fin_proforma_service where total_pph21>0 and pph_sts=1 and proforma_service_id=@proforma_service_id
union
select proforma_service_id,3,'PPN',cast(ppn as varchar(10))+'%',total_ppn from v_fin_proforma_service where total_ppn>0 and proforma_service_id=@proforma_service_id
union
select proforma_service_id,4,'Total','', grand_price from v_fin_proforma_service where grand_price>0 and proforma_service_id=@proforma_service_id
end
go

create proc [dbo].[fin_proforma_service_add]
@proforma_service_id bigint,
@proforma_date varchar(10),
@term_of_payment_id char(1),
@po_no varchar(50),
@afpo_no varchar(50),
@term_of_payment_value varchar(10),
@bill_id int,
@service_id bigint,
@ret_id bigint out
as begin
declare @dt_proforma_date date,@ctr int, @initial varchar(5),@proforma_no varchar(20),@top_value int

if @proforma_service_id=0
	begin
	set @dt_proforma_date=dbo.f_ConverToDate103(@proforma_date)
	select @initial=initial from v_opr_service where service_id=@service_id
	set @top_value=case 
		when @term_of_payment_id='1' then datediff(day,@dt_proforma_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else 0
	end
	select @ctr=isnull(max(ctr),0)+1 from fin_proforma_service where month(proforma_date)=month(@dt_proforma_date) and year(proforma_date)=year(@dt_proforma_date)
	set @proforma_no='PR'+dbo.f_set_receipt_number(@ctr,@dt_proforma_date,'invservicecode',@initial)

	insert into fin_proforma_service(proforma_no,proforma_date,term_of_payment_id,po_no,afpo_no,create_date,ctr,term_of_payment_value,bill_id,proforma_sts, pph_sts)
		values(@proforma_no,@dt_proforma_date,@term_of_payment_id,@po_no,@afpo_no,getdate(),@ctr,@top_value,@bill_id,1, 0)

	set @proforma_service_id=@@identity
	
	end

insert into fin_proforma_service_opr(proforma_service_id,service_id)values(@proforma_service_id,@service_id)
set @ret_id = @proforma_service_id
end
GO

create proc [dbo].[fin_proforma_service_edit]
@proforma_service_id bigint,
@proforma_date varchar(10),
@term_of_payment_id char(1),
@po_no varchar(50),
@afpo_no varchar(50),
@term_of_payment_value varchar(10),
@bill_id int,
@pph_sts bit
as begin
declare @dt_proforma_date date,@ctr int, @initial varchar(5),@proforma_no varchar(20),@top_value int,@last_proforma_date date, @service_id bigint

	
select @last_proforma_date=proforma_date,@proforma_no=proforma_no from fin_proforma_service where proforma_service_id=@proforma_service_id
select @service_id=service_id from fin_proforma_service_opr where proforma_service_id=@proforma_service_id
set @dt_proforma_date=dbo.f_ConverToDate103(@proforma_date)
if not (year(@dt_proforma_date)=year(@last_proforma_date) and month(@dt_proforma_date)=month(@last_proforma_date))
	begin
	select @initial=initial from v_opr_service where service_id=@service_id
	set @top_value=case 
		when @term_of_payment_id='1' then datediff(day,@dt_proforma_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else 0
	end
	select @ctr=isnull(max(ctr),0)+1 from fin_proforma_service where month(proforma_date)=month(@dt_proforma_date) and year(proforma_date)=year(@dt_proforma_date)
	set @proforma_no='PR'+dbo.f_set_receipt_number(@ctr,@dt_proforma_date,'invservicecode',@initial)
	
	end

update fin_proforma_service set proforma_date=@dt_proforma_date,term_of_payment_id=@term_of_payment_id,po_no=@po_no,afpo_no=@afpo_no,
	term_of_payment_value=case 
		when @term_of_payment_id='1' then datediff(day,@dt_proforma_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else 0
	end,bill_id=@bill_id,pph_sts=@pph_sts
	where proforma_service_id=@proforma_service_id

end
GO

create proc [dbo].[fin_proforma_service_opr_delete]
@proforma_service_id bigint,
@service_id bigint
as begin
set nocount on
set transaction isolation level read committed
select 'x' from fin_proforma_service_opr where proforma_service_id=@proforma_service_id
if @@ROWCOUNT>1
	delete fin_proforma_service_opr where proforma_service_id=@proforma_service_id and service_id=@service_id
end
GO

