declare @cur_date date
set @cur_date='2021-4-30'

select marketing_id_real,month(@cur_date)bulan,YEAR(@cur_date)tahun, sum(total)total from(
select marketing_id_real,sum(net)total 
				from v_opr_service
				inner join fin_service_opr on fin_service_opr.service_id=v_opr_service.service_id
				inner join fin_service on fin_service.invoice_service_id=fin_service_opr.invoice_service_id
				where month(invoice_date)=month(@cur_date) and year(invoice_date)=year(@cur_date) and invoice_sts=1
				group by marketing_id_real
				union all
				select marketing_id_real,sum(net)total_sales  from v_opr_sales
				inner join fin_sales_opr on fin_sales_opr.sales_id=v_opr_sales.sales_id
				inner join fin_sales  on fin_sales_opr.invoice_sales_id=fin_sales.invoice_sales_id
				where month(invoice_date)=month(@cur_date) and year(invoice_date)=year(@cur_date) and invoice_sts=1
				group by marketing_id_real
)a group by marketing_id_real