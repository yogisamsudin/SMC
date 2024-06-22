CREATE TABLE [dbo].[opr_service_document](
	[service_id] [bigint] NOT NULL,
	[typefileservice_id] [varchar](2) NOT NULL,
	[file_name] [varchar](200) NOT NULL,
	[file_image] [image] NOT NULL,
	[update_date] [date] NOT NULL,
	[file_type] [varchar](200) NOT NULL,
 CONSTRAINT [PK_opr_service_document] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--create proc baru
create proc [dbo].[opr_service_document_save]
@service_id bigint,
@file_name varchar(200),
@file_type varchar(200),
@data image
as begin
update opr_service_document set file_image=@data, file_name=@file_name, file_type=@file_type,update_date=GETDATE() where service_id=service_id and typefileservice_id='1'
if @@ROWCOUNT=0
	insert into opr_service_document(service_id, typefileservice_id,file_name,file_image,update_date, file_type)values(@service_id,'1',@file_name,@data,GETDATE(), @file_type)
end
GO

create view [dbo].[v_opr_service_document] as
select service_id, typefileservice_id,file_name,file_image, keterangan typefilesales_name, file_type from opr_service_document
inner join appCommonParameter on appCommonParameter.Code=opr_service_document.typefileservice_id and appCommonParameter.type='filetypesales'
GO

insert into appCommonParameter(code, keterangan, type)values('1','File PO','filetypeservice')
GO

insert into appCommonParameter(code, keterangan, type)values('3','Onsite','ctgsales'),('1','Jual Barang','ctgsales'),('2','Instalasi','ctgsales')
go

insert into appCommonParameter(code, keterangan,type)values('1','Register','onsitests'),('2','Pengajuan','onsitests'),('3','Proses','onsitests'),('4','selesai','onsitests')
go


alter table opr_sales add  ctgsales_id varchar(2)
go

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
							select sales_id, sum(principal_price * qty) total_principal,sum(cost * qty)total_cost, sum(price * qty)total_price,sum(case when pph21_sts=1 then price*qty else 0 end)total_price_pph21 from v_opr_sales_device group by sales_id
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

ALTER proc [dbo].[opr_sales_add]
@sales_id bigint,
@offer_date varchar(10),
@broker_id int,
@discount_type_id char(1),
@discount_value money,
@tax_sts bit,
@fee money,
@opr_note text,
@sales_status_id char(1),
@additional_fee money = 0,
@additional_fee_note text,
@user_id varchar(25) = '-',
@ctgsales_id varchar(2)
as begin
set nocount on
set transaction isolation level read committed
declare @dat_offer_date date,@ctr int, @initial varchar(5),@offer_no varchar(20),@ppn real, @pph21npkp real, @pph21pkp real,@pcg_principal_price float

set @dat_offer_date=dbo.f_ConverToDate103(@offer_date)
select @ctr=isnull(max(ctr),0)+1 from opr_sales where month(offer_date)=month(@dat_offer_date) and year(offer_date)=year(@dat_offer_date)
select @initial=initial from opr_broker where broker_id=@broker_id
set @offer_no=dbo.f_set_receipt_number(@ctr,@dat_offer_date,'salescode',@initial)

set @ppn=cast(dbo.f_getAppParameterValue('ppn') as real)
set @pph21npkp=cast(dbo.f_getAppParameterValue('pph21npkp') as real)
set @pph21pkp=cast(dbo.f_getAppParameterValue('pph21pkp') as real)
set @pcg_principal_price = cast(dbo.f_getAppParameterValue('pcgprice') as float)


insert into opr_sales(sales_id, offer_date, broker_id, discount_type_id, discount_value, tax_sts,fee,opr_note,sales_status_id,offer_no,ppn,pph21,ctr, pcg_principal_price, update_status_date, additional_fee, additional_fee_note, ctgsales_id)
	values(@sales_id,@dat_offer_date,@broker_id,@discount_type_id,@discount_value,@tax_sts,@fee,@opr_note,@sales_status_id,@offer_no,case when @tax_sts=1 then @ppn else 0 end,case when @tax_sts=1 then @pph21pkp else @pph21npkp end,@ctr, @pcg_principal_price, GETDATE(), @additional_fee, @additional_fee_note, @ctgsales_id)

insert into opr_sales_principal_price
select sales_id ,param_pp_id  from opr_sales ,par_principal_price where sales_id=@sales_id and active_sts=1

insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
end
go

ALTER proc [dbo].[opr_sales_edit]
@sales_id bigint,
@offer_date varchar(10),
@broker_id int,
@discount_type_id char(1),
@discount_value money,
@tax_sts bit,
@opr_note text,
@fee money,
@sales_status_id char(1),
@pcg_principal_price float = 0,
@additional_fee money = 0,
@additional_fee_note text,
@user_id varchar(25) = 'sa',
@ctgsales_id varchar(2),
@ret varchar(200) out
as begin
set nocount on
set transaction isolation level read committed

declare @dat_offer_date date,@ctr int, @initial varchar(5),@offer_no varchar(20),@ppn real, @pph21 real,@last_offer_date date, @last_sales_status_id varchar(1)
set @dat_offer_date=dbo.f_ConverToDate103(@offer_date)

select @last_offer_date=offer_date,@ctr=ctr, @last_sales_status_id=sales_status_id from opr_sales where sales_id=@sales_id

if not (month(@last_offer_date)=month(@dat_offer_date) and year(@last_offer_date)=year(@dat_offer_date))
	begin
	select @ctr=isnull(count(*),0)+1 from opr_sales where month(offer_date)=month(@dat_offer_date) and year(offer_date)=year(@dat_offer_date)
	end

select @initial=initial from opr_broker where broker_id=@broker_id
set @offer_no=dbo.f_set_receipt_number(@ctr,@dat_offer_date,'salescode',@initial)
set @ret=''

--@sales_status_id == 3	Pengecekan closecheck pada module opr_sales_checking.aspx di folder teknisi maka dilakukan penghentian proses selesai
--karena limitasi waktu update data
if @sales_status_id = '3' and cast(cast(DATEPART(HOUR, GETDATE()) as varchar(5))+cast(DATEPART(Minute, GETDATE()) as varchar(5)) as int) > cast(dbo.f_getAppParameterValue('closechecking') as int)
	set @ret='Tutup transaksi, perubahan pada data tidak diperkenankan...'
--@sales_status_id == 7	Pengecekan closeproses pada modul opr_sales_proses.aspx status dipindahkan ke pengecekan maka dilakukan penghentian ke proses pengecekan 
--karena limitasi waktu update data
--else if @sales_status_id = '7' and DATEPART(HOUR, GETDATE()) > cast(dbo.f_getAppParameterValue('closeproses') as int)
else if @sales_status_id = '7' and cast(cast(DATEPART(HOUR, GETDATE()) as varchar(5))+cast(DATEPART(Minute, GETDATE()) as varchar(5)) as int) > cast(dbo.f_getAppParameterValue('closeproses') as int)
	set @ret='Tutup transaksi, perubahan pada data tidak diperkenankan...'
else
	begin
	update opr_sales set 
		update_status_date= case when sales_status_id!=@sales_status_id then GETDATE() else update_status_date end,
		offer_no=@offer_no, offer_date=@dat_offer_date,broker_id=@broker_id,discount_type_id=@discount_type_id,
		discount_value=@discount_value,tax_sts=@tax_sts,opr_note=@opr_note,fee=@fee,sales_status_id=@sales_status_id,ctr=@ctr,
		ppn=case when @tax_sts=1 then dbo.f_getAppParameterValue('ppn') else 0 end,
		pph21=case when @tax_sts=1 then dbo.f_getAppParameterValue('pph21pkp') else dbo.f_getAppParameterValue('pph21npkp') end,
		pcg_principal_price=@pcg_principal_price, additional_fee=@additional_fee, additional_fee_note=@additional_fee_note,
	
		--sales_status_marketing_id=case when @sales_status_id in ('1','2') and sales_status_marketing_id!='4' then '1' else sales_status_marketing_id end,

		sales_status_marketing_id=case when @sales_status_id<>sales_status_id or  sales_status_marketing_id is null then '1' else sales_status_marketing_id end,

		reason_marketing_id=case when @sales_status_id in ('1','2') then '1' else null end,
		ctgsales_id=@ctgsales_id
		where sales_id=@sales_id

	--disini data opr_sales_principal_price tidak di update dikarena historical yang dianut berdasarkan parameter pertamakali di add
	if @last_sales_status_id<>@sales_status_id
		insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
		end

end
go

CREATE TABLE [dbo].[opr_service_addicost](
	[addicost_id] [bigint] IDENTITY(1,1) NOT NULL,
	[service_id] [bigint] NOT NULL,
	[addicost_name] [varchar](100) NOT NULL,
	[addicost_value] [money] NOT NULL,
 CONSTRAINT [PK_opr_service_addicost] PRIMARY KEY CLUSTERED 
(
	[addicost_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

create proc [dbo].[opr_service_addicost_add]
@service_id bigint,
@addicost_name varchar(100),
@addicost_value money
as begin
insert into opr_service_addicost(service_id, addicost_name, addicost_value)values
(@service_id, @addicost_name, @addicost_value)
end
GO
create proc [dbo].[opr_service_addicost_edit]
@addicost_id bigint,
@addicost_name varchar(100),
@addicost_value money
as begin
update opr_service_addicost set addicost_name=@addicost_name, addicost_value=@addicost_value
	where addicost_id=@addicost_id
end
GO
create proc [dbo].[opr_service_addicost_delete]
@addicost_id bigint
as begin
delete opr_service_addicost where addicost_id=@addicost_id
end
GO

create VIEW [dbo].[v_opr_service_addicost]
AS
SELECT addicost_id, service_id, addicost_name, addicost_value
FROM   dbo.opr_service_addicost
GO

create TABLE [dbo].[tec_onsite](
	[onsite_id] [bigint] IDENTITY(1,1) NOT NULL,
	[onsite_no] [varchar](20) NULL,
	[sales_id] [bigint] NOT NULL,
	[onsite_date] [date] NULL,
	[request_date] [date] NOT NULL,
	[technician_name] [varchar](25) NULL,
	[done_date] [date] NULL,
	[note] [text] NULL,
	[onsitests_id] [varchar](1) NOT NULL,
	[marketing_id][varchar](25) NOT NULL
 CONSTRAINT [PK_tec_onsite] PRIMARY KEY CLUSTERED 
(
	[onsite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

create VIEW [dbo].[v_tec_onsite]
AS
SELECT dbo.tec_onsite.onsite_id, dbo.tec_onsite.onsite_no, dbo.tec_onsite.sales_id, dbo.tec_onsite.onsite_date, dbo.tec_onsite.request_date, dbo.tec_onsite.technician_name, dbo.tec_onsite.done_date, dbo.tec_onsite.Note, dbo.tec_onsite.onsitests_id,
	dbo.v_opr_sales.offer_date, dbo.v_opr_sales.offer_no, dbo.v_opr_sales.customer_name, dbo.v_opr_sales.customer_id, dbo.v_opr_sales.marketing_id, dbo.v_act_customer.customer_address, dbo.v_act_customer.customer_address_location,
	dbo.appCommonParameter.Keterangan onsitests
FROM   dbo.tec_onsite INNER JOIN
             dbo.v_opr_sales ON dbo.tec_onsite.sales_id = dbo.v_opr_sales.sales_id INNER JOIN
             dbo.v_act_customer ON dbo.v_opr_sales.customer_id = dbo.v_act_customer.customer_id
			 inner join dbo.appCommonParameter on dbo.appCommonParameter.code = dbo.tec_onsite.onsitests_id and dbo.appCommonParameter.type='onsitests'
GO

alter proc tec_onsite_add
@sales_id bigint,
@note text,
@user_id varchar(25),
@ret bigint out
as begin
declare @offer_no varchar(20), @onsite_no varchar(50),@marketing_id varchar(15)

select @marketing_id=marketing_id from act_marketing where [user_id]=@user_id


select @offer_no=offer_no from opr_sales where sales_id=@sales_id
if @@ROWCOUNT>0
	begin
	insert into tec_onsite(sales_id,request_date,note, onsitests_id, marketing_id)
		values(@sales_id,getdate(),@note, '1', @marketing_id)
	set @ret=@@IDENTITY

	update tec_onsite set onsite_no=@offer_no+'/'+cast(@ret as varchar(20)) where onsite_id=@ret
	end
else
	set @ret=0
end
go

create proc tec_onsite_delete
@onsite_id bigint
as begin
delete tec_onsite where onsite_id=@onsite_id
end
go

alter proc tec_onsite_edit1
@onsite_id bigint,
@note text,
@onsitests_id varchar(1)
as begin
update tec_onsite set note=@note, onsitests_id=@onsitests_id where onsite_id=@onsite_id
end
go

alter proc tec_onsite_edit2
@onsite_id bigint,
@note text,
@onsite_date varchar(10),
@technician_name varchar(50),
@done_sts bit
as begin
declare @onsitests_id varchar(2)
set @onsitests_id=case when @done_sts=1 then '4' else '3' end

update tec_onsite set note=@note, onsite_date=dbo.f_ConverToDate103(@onsite_date), technician_name=@technician_name,
	onsitests_id=@onsitests_id, done_date=  case when  @onsitests_id='4' then GETDATE() else null end 
	where onsite_id=@onsite_id
end
go


