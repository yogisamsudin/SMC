alter proc rpt_marketing_net
@date1 date,
@date2 date
as begin

select b.*, target_value,
	(cast(total_net as bigint)/5000000)*500000 komisi_berjenjang,
	case when b.total_net>=target_value then b.total_net * (3.5/100) else 0 end komisi3k5
	from(
		select a.marketing_id,SUM(net) total_net from(
		select marketing_id, net from v_rpt_fin_sales where --invoice_date between '2021-04-01' and '2021-04-30' 
		invoice_date between @date1 and @date2 
		and invoice_sts=1
		union all
		select marketing_id, net from v_rpt_fin_service where --invoice_date between '2021-04-01' and '2021-04-30' 
		invoice_date between @date1 and @date2 
		and invoice_sts=1
	)a group by marketing_id
)b inner join act_marketing on  act_marketing.marketing_id=b.marketing_id
end