use test4
go

insert into appMenu(MenuName,MenuURL,SubMenuID,MenuUrut,Initial)values
	('Addi.Cost Penjualan',	'activities/operation/opr_sales_addicost.aspx',	101,	'OAC')
go


CREATE TABLE [dbo].[opr_sales_addicost](
	[addicost_id] [bigint] IDENTITY(1,1) NOT NULL,
	[sales_id] [bigint] NOT NULL,
	[addicost_name] [varchar](100) NOT NULL,
	[addicost_value] [money] NOT NULL,
 CONSTRAINT [PK_opr_sales_addicost] PRIMARY KEY CLUSTERED 
(
	[addicost_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create VIEW [dbo].[v_opr_sales_addicost]
AS
SELECT addicost_id, sales_id, addicost_name, addicost_value
FROM   dbo.opr_sales_addicost
GO

create proc opr_sales_addicost_add
@sales_id bigint,
@addicost_name varchar(100),
@addicost_value money
as begin
insert into opr_sales_addicost(sales_id, addicost_name, addicost_value)values
(@sales_id, @addicost_name, @addicost_value)
end
go

create proc opr_sales_addicost_edit
@addicost_id bigint,
@addicost_name varchar(100),
@addicost_value money
as begin
update opr_sales_addicost set addicost_name=@addicost_name, addicost_value=@addicost_value
	where addicost_id=@addicost_id
end
go

create proc opr_sales_addicost_delete
@addicost_id bigint
as begin
delete opr_sales_addicost where addicost_id=@addicost_id
end
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
						 isnull(adcost.additional_cost,0)additional_cost
						 
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
						 left join(
							select sales_id,sum(addicost_value)additional_cost from opr_sales_addicost group by sales_id
						 )adcost on adcost.sales_id=dbo.opr_sales.sales_id
)a
GO

