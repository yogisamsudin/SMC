
--create form customer_passive.aspx dan customer_passive_list.aspx
/*
create view v_act_customer_passive as
select sales.last_offer_date, dbo.f_convertDateToChar(sales.last_offer_date)str_last_offer_date,act_customer.customer_id,act_customer.marketing_id, customer_name from act_customer
left join(
	select marketing_id, max(offer_date)last_offer_date from act_sales
	inner join opr_sales on opr_sales.sales_id=act_sales.sales_id
	group by marketing_id
)sales on act_customer.marketing_id=sales.marketing_id
where last_offer_date<DATEADD(month,-6, cast(getdate() as date))
go
*/

alter table fin_sales add pot_admin money, pot_pph23 money, downpayment money
go

alter table fin_service add pot_admin money, pot_pph23 money, downpayment money
go

ALTER VIEW [dbo].[v_fin_sales]
AS
SELECT        dbo.fin_sales.invoice_sales_id, dbo.fin_sales.invoice_date, CAST(dbo.fin_sales.Invoice_no AS varchar(50)) AS Invoice_no, dbo.fin_sales.term_of_payment_id, 
                         CAST(dbo.fin_sales.po_no AS varchar(50)) AS po_no, dbo.fin_sales.afpo_no, dbo.appCommonParameter.Keterangan AS term_of_payment, dtl.customer_id, dtl.an_id, 
                         
						 CASE WHEN pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END AS grand_price, 
						 
						 dtl.fee, dtl.customer_name, dbo.fin_sales.ctr, dtl.broker_id, 
                         CASE WHEN fin_sales.term_of_payment_id = '1' THEN dbo.f_convertDateToChar(DATEADD(day, fin_sales.term_of_payment_value, fin_sales.invoice_date)) 
                         WHEN fin_sales.term_of_payment_id = '2' THEN CAST(fin_sales.term_of_payment_value AS varchar(10)) END AS str_top_value, 
                         CASE WHEN fin_sales.term_of_payment_id = '1' THEN CAST(DATEADD(day, fin_sales.term_of_payment_value, fin_sales.invoice_date) AS varchar(10)) 
                         WHEN fin_sales.term_of_payment_id = '2' THEN CAST(fin_sales.term_of_payment_value AS varchar(10)) + ' days' ELSE 'COD' END AS str_top_value_desc, 
                         dbo.fin_sales.bill_id, dtl.pph21, dtl.ppn, dtl.ket_discount, dtl.total_ppn, dtl.total_pph21, dtl.total_discount, 
                         
						 dbo.f_terbilang(round(CASE WHEN pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END,0)) AS terbilang,
						 
						 DATEADD(day, ISNULL(dbo.fin_sales.term_of_payment_value, 0), dbo.fin_sales.invoice_date) AS due_date, dbo.fin_sales.paid_sts, dbo.fin_sales.paid_date, 
                         dbo.fin_sales.send_sts, dbo.fin_sales.invoice_sts, ISNULL(dbo.exp_schedule_sales_fin.schedule_id, 0) AS surat_jalan_id, dbo.fin_sales.invoice_note, 
                         ISNULL(dtl.total_net, 0) AS total_net, dtl.marketing_id, dbo.fin_sales.pph_sts, dtl.branch_id, dtl.branch_name, dbo.fin_sales.document_return_sts, 
                         dbo.fin_sales.document_return_date, dbo.fin_sales.claim_debt_id, dbo.fin_sales.fee_payment, dbo.fin_sales.fee_date, 
                         CASE WHEN dbo.exp_schedule.done_sts = 1 THEN dbo.exp_schedule.schedule_date ELSE NULL END AS document_return_date_exp, dbo.fin_sales.amount_cut, 
                         dbo.fin_receivable_sales.fin_receivable_id, dbo.fin_bill.bill_name, dbo.fin_bill.bill_no,
						 (select top 1 sales_id from fin_sales_opr where fin_sales_opr.invoice_sales_id=fin_sales.invoice_sales_id) def_sales_id,
						 isnull(dbo.fin_sales.pot_admin,0) pot_admin, isnull(dbo.fin_sales.pot_pph23,0)pot_pph23, isnull(dbo.fin_sales.downpayment,0)downpayment
						 
