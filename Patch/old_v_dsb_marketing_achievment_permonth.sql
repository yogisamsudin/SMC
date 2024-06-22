
ALTER view [dbo].[v_dsb_marketing_achievment_permonth] as
select a.marketing_id, int_month,total_net from (select act_marketing.marketing_id, int_month from v_par_list_month, act_marketing)a
left join (
select marketing_id, bulan,sum(net)total_net
from(
 SELECT marketing_id,net,invoice_date,invoice_sts,month(invoice_date)bulan,'s' jenis
 FROM   v_rpt_fin_service  a
 union all
 select marketing_id, net,invoice_date,invoice_sts,month(invoice_date)bulan,'p'
 from v_rpt_fin_sales a
 )a
  WHERE  invoice_sts=1 and year(invoice_date)=year(dbo.f_getAplDate()) and month(invoice_date)<=month(dbo.f_getAplDate())  
group by marketing_id, bulan
)b on a.marketing_id=b.marketing_id and a.int_month=b.bulan

GO


