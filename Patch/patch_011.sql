use test4
go

update appCommonParameter set Keterangan='Proses' where type='oprsalessts' and code='6'
if @@ROWCOUNT=0
	insert into appCommonParameter(code, Keterangan,type)values('6','proses','oprsalessts')

update appCommonParameter set Keterangan='Pengecekan' where type='oprsalessts' and code='7'
if @@ROWCOUNT=0
	insert into appCommonParameter(code, Keterangan,type)values('7','Pengecekan','oprsalessts')

--select * from appCommonParameter where type='oprsalessts'
update appCommonParameter set Keterangan='Balikan Register' where type='mktservicests' and code='4'

if not exists(select 'x' from appCommonParameter where code='1' and type='filetypesales')
	insert into appCommonParameter(code, Keterangan,type)values('1','File PO','filetypesales')
go

CREATE TABLE [dbo].[opr_sales_approver](
	[approver_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](15) NOT NULL,
	[approver_name] [varchar](50) NOT NULL,
	[limit_awal] [money] NOT NULL,
	[limit_akhir] [money] NOT NULL,
	[active_sts] [bit] NOT NULL,
 CONSTRAINT [PK_opr_sales_approver] PRIMARY KEY CLUSTERED 
(
	[approver_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[opr_sales_approver] ADD  CONSTRAINT [DF_opr_sales_approver_active_sts]  DEFAULT ((1)) FOR [active_sts]
GO


CREATE TABLE [dbo].[opr_sales_document](
	[sales_id] [bigint] NOT NULL,
	[typefilesales_id] [varchar](2) NOT NULL,
	[file_name] [varchar](200) NOT NULL,
	[file_image] [image] NOT NULL,
	[update_date] [date] NOT NULL,
	[file_type] [varchar](200) NOT NULL,
 CONSTRAINT [PK_opr_sales_document] PRIMARY KEY CLUSTERED 
(
	[sales_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[act_customer_document](
	[document_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[file_name] [varchar](200) NOT NULL,
	[file_type] [varchar](200) NOT NULL,
	[file_image] [image] NOT NULL,
	[updatedate] [date] NOT NULL,
	[Keterangan] [varchar](100) NULL,
 CONSTRAINT [PK_act_customer_document] PRIMARY KEY CLUSTERED 
(
	[document_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[opr_sales_log](
	[sales_log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[sales_id] [bigint] NOT NULL,
	[log_date] [datetime] NOT NULL,
	[user_id] [varchar](25) NOT NULL,
	[sales_status_id] [varchar](1) NOT NULL,
 CONSTRAINT [PK_opr_sales_log] PRIMARY KEY CLUSTERED 
(
	[sales_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


--create proc baru
create proc opr_sales_document_save
@sales_id bigint,
@file_name varchar(200),
@file_type varchar(200),
@data image
as begin
update opr_sales_document set file_image=@data, file_name=@file_name, file_type=@file_type,update_date=GETDATE() where sales_id=@sales_id and typefilesales_id='1'
if @@ROWCOUNT=0
	insert into opr_sales_document(sales_id, typefilesales_id,file_name,file_image,update_date, file_type)values(@sales_id,'1',@file_name,@data,GETDATE(), @file_type)
end
go

create proc opr_sales_approver_add
@user_id varchar(15),
@approver_name varchar(50),
@limit_awal money,
@limit_akhir money,
@active_sts bit
as begin
insert into opr_sales_approver ( user_id, approver_name, limit_awal,limit_akhir,active_sts)values
	(@user_id,@approver_name,@limit_awal,@limit_akhir,@active_sts)
end
go

create proc opr_sales_approver_edit
@approver_id int,
@user_id varchar(15),
@approver_name varchar(50),
@limit_awal money,
@limit_akhir money,
@active_sts bit
as begin
update opr_sales_approver set approver_name=@approver_name,limit_awal=@limit_awal,limit_akhir=@limit_akhir,active_sts=@active_sts, user_id=@user_id
	where approver_id=@approver_id
end
go

create proc opr_sales_approver_delete
@approver_id int
as begin
delete opr_sales_approver where approver_id=@approver_id
end
go

create VIEW [dbo].[v_opr_sales_approver]
AS
SELECT approver_id, user_id, approver_name, limit_awal, limit_akhir, active_sts
FROM   dbo.opr_sales_approver
GO

create view v_opr_sales_log as
select sales_log_id,sales_id, log_date, user_id, sales_status_id, keterangan sales_status_name from opr_sales_log
	inner join appCommonParameter on type='oprsalessts' and sales_status_id=code
go

create view v_opr_sales_document as
select sales_id, typefilesales_id,file_name,file_image, keterangan typefilesales_name, file_type from opr_sales_document
inner join appCommonParameter on appCommonParameter.Code=opr_sales_document.typefilesales_id and appCommonParameter.type='filetypesales'

go

alter table opr_sales add  limit_approve_sts bit default 0
go


ALTER VIEW [dbo].[v_opr_sales] AS
select 
--cast(total_price - total_discount - total_pph21 + total_ppn as money) as grand_price,
--nilai total pph21 atau pph23 tidak dimasukan nilai tsb akan dimasukan di finance
cast(total_price - total_discount + total_ppn as money) as grand_price,
--cast(total_price - total_discount - total_pph21 + total_ppn as money) - total_cost - total_ppn - fee as  net
cast(total_price - total_discount + total_ppn as money) - total_cost - total_ppn - fee - additional_fee as  net
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
						 v_act_sales.marketing_id_real, dbo.opr_sales.sales_status_marketing_updatedate,dbo.opr_sales.limit_approve_sts
						 
FROM            dbo.opr_sales INNER JOIN
                         dbo.opr_broker ON dbo.opr_sales.broker_id = dbo.opr_broker.broker_id INNER JOIN
                         dbo.appCommonParameter ON dbo.opr_sales.discount_type_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'discountype' INNER JOIN
                         dbo.appCommonParameter AS appCommonParameter_1 ON dbo.opr_sales.sales_status_id = appCommonParameter_1.Code AND 
                         appCommonParameter_1.Type = 'oprsalessts' INNER JOIN
                         dbo.appCommonParameter AS appCommonParameter_2 ON dbo.opr_sales.sales_status_marketing_id = appCommonParameter_2.Code AND 
                         appCommonParameter_2.Type = 'mktservicests' INNER JOIN
                         dbo.v_act_sales ON dbo.opr_sales.sales_id = dbo.v_act_sales.sales_id
						 left join(
							select sales_id, sum(principal_price * qty) total_principal,sum(cost * qty)total_cost, sum(price * qty)total_price,sum(case when pph21_sts=1 then price*qty else 0 end)total_price_pph21 from v_opr_sales_device group by sales_id
						 )dtl on dtl.sales_id=dbo.opr_sales.sales_id
						 left join(
							select sales_id,min(invoice_no)invoice_no  from fin_sales_opr
								inner join fin_sales on fin_sales_opr.invoice_sales_id=fin_sales.invoice_sales_id
								group by fin_sales_opr.sales_id
						 )fin on fin.sales_id=opr_sales.sales_id
						 left join app_parameter_user on app_parameter_user.type_id='1' and app_parameter_user.code=opr_sales.reason_marketing_id
)a
GO


--alter proc lama

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
@user_id varchar(25) = '-'
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


insert into opr_sales(sales_id, offer_date, broker_id, discount_type_id, discount_value, tax_sts,fee,opr_note,sales_status_id,offer_no,ppn,pph21,ctr, pcg_principal_price, update_status_date, additional_fee, additional_fee_note)
	values(@sales_id,@dat_offer_date,@broker_id,@discount_type_id,@discount_value,@tax_sts,@fee,@opr_note,@sales_status_id,@offer_no,case when @tax_sts=1 then @ppn else 0 end,case when @tax_sts=1 then @pph21pkp else @pph21npkp end,@ctr, @pcg_principal_price, GETDATE(), @additional_fee, @additional_fee_note)

insert into opr_sales_principal_price
select sales_id ,param_pp_id  from opr_sales ,par_principal_price where sales_id=@sales_id and active_sts=1

insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
end
go

ALTER proc [dbo].[opr_sales_delete]
@sales_id bigint
as begin
set nocount on
set transaction isolation level read committed
if not exists(select 'x' from fin_sales_opr where sales_id=@sales_id)
	begin
	delete opr_sales_document where sales_id=@sales_id
	delete opr_sales_principal_price where sales_id=@sales_id
	delete opr_sales_device where sales_id=@sales_id
	delete opr_sales where sales_id=@sales_id
	end
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
@user_id varchar(25) = 'sa'
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
	
update opr_sales set 
	update_status_date= case when sales_status_id!=@sales_status_id then GETDATE() else update_status_date end,
	offer_no=@offer_no, offer_date=@dat_offer_date,broker_id=@broker_id,discount_type_id=@discount_type_id,
	discount_value=@discount_value,tax_sts=@tax_sts,opr_note=@opr_note,fee=@fee,sales_status_id=@sales_status_id,ctr=@ctr,
	ppn=case when @tax_sts=1 then dbo.f_getAppParameterValue('ppn') else 0 end,
	pph21=case when @tax_sts=1 then dbo.f_getAppParameterValue('pph21pkp') else dbo.f_getAppParameterValue('pph21npkp') end,
	pcg_principal_price=@pcg_principal_price, additional_fee=@additional_fee, additional_fee_note=@additional_fee_note,
	sales_status_marketing_id=case when @sales_status_id in ('1','2') then '1' else sales_status_marketing_id end,
	reason_marketing_id=case when @sales_status_id in ('1','2') then '1' else null end
	where sales_id=@sales_id

--disini data opr_sales_principal_price tidak di update dikarena historical yang dianut berdasarkan parameter pertamakali di add
if @last_sales_status_id<>@sales_status_id
	insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)

end
go

ALTER proc [dbo].[opr_sales_edit_marketing]
@sales_id bigint,
@sales_status_marketing_id char(1),
@reason_marketing_id varchar(3) = null,
@user_id varchar(25) = 'sa'
as begin
set nocount on
set transaction isolation level read committed

declare @sales_status_id varchar(1), @grand_price money, @limit_approve_sts bit

set @sales_status_id=case 
	when @sales_status_marketing_id='3' then '4' --batal; diopr:4 batal
	when @sales_status_marketing_id='4' then '1' --balikan ke register
	when @sales_status_marketing_id='2' then '5' --otorisasi
	else '2'
end

select @grand_price=grand_price,@limit_approve_sts=limit_approve_sts from v_opr_sales where sales_id=@sales_id

if DATEPART(HOUR, GETDATE()) <= cast(dbo.f_getAppParameterValue('closehour') as int)
	begin
	
	update act_sales set submit_date=case when @sales_status_marketing_id in ('3','4') then getdate() else null end where sales_id=@sales_id

	--set @limit_approve_sts=1
	--if @sales_status_marketing_id='2' and exists (select 'x' from opr_sales_approver where @grand_price between limit_awal and limit_akhir)
	--	set @limit_approve_sts=0


	--otorisasi
	if @sales_status_id='5' and @limit_approve_sts=0 and not exists (select 'x' from opr_sales_approver where @grand_price between limit_awal and limit_akhir)
		begin
		set @limit_approve_sts=1
		set @sales_status_id='6'
		end


	update opr_sales set sales_status_marketing_id=@sales_status_marketing_id,reason_marketing_id=@reason_marketing_id,
		sales_status_marketing_updatedate=case when @sales_status_marketing_id!=sales_status_marketing_id then getdate() else sales_status_marketing_updatedate end ,
		sales_status_id=@sales_status_id, limit_approve_sts=@limit_approve_sts
		where sales_id=@sales_id

	if @sales_status_id in ('1','4','6') 
		insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
	
	end
end
go

create proc opr_sales_edit_approve
@sales_id bigint,
@user_id varchar(25) = 'sa'
as begin
set transaction isolation level read committed

if exists(select 'x' from opr_sales_approver where [user_id]=@user_id)
	begin
	update opr_sales set sales_status_id='6', limit_approve_sts=1
		where sales_id=@sales_id

	insert into opr_sales_log(log_date,sales_id,[user_id],sales_status_id)values(getdate(),@sales_id,@user_Id,'6')
	
	end
end
go

ALTER proc [dbo].[xml_dashboard_init] 
as begin
declare @targettahunan money, @net_total money
set @targettahunan=cast(dbo.f_getAppParameterValue('targettahunan') as money)

select @net_total=isnull(net_total,0) from tmp_dashboard_marketing_result


select * from (
	select 
	@targettahunan targettahunan,
	case when @targettahunan-@net_total<0 then 0 else  @targettahunan-@net_total end  sisapencapaian

)a for xml auto,xmldata
end
go

insert into appMenu(MenuName,MenuURL,SubMenuID,MenuUrut,Initial)values
('Penyetuju Penjualan',	'activities/operation/opr_sales_approver.aspx',	101,	6,	'OPP'),
('Register Penjualan',	'activities/operation/opr_sales_register.aspx',	101,	7,	'ORP'),
('Proses Penjualan',	'activities/operation/opr_sales_proses.aspx',	101,	8,	'OPJ'),
('Aprove Penjualan',	'activities/marketing/sales_approve.aspx',	98,	8,	'MAP'),
('Penjualan - Pengecekan Device',	'activities/technician/opr_sales_checking.aspx',	181,	13,	'TPD'),
('Penjualan - Cek Device',	'activities/technician/opr_sales_checking.aspx',	103,	13,	'TPD')

insert into opr_sales_approver(user_id,approver_name, limit_awal,limit_akhir,active_sts)values
('yosephine',	'yosephine',	20000000.00,	100000000000.00,	1),
('sa',	'sa',	20000000.00,	100000000000.00,	1)
/*
declare @anid int =0,
@no varchar(30)='%', @custid int = 0, @branch int=0

--select @custid,@anid,@no,@branch

select v_opr_sales.sales_id, offer_date,offer_no,broker_name,tax_sts,v_act_sales.customer_name,v_act_sales.an,v_act_sales.customer_id, v_act_sales.an_id,v_opr_sales.branch_name, v_opr_sales.marketing_id from v_opr_sales 
inner join v_act_sales on v_act_sales.sales_id=v_opr_sales.sales_id 
where sales_status_id='3' and offer_no like @no and v_opr_sales.sales_id not in (select sales_id from fin_sales_opr) 
--and v_opr_sales.customer_id like '%'
--and v_opr_sales.an_id like case when @anid=0 then '%' else @anid end --and v_opr_sales.branch_id like @branch
*/