FROM            dbo.fin_sales INNER JOIN
                         dbo.appCommonParameter ON dbo.fin_sales.term_of_payment_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'top' INNER JOIN
                         dbo.fin_bill ON dbo.fin_sales.bill_id = dbo.fin_bill.bill_id LEFT OUTER JOIN
                         dbo.fin_receivable_sales ON dbo.fin_sales.invoice_sales_id = dbo.fin_receivable_sales.invoice_sales_id LEFT OUTER JOIN
                             (SELECT        a.invoice_sales_id, MAX(b.broker_id) AS broker_id, MAX(b.customer_name) AS customer_name, MAX(b.customer_id) AS customer_id, MAX(b.an_id) 
                                                         AS an_id, SUM(b.grand_price) AS grand_price, SUM(b.fee) AS fee, MAX(b.initial) AS initial, MIN(b.pph21) AS pph21, MIN(b.ppn) AS ppn, 
                                                         MIN(b.ket_discount) AS ket_discount, SUM(b.total_ppn) AS total_ppn, SUM(b.total_pph21) AS total_pph21, SUM(b.total_discount) AS total_discount, 
                                                         SUM(b.net) AS total_net, MAX(b.marketing_id) AS marketing_id, b.branch_id, b.branch_name
                               FROM            dbo.fin_sales_opr AS a INNER JOIN
                                                         dbo.v_opr_sales AS b ON b.sales_id = a.sales_id
                               GROUP BY a.invoice_sales_id, b.branch_id, b.branch_name) AS dtl ON dtl.invoice_sales_id = dbo.fin_sales.invoice_sales_id LEFT OUTER JOIN
                         dbo.exp_schedule_sales_fin ON dbo.fin_sales.invoice_sales_id = dbo.exp_schedule_sales_fin.invoice_sales_id LEFT OUTER JOIN
                         dbo.exp_schedule ON dbo.exp_schedule.schedule_id = dbo.exp_schedule_sales_fin.schedule_id
GO

ALTER proc [dbo].[fin_sales_edit]
@invoice_sales_id bigint,
@invoice_date varchar(10),
@term_of_payment_id char(1),
@po_no varchar(50),
@afpo_no varchar(50),
@term_of_payment_value varchar(10),
@bill_id int,
@paid_sts bit,
@paid_date varchar(10),
@send_sts bit = 0,
@invoice_sts bit = 0,
@invoice_note text = null,
@pph_sts bit = 0,
@document_return_sts bit = 0,
@document_return_date varchar(10) = '',
@fee_payment money = null,
@fee_date	varchar(10) = '',
@amount_cut money = 0,
@pot_admin money = 0,
@pot_pph23 money = 0,
@downpayment money = 0
as begin
set nocount on
set transaction isolation level read committed
declare @dat_invoice_date date,@ctr int, @broker_id int,@initial varchar(5),@invoice_no varchar(20),@old_invoice_date date

select @initial=initial from v_opr_sales where sales_id in (select sales_id from fin_sales_opr where invoice_sales_id=@invoice_sales_id)

select @old_invoice_date=invoice_date,@ctr=ctr from v_fin_sales where invoice_sales_id=@invoice_sales_id
set @dat_invoice_date=dbo.f_ConverToDate103(@invoice_date)

if not (month(@dat_invoice_date)=month(@old_invoice_date) and year(@dat_invoice_date)=year(@old_invoice_date))
	select @ctr=count(*)+1 from fin_sales where month(invoice_date)=month(@dat_invoice_date) and year(invoice_date)=year(@dat_invoice_date)

set @invoice_no=dbo.f_set_receipt_number(@ctr,@dat_invoice_date,'invsalescode',@initial)

