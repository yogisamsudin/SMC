alter view v_act_customer_passive as
select sales.last_offer_date, dbo.f_convertDateToChar(sales.last_offer_date)str_last_offer_date,act_customer.customer_id,act_customer.marketing_id, customer_name from act_customer
left join(
	select marketing_id, max(offer_date)last_offer_date from act_sales
	inner join opr_sales on opr_sales.sales_id=act_sales.sales_id
	group by marketing_id
)sales on act_customer.marketing_id=sales.marketing_id
where last_offer_date<DATEADD(month,-6, cast(getdate() as date))