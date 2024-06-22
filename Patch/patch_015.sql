/*
patch 15
PROFORMA
finance produce slip serupa invoice sebelum status penawaran 'selesai', 
slip ini berupa template dari invoice jadi kedepan proporma ini bisa dijadikan sebagai invoice
penawaran yang terdapat dalam proporma tidak bisa di add di invoice
*/
USE [TEST4]
GO
--BEGIN TRAN
--if not exists(select 'x' from sys.objects where name='fin_proforma_sales')

CREATE TABLE [dbo].[fin_proforma_sales](
	[proforma_sales_id] [bigint] IDENTITY(1,1) NOT NULL,
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
	[pph_sts] [bit] null
 CONSTRAINT [PK_fin_proforma_sales] PRIMARY KEY CLUSTERED 
(
	[proforma_sales_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--if not exists(select 'x' from sys.objects where name='fin_proforma_sales_opr')
CREATE TABLE [dbo].[fin_proforma_sales_opr](
	[proforma_sales_id] [bigint] NOT NULL,
	[sales_id] [bigint] NOT NULL,
 CONSTRAINT [PK_fin_proforma_sales_opr_1] PRIMARY KEY CLUSTERED 
(
	[sales_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

create  VIEW v_fin_proforma_sales
AS
SELECT        dbo.fin_proforma_sales.proforma_sales_id, dbo.fin_proforma_sales.proforma_date, CAST(dbo.fin_proforma_sales.proforma_no AS varchar(50)) AS proforma_no, dbo.fin_proforma_sales.term_of_payment_id, 
                         CAST(dbo.fin_proforma_sales.po_no AS varchar(50)) AS po_no, dbo.fin_proforma_sales.afpo_no, dbo.appCommonParameter.Keterangan AS term_of_payment_name, dtl.customer_id, dtl.an_id, 
                         dbo.fin_proforma_sales.proforma_sts,dbo.fin_proforma_sales.term_of_payment_value,

						 CASE WHEN pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END AS grand_price, 
						 
						 dtl.fee, dtl.customer_name, dbo.fin_proforma_sales.ctr, dtl.broker_id, 
                         CASE WHEN fin_proforma_sales.term_of_payment_id = '1' THEN dbo.f_convertDateToChar(DATEADD(day, fin_proforma_sales.term_of_payment_value, fin_proforma_sales.proforma_date)) 
                         WHEN fin_proforma_sales.term_of_payment_id = '2' THEN CAST(fin_proforma_sales.term_of_payment_value AS varchar(10)) END AS str_top_value, 
                         CASE WHEN fin_proforma_sales.term_of_payment_id = '1' THEN CAST(DATEADD(day, fin_proforma_sales.term_of_payment_value, fin_proforma_sales.proforma_date) AS varchar(10)) 
                         WHEN fin_proforma_sales.term_of_payment_id = '2' THEN CAST(fin_proforma_sales.term_of_payment_value AS varchar(10)) + ' days' ELSE 'COD' END AS str_top_value_desc, 
                         dbo.fin_proforma_sales.bill_id, dtl.pph21, dtl.ppn, dtl.ket_discount, dtl.total_ppn, dtl.total_pph21, dtl.total_discount, 
                         
						 dbo.f_terbilang(round(CASE WHEN pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END,0)) AS terbilang,
						 
						 DATEADD(day, ISNULL(dbo.fin_proforma_sales.term_of_payment_value, 0), dbo.fin_proforma_sales.proforma_date) AS due_date, 
						 
						 --dbo.fin_proforma_sales.paid_sts, dbo.fin_proforma_sales.paid_date, 
       --                  dbo.fin_proforma_sales.send_sts, dbo.fin_proforma_sales.invoice_sts, 
						 --ISNULL(dbo.exp_schedule_sales_fin.schedule_id, 0) AS surat_jalan_id, 
						 
						 dbo.fin_proforma_sales.proforma_note, 
                         ISNULL(dtl.total_net, 0) AS total_net, dtl.marketing_id, dbo.fin_proforma_sales.pph_sts, dtl.branch_id, dtl.branch_name, 
						 
						 --dbo.fin_proforma_sales.document_return_sts, 
       --                  dbo.fin_proforma_sales.document_return_date, dbo.fin_proforma_sales.claim_debt_id, dbo.fin_proforma_sales.fee_payment, dbo.fin_proforma_sales.fee_date, 
						 --CASE WHEN dbo.exp_schedule.done_sts = 1 THEN dbo.exp_schedule.schedule_date ELSE NULL END AS document_return_date_exp, 
						 --dbo.fin_proforma_sales.amount_cut, 


                         --dbo.fin_receivable_sales.fin_receivable_id, 
						 dbo.fin_bill.bill_name, dbo.fin_bill.bill_no,dbo.fin_bill.bill_bank_name
						 --(select top 1 sales_id from fin_proforma_sales_opr where fin_proforma_sales_opr.proforma_sales_id=fin_proforma_sales.proforma_sales_id) def_sales_id

FROM            dbo.fin_proforma_sales 
						INNER JOIN dbo.appCommonParameter ON dbo.fin_proforma_sales.term_of_payment_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'top' 
						INNER JOIN dbo.fin_bill ON dbo.fin_proforma_sales.bill_id = dbo.fin_bill.bill_id 
						 
						--LEFT OUTER JOIN dbo.fin_receivable_sales ON dbo.fin_proforma_sales.proforma_sales_id = dbo.fin_receivable_sales.proforma_sales_id 
						 
						LEFT OUTER JOIN
                             (SELECT        a.proforma_sales_id, MAX(b.broker_id) AS broker_id, MAX(b.customer_name) AS customer_name, MAX(b.customer_id) AS customer_id, MAX(b.an_id) 
                                                         AS an_id, SUM(b.grand_price) AS grand_price, SUM(b.fee) AS fee, MAX(b.initial) AS initial, MIN(b.pph21) AS pph21, MIN(b.ppn) AS ppn, 
                                                         MIN(b.ket_discount) AS ket_discount, SUM(b.total_ppn) AS total_ppn, SUM(b.total_pph21) AS total_pph21, SUM(b.total_discount) AS total_discount, 
                                                         SUM(b.net) AS total_net, MAX(b.marketing_id) AS marketing_id, b.branch_id, b.branch_name
                               FROM            dbo.fin_proforma_sales_opr AS a INNER JOIN
                                                         dbo.v_opr_sales AS b ON b.sales_id = a.sales_id
                               GROUP BY a.proforma_sales_id, b.branch_id, b.branch_name) AS dtl ON dtl.proforma_sales_id = dbo.fin_proforma_sales.proforma_sales_id 
							   
						--LEFT OUTER JOIN dbo.exp_schedule_sales_fin ON dbo.fin_proforma_sales.proforma_sales_id = dbo.exp_schedule_sales_fin.proforma_sales_id 
						--LEFT OUTER JOIN dbo.exp_schedule ON dbo.exp_schedule.schedule_id = dbo.exp_schedule_sales_fin.schedule_id
GO


create proc [dbo].[aspx_fin_proforma_sales_list]
@proforma_no varchar(35) = '%',
@customer_name varchar(100) = '%',
@offer_no varchar(35) = '%'
as begin
SELECT dbo.fin_proforma_sales.proforma_sales_id, proforma_date, dbo.f_convertDateToChar(proforma_date)str_proforma_date,proforma_no, term_of_payment_id, po_no, afpo_no, ctr, term_of_payment_value, bill_id, proforma_sts, proforma_note, 
	dtl.customer_name, dtl.marketing_name
FROM   dbo.fin_proforma_sales
inner join (
	select fin_proforma_sales_opr.proforma_sales_id,act_customer.customer_name, act_sales.marketing_id,act_marketing.marketing_name from fin_proforma_sales_opr
	inner join opr_sales on fin_proforma_sales_opr.sales_id=opr_sales.sales_id
	inner join act_sales on opr_sales.sales_id=act_sales.sales_id
	inner join act_customer on act_sales.customer_id=act_customer.customer_id
	inner join act_marketing on act_marketing.marketing_id=act_sales.marketing_id
	group by fin_proforma_sales_opr.proforma_sales_id,act_customer.customer_name,act_sales.marketing_id, act_marketing.marketing_name
)dtl on dtl.proforma_sales_id=dbo.fin_proforma_sales.proforma_sales_id
where proforma_no like @proforma_no

end
go
--add
create proc fin_proforma_sales_add
@proforma_sales_id bigint,
@proforma_date varchar(10),
@term_of_payment_id char(1),
@po_no varchar(50),
@afpo_no varchar(50),
@term_of_payment_value varchar(10),
@bill_id int,
@sales_id bigint,
@ret_id bigint out
as begin
declare @dt_proforma_date date,@ctr int, @initial varchar(5),@proforma_no varchar(20),@top_value int

if @proforma_sales_id=0
	begin
	set @dt_proforma_date=dbo.f_ConverToDate103(@proforma_date)
	select @initial=initial from v_opr_sales where sales_id=@sales_id
	set @top_value=case 
		when @term_of_payment_id='1' then datediff(day,@dt_proforma_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else 0
	end
	select @ctr=isnull(max(ctr),0)+1 from fin_proforma_sales where month(proforma_date)=month(@dt_proforma_date) and year(proforma_date)=year(@dt_proforma_date)
	set @proforma_no='PR'+dbo.f_set_receipt_number(@ctr,@dt_proforma_date,'invsalescode',@initial)

	insert into fin_proforma_sales(proforma_no,proforma_date,term_of_payment_id,po_no,afpo_no,create_date,ctr,term_of_payment_value,bill_id,proforma_sts, pph_sts)
		values(@proforma_no,@dt_proforma_date,@term_of_payment_id,@po_no,@afpo_no,getdate(),@ctr,@top_value,@bill_id,1, 0)

	set @proforma_sales_id=@@identity
	
	end

insert into fin_proforma_sales_opr(proforma_sales_id,sales_id)values(@proforma_sales_id,@sales_id)
set @ret_id = @proforma_sales_id
end
go

create VIEW v_fin_proforma_sales_opr AS
SELECT        dbo.fin_proforma_sales_opr.proforma_sales_id, dbo.fin_proforma_sales_opr.sales_id, dbo.v_act_sales.customer_id, dbo.v_act_sales.an_id, dbo.v_opr_sales.grand_price, 
                         dbo.v_opr_sales.offer_date, dbo.v_opr_sales.offer_no, dbo.v_opr_sales.fee, dbo.v_opr_sales.customer_name, dbo.v_opr_sales.initial, 
                         dbo.v_opr_sales.broker_id
FROM            dbo.fin_proforma_sales_opr INNER JOIN
                         dbo.v_act_sales ON dbo.fin_proforma_sales_opr.sales_id = dbo.v_act_sales.sales_id INNER JOIN
                         dbo.v_opr_sales ON dbo.fin_proforma_sales_opr.sales_id = dbo.v_opr_sales.sales_id

GO

create proc fin_proforma_sales_opr_delete
@proforma_sales_id bigint,
@sales_id bigint
as begin
set nocount on
set transaction isolation level read committed
select 'x' from fin_proforma_sales_opr where proforma_sales_id=@proforma_sales_id
if @@ROWCOUNT>1
	delete fin_proforma_sales_opr where proforma_sales_id=@proforma_sales_id and sales_id=@sales_id
end
go

create proc fin_proforma_sales_edit
@proforma_sales_id bigint,
@proforma_date varchar(10),
@term_of_payment_id char(1),
@po_no varchar(50),
@afpo_no varchar(50),
@term_of_payment_value varchar(10),
@bill_id int,
@pph_sts bit
as begin
declare @dt_proforma_date date,@ctr int, @initial varchar(5),@proforma_no varchar(20),@top_value int,@last_proforma_date date, @sales_id bigint

	
select @last_proforma_date=proforma_date,@proforma_no=proforma_no from fin_proforma_sales where proforma_sales_id=@proforma_sales_id
select @sales_id=sales_id from fin_proforma_sales_opr where proforma_sales_id=@proforma_sales_id
set @dt_proforma_date=dbo.f_ConverToDate103(@proforma_date)
if not (year(@dt_proforma_date)=year(@last_proforma_date) and month(@dt_proforma_date)=month(@last_proforma_date))
	begin
	select @initial=initial from v_opr_sales where sales_id=@sales_id
	set @top_value=case 
		when @term_of_payment_id='1' then datediff(day,@dt_proforma_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else 0
	end
	select @ctr=isnull(max(ctr),0)+1 from fin_proforma_sales where month(proforma_date)=month(@dt_proforma_date) and year(proforma_date)=year(@dt_proforma_date)
	set @proforma_no='PR'+dbo.f_set_receipt_number(@ctr,@dt_proforma_date,'invsalescode',@initial)
	
	end

update fin_proforma_sales set proforma_date=@dt_proforma_date,term_of_payment_id=@term_of_payment_id,po_no=@po_no,afpo_no=@afpo_no,
	term_of_payment_value=case 
		when @term_of_payment_id='1' then datediff(day,@dt_proforma_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else 0
	end,bill_id=@bill_id,pph_sts=@pph_sts
	where proforma_sales_id=@proforma_sales_id

end
go

create proc rpt_fin_proforma_sales
@proforma_sales_id bigint
as begin
select proforma_sales_id,1 id,'Discount' keterangan, ket_discount,total_discount from v_fin_proforma_sales where total_discount>0 and proforma_sales_id=@proforma_sales_id
union
select proforma_sales_id,2,'PPH 23' keterangan, cast(pph21 as varchar(10))+'%',total_pph21 from v_fin_proforma_sales where total_pph21>0 and pph_sts=1 and proforma_sales_id=@proforma_sales_id
union
select proforma_sales_id,3,'PPN',cast(ppn as varchar(10))+'%',total_ppn from v_fin_proforma_sales where total_ppn>0 and proforma_sales_id=@proforma_sales_id
union
select proforma_sales_id,4,'Total','', grand_price from v_fin_proforma_sales where grand_price>0 and proforma_sales_id=@proforma_sales_id
end
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
						 isnull(adcost.additional_cost,0)additional_cost, fin.po_no
						 
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
--tambahan field po no di opr sales lists
ALTER proc [dbo].[aspx_opr_sales_list]
@cust varchar(50),
@no varchar(20),
@status char(1),
@fs char(1) = '%',
@branch_id varchar(10) = '%',
@ssm varchar(2) = '%',
@marketing_id varchar(15)='%',
@nopo varchar(20) = '%'
as begin
select * from(
	select offer_no,sales_id,offer_date, dbo.f_convertDateToChar(offer_date)str_offer_date,customer_name,sales_status,sales_status_marketing,
	isnull((select top 1 '1' from fin_sales_opr where fin_sales_opr.sales_id=v_opr_sales.sales_id),'0')fs,sales_status_id,
	branch_id, branch_name, reason_marketing, sales_status_marketing_id, marketing_id_real, po_no
	from v_opr_sales
)a
where customer_name like @cust and offer_no like @no and sales_status_id like @status
and fs like @fs and branch_id like @branch_id and sales_status_marketing_id like @ssm
and marketing_id_real like @marketing_id and po_no like @nopo
order by offer_date desc
end
go

--ROLLBACK