update fin_sales set invoice_date=@dat_invoice_date,Invoice_no=@invoice_no,term_of_payment_id=@term_of_payment_id,po_no=@po_no,
	afpo_no=@afpo_no, ctr=@ctr,
	term_of_payment_value=case 
		when @term_of_payment_id='1' then datediff(day,@dat_invoice_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else null
	end,bill_id=@bill_id,paid_sts=@paid_sts, paid_date=case when @paid_sts=1 then dbo.f_ConverToDate103(@paid_date) else null end,
	send_sts=@send_sts, invoice_sts=@invoice_sts,invoice_note=@invoice_note, pph_sts=@pph_sts, document_return_sts=@document_return_sts,
	document_return_date=case when @document_return_date='' then null else dbo.f_ConverToDate103(@document_return_date) end,
	fee_payment=@fee_payment,fee_date=case when @fee_date='' then null else dbo.f_ConverToDate103(@fee_date) end,
	amount_cut= @amount_cut,
	pot_admin = @pot_admin, pot_pph23=@pot_pph23, downpayment=@downpayment
where invoice_sales_id=@invoice_sales_id

end
go



ALTER VIEW [dbo].[v_fin_service]
AS
SELECT        dbo.fin_service.invoice_service_id, dbo.fin_service.invoice_date, CAST(dbo.fin_service.Invoice_no AS varchar(50)) AS Invoice_no, 
                         dbo.fin_service.term_of_payment_id, dbo.fin_service.po_no, dbo.fin_service.afpo_no, dbo.appCommonParameter.Keterangan AS term_of_payment, dtl.customer_id, 
                         dtl.an_id, CASE WHEN dbo.fin_service.pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END AS grand_price, dtl.fee, dtl.customer_name, 
                         dbo.fin_service.ctr, dtl.broker_id, CASE WHEN fin_service.term_of_payment_id = '1' THEN dbo.f_convertDateToChar(DATEADD(day, 
                         fin_service.term_of_payment_value, fin_service.invoice_date)) 
                         WHEN fin_service.term_of_payment_id = '2' THEN CAST(fin_service.term_of_payment_value AS varchar(10)) END AS str_top_value, 
                         CASE WHEN fin_service.term_of_payment_id = '1' THEN CAST(DATEADD(day, fin_service.term_of_payment_value, fin_service.invoice_date) AS varchar(10)) 
                         WHEN fin_service.term_of_payment_id = '2' THEN CAST(fin_service.term_of_payment_value AS varchar(10)) + ' days' ELSE 'COD' END AS str_top_value_desc, 
                         dbo.fin_service.bill_id, dtl.pph21, dtl.ppn, dtl.ket_discount, dtl.total_ppn, dtl.total_pph21, dtl.total_discount, 
                         dbo.f_terbilang(CASE WHEN dbo.fin_service.pph_sts = 1 THEN dtl.grand_price - total_pph21 ELSE dtl.grand_price END) AS terbilang, DATEADD(day, 
                         ISNULL(dbo.fin_service.term_of_payment_value, 0), dbo.fin_service.invoice_date) AS due_date, dbo.fin_service.paid_sts, dbo.fin_service.paid_date, 
                         dbo.fin_service.send_sts, dbo.fin_service.invoice_sts, ISNULL(dbo.exp_schedule_service_fin.schedule_id, 0) AS surat_jalan_id, dbo.fin_service.invoice_note, 
                         ISNULL(dtl.total_net, 0) AS total_net, dtl.marketing_id, dbo.fin_service.pph_sts, dtl.branch_id, dtl.branch_name, dbo.fin_service.document_return_sts, 
                         dbo.fin_service.document_return_date, dbo.fin_service.claim_debt_id, dbo.fin_service.fee_payment, dbo.fin_service.fee_date, 
                         CASE WHEN dbo.exp_schedule.done_sts = 1 THEN dbo.exp_schedule.schedule_date ELSE NULL END AS document_return_date_exp, dbo.fin_service.amount_cut, 
                         dbo.fin_receivable_service.fin_receivable_id, dbo.fin_bill.bill_name, dbo.fin_bill.bill_no, dbo.fin_service.term_of_payment_value,
						 isnull(dbo.fin_service.pot_admin,0)pot_admin, isnull(dbo.fin_service.pot_pph23,0)pot_pph23, isnull(dbo.fin_service.downpayment,0)downpayment
FROM            dbo.fin_service INNER JOIN
                         dbo.appCommonParameter ON dbo.fin_service.term_of_payment_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'top' INNER JOIN
                         dbo.fin_bill ON dbo.fin_service.bill_id = dbo.fin_bill.bill_id LEFT OUTER JOIN
                         dbo.fin_receivable_service ON dbo.fin_service.invoice_service_id = dbo.fin_receivable_service.invoice_service_id LEFT OUTER JOIN
                             (SELECT        a.invoice_service_id, MAX(b.broker_id) AS broker_id, MAX(b.customer_name) AS customer_name, MAX(b.customer_id) AS customer_id, MAX(b.an_id) 
                                                         AS an_id, SUM(b.grand_price) AS grand_price, SUM(b.fee) AS fee, MAX(b.initial) AS initial, MIN(b.pph21) AS pph21, MIN(b.ppn) AS ppn, 
                                                         MIN(b.ket_discount) AS ket_discount, SUM(b.total_ppn) AS total_ppn, SUM(b.total_pph21) AS total_pph21, SUM(b.total_discount) AS total_discount, 
                                                         SUM(b.net) AS total_net, MAX(b.marketing_id) AS marketing_id, b.branch_id, b.branch_name
                               FROM            dbo.fin_service_opr AS a INNER JOIN
                                                         dbo.v_opr_service AS b ON b.service_id = a.service_id
                               GROUP BY a.invoice_service_id, b.branch_id, b.branch_name) AS dtl ON dtl.invoice_service_id = dbo.fin_service.invoice_service_id LEFT OUTER JOIN
                         dbo.exp_schedule_service_fin ON dbo.fin_service.invoice_service_id = dbo.exp_schedule_service_fin.invoice_service_id LEFT OUTER JOIN
                         dbo.exp_schedule ON dbo.exp_schedule.schedule_id = dbo.exp_schedule_service_fin.schedule_id
GO

ALTER proc [dbo].[fin_service_edit]
@invoice_service_id bigint,
@invoice_date varchar(10),
@term_of_payment_id char(1),
@po_no varchar(50),
@afpo_no varchar(50),
@term_of_payment_value varchar(10),
@bill_id int,
@paid_sts bit,
@paid_date varchar(10),
@send_sts bit = 0,
@invoice_sts bit = 0,
@invoice_note text = null,
@pph_sts bit = 0,
@document_return_sts bit = 0,
@document_return_date varchar(10) = '',
@fee_payment money = null,
@fee_date varchar(10) = '',
@amount_cut money = 0,
@pot_admin money = 0,
@pot_pph23 money = 0,
@downpayment money = 0
as begin
set nocount on
set transaction isolation level read committed
declare @dat_invoice_date date,@ctr int, @broker_id int,@initial varchar(5),@invoice_no varchar(20),@old_invoice_date date

select @initial=initial from v_opr_service where service_id in (select service_id from fin_service_opr where invoice_service_id=@invoice_service_id)

select @old_invoice_date=invoice_date,@ctr=ctr from v_fin_service where invoice_service_id=@invoice_service_id
set @dat_invoice_date=dbo.f_ConverToDate103(@invoice_date)

if not (month(@dat_invoice_date)=month(@old_invoice_date) and year(@dat_invoice_date)=year(@old_invoice_date))
	select @ctr=count(*)+1 from fin_service where month(invoice_date)=month(@dat_invoice_date) and year(invoice_date)=year(@dat_invoice_date)

set @invoice_no=dbo.f_set_receipt_number(@ctr,@dat_invoice_date,'invservicecode',@initial)

update fin_service set invoice_date=@dat_invoice_date,Invoice_no=@invoice_no,term_of_payment_id=@term_of_payment_id,po_no=@po_no,
	afpo_no=@afpo_no, ctr=@ctr,
	term_of_payment_value=case 
		when @term_of_payment_id='1' then datediff(day,@dat_invoice_date,dbo.f_ConverToDate103(@term_of_payment_value))
		when @term_of_payment_id='2' then cast(@term_of_payment_value as int)
		else null
	end,bill_id=@bill_id,paid_sts=@paid_sts, paid_date=case when @paid_sts=1 then dbo.f_ConverToDate103(@paid_date) else null end,
	send_sts=@send_sts, invoice_sts=@invoice_sts,invoice_note=@invoice_note, pph_sts=@pph_sts,document_return_sts=@document_return_sts,
	document_return_date=case when @document_return_date='' then null else dbo.f_ConverToDate103(@document_return_date) end,
	fee_payment=@fee_payment,fee_date=case when @fee_date='' then null else dbo.f_ConverToDate103(@fee_date) end,
	amount_cut=@amount_cut,
	pot_admin=@pot_admin, pot_pph23=@pot_pph23, downpayment=@downpayment
where invoice_service_id=@invoice_service_id

end
GO

alter table opr_sales add validate_sts bit default 0
alter table opr_sales add complete_sts bit default 0
alter table opr_service add validate_sts bit default 0
update opr_sales set validate_sts=case when sales_status_id in ('1','2','4') then 0 else 1 end
update opr_service set validate_sts=case when service_status_id in ('1','2') then 0 else 1 end
update opr_sales set complete_sts=case when sales_status_id='1' then 0 else 1 end
go

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
						 dbo.opr_sales.ctgsales_id, appCommonParameter_3.Keterangan ctgsales,
						 dbo.opr_sales.validate_sts, dbo.opr_sales.complete_sts
						 
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

ALTER VIEW [dbo].[v_opr_service] AS
select 
grand_price - total_cost - total_ppn - fee - additional_fee - total_addicost as net,
* from(
SELECT        service_id, offer_date, broker_id, discount_type_id, tax_sts, opr_note, broker_name, discount_type, discount_value, customer_name, offer_no, fee, 
                         service_status_id, service_status_marketing_id, service_status_marketing, service_status, customer_id, ppn, pph21, marketing_id, total_price, total_cost, 
                         total_price_pph21, total_ppn, total_pph21, ket_discount, total_discount,
						 --CASE WHEN discount_type_id = '1' THEN total_price * (discount_value / 100) ELSE discount_value END AS total_discount, 
						 --total_price - total_cost - CASE WHEN discount_type_id = '1' THEN total_price * (discount_value / 100) ELSE discount_value END  - fee - total_ppn AS net, 
						 --case when service_status_id='4' then total_service_cancel else total_price - CASE WHEN discount_type_id = '1' THEN total_price * (discount_value / 100) ELSE discount_value END - total_pph21 + total_ppn end AS grand_price, 
						 --nilai total pph21 atau pph23 tidak dimasukan nilai tsb akan dimasukan di finance
						 --case when service_status_id='4' then total_service_cancel else total_price - CASE WHEN discount_type_id = '1' THEN total_price * (discount_value / 100) ELSE discount_value END + total_ppn end AS grand_price, 
						 case when service_status_id='4' then total_service_cancel else total_price - total_discount + total_ppn end AS grand_price, 
						 initial, ctr,Invoice_no, case when invoice_no is null then '0' else '1' end invoice_create_sts,npwp_sts, branch_id, branch_name,
						 guaranti_term, 
						 case 
							when guaranti_term=1 then 'One' 
							when guaranti_term=2 then 'Two' 
							when guaranti_term=3 then 'Three' 
							when guaranti_term=4 then 'Four' 
							when guaranti_term=5 then 'Five' 
							when guaranti_term=6 then 'Six' 
							when guaranti_term=7 then 'Seven' 
							when guaranti_term=8 then 'Eight' 
							when guaranti_term=9 then 'Nine' 
						 end as guaranti_term_description,
						 service_call_date,update_status_date,reason_marketing_id,reason_marketing,an_id, additional_fee,additional_fee_note, marketing_id_real,
						 service_status_marketing_updatedate, total_addicost,validate_sts
FROM            (SELECT        dbo.opr_service.service_id, dbo.opr_service.offer_date, dbo.opr_service.broker_id, dbo.opr_service.discount_type_id, dbo.opr_service.tax_sts, 
                                                    dbo.opr_service.opr_note, dbo.opr_broker.broker_name, dbo.appCommonParameter.Keterangan AS discount_type, dbo.opr_service.discount_value, 
                                                    dbo.v_act_service.customer_name, dbo.opr_service.offer_no, dbo.v_act_service.fee, dbo.opr_service.service_status_id, 
                                                    dbo.opr_service.service_status_marketing_id, appCommonParameter_1.Keterangan AS service_status_marketing, 
                                                    appCommonParameter_2.Keterangan AS service_status, dbo.v_act_service.customer_id, dbo.opr_service.ppn, dbo.opr_service.pph21, 
                                                    dbo.v_act_service.marketing_id, dtl.total_price, dtl.total_cost, 
													dtl.total_price_pph21 + dtl.total_service_cost AS total_price_pph21, 

													CASE WHEN discount_type_id = '1' THEN total_price * (discount_value / 100) ELSE discount_value END AS total_discount, 
                                                    cast(dbo.opr_service.ppn as float) / 100 * (ISNULL(dtl.total_price, 0)-CASE WHEN discount_type_id = '1' THEN total_price * (cast(discount_value as float)/ 100) ELSE discount_value END )AS total_ppn, 

													cast(dbo.opr_service.pph21 as float) / 100 * ISNULL(dtl.total_price_pph21, 0) AS total_pph21, 
                                                    CASE WHEN discount_type_id = '1' THEN CAST(CONVERT(int, discount_value) AS varchar(15)) + '%' ELSE '' END AS ket_discount, dbo.opr_broker.initial, 
                                                    dbo.opr_service.ctr,total_service_cancel,
													fin_service.Invoice_no,case when isnull(v_act_service.npwp,'')<>'' then 1 else 0 end npwp_sts,
													dbo.v_act_service.branch_id, dbo.v_act_service.branch_name, dbo.opr_broker.guaranti_term,
													v_act_service.service_call_date, dbo.opr_service.update_status_date, dbo.opr_service.reason_marketing_id,
													app_parameter_user.description reason_marketing,dbo.v_act_service.an_id, additional_fee, additional_fee_note, dbo.v_act_service.marketing_id_real,
													opr_service.service_status_marketing_updatedate, isnull(addicost.total_addicost,0)total_addicost,
													dbo.opr_service.validate_sts
                          FROM            dbo.opr_service INNER JOIN
                                                    dbo.opr_broker ON dbo.opr_service.broker_id = dbo.opr_broker.broker_id INNER JOIN
                                                    dbo.appCommonParameter ON dbo.opr_service.discount_type_id = dbo.appCommonParameter.Code AND 
                                                    dbo.appCommonParameter.Type = 'discountype' INNER JOIN
                                                    dbo.v_act_service ON dbo.opr_service.service_id = dbo.v_act_service.service_id INNER JOIN
                                                    dbo.appCommonParameter AS appCommonParameter_1 ON dbo.opr_service.service_status_marketing_id = appCommonParameter_1.Code AND 
                                                    appCommonParameter_1.Type = 'mktservicests' INNER JOIN
                                                    dbo.appCommonParameter AS appCommonParameter_2 ON dbo.opr_service.service_status_id = appCommonParameter_2.Code AND 
                                                    appCommonParameter_2.Type = 'oprservicests' LEFT OUTER JOIN
                                                        (SELECT        
															service_id, SUM(total_price) AS total_price, 
															SUM(total_cost) AS total_cost, SUM(total_price_pph21)+SUM(service_cost) AS total_price_pph21, 
                                                            SUM(service_cost) AS total_service_cost, SUM(service_cancel) AS total_service_cancel
                                                          FROM            dbo.v_opr_service_device
                                                          GROUP BY service_id) AS dtl ON dtl.service_id = dbo.opr_service.service_id
													left join fin_service_opr on fin_service_opr.service_id=opr_service.service_id
													left join fin_service on fin_service.invoice_service_id=fin_service_opr.invoice_service_id
													left join app_parameter_user on app_parameter_user.type_id='1' and app_parameter_user.code=opr_service.reason_marketing_id
													left join (select service_id,sum(addicost_value)total_addicost from opr_service_addicost group by opr_service_addicost.service_id) addicost on addicost.service_id=opr_service.service_id
						) AS a

)a
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
@followup char(1) = '%',
@validate_sts char(1) = '%',
@complete_sts char(1) = '%'
as begin
select top 100 *,
FORMAT(proses_date, 'yyyy-MM-dd HH:mm') str_proses_datetime, 
dbo.f_convertDateToChar(proses_date)str_proses_date,proses_date,
dbo.f_convertDateToChar(cek_date)str_cek_date,cek_date,followupsts
from(
	select offer_no,sales_id,offer_date, dbo.f_convertDateToChar(offer_date)str_offer_date,customer_name,sales_status,sales_status_marketing,
	isnull((select top 1 '1' from fin_sales_opr where fin_sales_opr.sales_id=v_opr_sales.sales_id),'0')fs,sales_status_id,
	branch_id, branch_name, reason_marketing, sales_status_marketing_id, marketing_id_real, po_no,update_status_date,dbo.f_convertDateToChar(update_status_date)str_update_status_date,
	(select MAX(log_date)Proses_date from v_opr_sales_log where sales_status_id='6' and v_opr_sales_log.sales_id =v_opr_sales.sales_id) proses_date,
	(select MAX(log_date)cek_date from v_opr_sales_log where sales_status_id='7' and v_opr_sales_log.sales_id=v_opr_sales.sales_id)cek_date,
	case when v_opr_sales.sales_id not in(select sales_id from opr_sales_device) and datediff(day,offer_date,getdate())>cast(dbo.f_getAppParameterValue('pendingajusales') as int) then '0' else '1' end followupsts,
	validate_sts, complete_sts
	from v_opr_sales
)a
where customer_name like @cust and offer_no like @no and sales_status_id like @status
and fs like @fs and branch_id like @branch_id and sales_status_marketing_id like @ssm
and marketing_id_real like @marketing_id and po_no like @nopo
and followupsts like @followup and validate_sts like @validate_sts and complete_sts like @complete_sts
order by offer_date desc
end
GO

--update opr_sales set validate_sts=0 where offer_no='RQSL97/SMC/III/25'

create proc fin_sales_validate_update
@sales_id bigint,
@validate_sts bit
as begin
update opr_sales set validate_sts=@validate_sts where sales_id=@sales_id
end
go

ALTER proc [dbo].[opr_service_edit]
@service_id bigint,
@offer_date varchar(10),
@broker_id int,
@discount_type_id char(1),
@discount_value money,
@tax_sts bit,
@fee money,
@service_status_id char(1),
@opr_note text,
@additional_fee money = 0,
@additional_fee_note text,
@retval char(1) out
as begin
set nocount on
set transaction isolation level read committed
declare @initial varchar(20),@ctr int,@dat_offer_date date,@offer_no varchar(50),@last_offer_date date
declare @validate_sts bit

select @last_offer_date=offer_date,@ctr=ctr, @validate_sts=validate_sts from v_opr_service where service_id=@service_id
set @dat_offer_date=dbo.f_ConverToDate103(@offer_date)
select @initial=initial from opr_broker where broker_id=@broker_id
set @retval=0

if not (month(@last_offer_date)=month(@dat_offer_date) and year(@last_offer_date)=year(@dat_offer_date))
	begin	
	select @ctr=count(*)+1 from opr_service where month(offer_date)=month(@dat_offer_date) and year(offer_date)=year(@dat_offer_date)
	set @offer_no=dbo.f_set_receipt_number(@ctr,@dat_offer_date,'servicecode',@initial)
	end
else
	set @offer_no=dbo.f_set_receipt_number(@ctr,@last_offer_date,'servicecode',@initial)	

if (@validate_sts=0 and @service_status_id='3')
	begin
	set @retval=1
	end
else
	begin
	update opr_service set 
		update_status_date= case when service_status_id!=@service_status_id then GETDATE() else update_status_date end,
		offer_date=@dat_offer_date,broker_id=@broker_id,discount_type_id=@discount_type_id,
		discount_value=@discount_value,tax_sts=@tax_sts,fee=@fee,service_status_id=@service_status_id,ctr=@ctr,
		opr_note=@opr_note,offer_no=@offer_no,
		ppn=case when @tax_sts=1 then dbo.f_getAppParameterValue('ppn') else 0 end,
		pph21=case when @tax_sts=1 then dbo.f_getAppParameterValue('pph21pkp') else dbo.f_getAppParameterValue('pph21npkp') end	,
		additional_fee=@additional_fee, additional_fee_note=@additional_fee_note
		where service_id=@service_id
	end

end
go

--update opr_service set validate_sts=0 where offer_no='RQSC68/SMC/XII/24'

create proc fin_service_validate_update
@service_id bigint,
@validate_sts bit
as begin
update opr_service set validate_sts=@validate_sts where service_id=@service_id
end
go

ALTER proc [dbo].[aspx_opr_service_list]
@cust varchar(50),
@no varchar(20),
@status char(1),
@finance_sts char(1) = '%',
@sn varchar(50) = '%',
@ts varchar(4) = '%',
@branch_id varchar(10) = '%',
@ssm varchar(2) = '%',
@validate char(1) = '%'
as begin
set nocount on
select offer_no, service_id, offer_date,dbo.f_convertDateToChar(offer_date)str_offer_date, discount_type_id, discount_type, 
	discount_value,tax_sts,broker_id, broker_name,customer_name,service_status,
	replace(service_status_marketing,'-',' ') service_status_marketing,
	replace(cast(isnull(opr_note,' ') as varchar(8000)),'-',' ') opr_note,
	offer_date,
	branch_name, replace(isnull(reason_marketing,''),'-',' ')reason_marketing
	
	from v_opr_service
	where customer_name like @cust and offer_no like @no and service_status_id=@status and invoice_create_sts like @finance_sts
	and service_id in (select service_id from v_opr_service_device where sn like @sn and service_device_sts_id like @ts) and
	branch_id like @branch_id and service_status_marketing_id like @ssm and validate_sts like @validate
end
go

alter table opr_sales_device add purchase_sts bit, purchase_note text
update opr_sales_device set purchase_sts=0
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
@purchasests bit,
@purchasenote text,
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
		guarantee_timetype_id=@guarantee_timetype_id, availability_timetype_id=@availability_timetype_id,
		purchase_sts=@purchasests, purchase_note=@purchasenote
		where sales_id=@sales_id and device_id=@device_id
	if @@ROWCOUNT=0
		insert into opr_sales_device(sales_id, device_id, cost, price, pph21_sts,qty,description, vendor_id,principal_price, creator_id, create_date, draft_sts,
			guarantee_id,availability_id,inden, guarantee_period, guarantee_timetype_id, availability_timetype_id, purchase_sts, purchase_note)
			values(@sales_id, @device_id,@cost,@price,@pph21_sts,@qty,@description,case when @vendor_id=0 then null else @vendor_id end,@principal_price,@user_id, getdate(),@draft_sts ,
			@guarantee_id,@availability_id,@inden,@guarantee_period, @guarantee_timetype_id, @availability_timetype_id, @purchasests,@purchasenote)
	end
end
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
			 rpt_desct_guav, dbo.opr_sales_device.purchase_sts, dbo.opr_sales_device.purchase_note
FROM   dbo.opr_sales_device INNER JOIN
             dbo.opr_sales ON dbo.opr_sales.sales_id = dbo.opr_sales_device.sales_id INNER JOIN
             dbo.tec_device ON dbo.opr_sales_device.device_id = dbo.tec_device.device_id LEFT OUTER JOIN
             dbo.opr_vendor ON dbo.opr_sales_device.vendor_id = dbo.opr_vendor.vendor_id
			 left join appCommonParameter guaranteedevsts on guaranteedevsts.Code=dbo.opr_sales_device.guarantee_id and guaranteedevsts.Type='guaranteedevsts'
			 left join appCommonParameter availabile on availabile.Code=dbo.opr_sales_device.availability_id and availabile.Type='availability' 
			 left join appCommonParameter timetype on timetype.Code=dbo.opr_sales_device.guarantee_timetype_id and timetype.Type='timetype' 
			 left join appCommonParameter availability_timetype on availability_timetype.Code=dbo.opr_sales_device.availability_timetype_id and availability_timetype.Type='timetype' 

GO

ALTER view [dbo].[v_opr_sales_device_all] as
select 
sales_id, device_id, cost, price, device, pph21_sts,qty, description, draft_sts, guarantee_id, availability_id, inden, guarantee_period,
principal_price, price_customer, 
creator_id, cast(create_date as varchar(25))create_date, update_id, cast(update_date as varchar(25))update_date,
isnull(vendor_id,0) vendor_id, vendor_name, marketing_note, guarantee_timetype_id,guarantee_timetype_name, 
availability_timetype_id, availability_timetype_name, purchase_sts, purchase_note

from v_opr_sales_device
GO

create proc [dbo].[opr_sales_register_edit]
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
@complete_sts bit = null,
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
		ctgsales_id=@ctgsales_id, complete_sts=case when @complete_sts is null then complete_sts else @complete_sts end
		where sales_id=@sales_id

	--disini data opr_sales_principal_price tidak di update dikarena historical yang dianut berdasarkan parameter pertamakali di add
	if @last_sales_status_id<>@sales_status_id
		insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
		end

end
go


create proc aspx_postpone_list
@device varchar(50)
as begin
select a.sales_id,a.device_id, device, qty, b.offer_no, b.customer_name,b.marketing_id,b.sales_status_marketing_updatedate,dbo.f_convertDateToChar(sales_status_marketing_updatedate)str_sales_status_marketing_updatedate
from v_opr_sales_device a
inner join v_opr_sales b on a.sales_id=b.sales_id
where a.purchase_sts=0 and b.sales_status_id='6' and a.device like @device
end
go