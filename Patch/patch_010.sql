USE [TEST4]
GO

--drop table fin_invoice_receipt
--go 

CREATE TABLE [dbo].[fin_invoice_receipt](
	[invoice_receipt_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[deliver_date] [date] NULL,
	[messanger_id] [int] NULL,
	[receipt_date] [date] NULL,
	[receipt_name] [varchar](50) NULL,
 CONSTRAINT [PK_fin_invoice_receipt] PRIMARY KEY CLUSTERED 
(
	[invoice_receipt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
--drop table fin_invoice_receipt_sales
--go
CREATE TABLE [dbo].[fin_invoice_receipt_sales](
	[invoice_receipt_id] [int] NOT NULL,
	[invoice_sales_id] [int] NOT NULL
) ON [PRIMARY]
GO

drop table fin_invoice_receipt_service
go
CREATE TABLE [dbo].[fin_invoice_receipt_service](
	[invoice_receipt_id] [int] NOT NULL,
	[invoice_service_id] [int] NOT NULL
) ON [PRIMARY]
GO


--drop view v_fin_invoice_receipt
go

CREATE VIEW [dbo].[v_fin_invoice_receipt]
AS
SELECT dbo.fin_invoice_receipt.invoice_receipt_id, dbo.fin_invoice_receipt.deliver_date, dbo.fin_invoice_receipt.messanger_id, dbo.fin_invoice_receipt.customer_id, dbo.fin_invoice_receipt.receipt_date, dbo.fin_invoice_receipt.receipt_name, dbo.act_customer.customer_name, 
             dbo.act_customer.customer_address, dbo.exp_messanger.messanger_name
FROM   dbo.fin_invoice_receipt INNER JOIN
             dbo.act_customer ON dbo.fin_invoice_receipt.customer_id = dbo.act_customer.customer_id left JOIN
             dbo.exp_messanger ON dbo.fin_invoice_receipt.messanger_id = dbo.exp_messanger.messanger_id
GO

--drop view v_fin_invoice_receipt_detail
go
CREATE VIEW [dbo].[v_fin_invoice_receipt_detail]
AS
SELECT dbo.fin_invoice_receipt_sales.invoice_receipt_id, dbo.fin_invoice_receipt_sales.invoice_sales_id id, 'SL' jenis, 
	dbo.v_fin_sales.Invoice_no, '#'+cast(dbo.exp_schedule_sales_fin.schedule_id as varchar(20))+'#'+cast(dbo.v_fin_sales.invoice_sales_id as varchar(200)) receipt_no, dbo.v_fin_sales.grand_price
FROM   dbo.fin_invoice_receipt_sales INNER JOIN
             dbo.v_fin_sales ON dbo.fin_invoice_receipt_sales.invoice_sales_id = dbo.v_fin_sales.invoice_sales_id
			 inner join dbo.exp_schedule_sales_fin on dbo.exp_schedule_sales_fin.invoice_sales_id=dbo.v_fin_sales.invoice_sales_id
union all
SELECT dbo.fin_invoice_receipt_service.invoice_receipt_id, dbo.fin_invoice_receipt_service.invoice_service_id id, 'SC' jenis, 
	dbo.v_fin_service.Invoice_no,'#'+cast(dbo.exp_schedule_service_fin.schedule_id as varchar(20))+'#'+cast(dbo.v_fin_service.invoice_service_id as varchar(200)) receipt_no, dbo.v_fin_service.grand_price
FROM   dbo.fin_invoice_receipt_service INNER JOIN
             dbo.v_fin_service ON dbo.fin_invoice_receipt_service.invoice_service_id = dbo.v_fin_service.invoice_service_id
			 inner join dbo.exp_schedule_service_fin on dbo.exp_schedule_service_fin.invoice_service_id=dbo.v_fin_service.invoice_service_id
GO

--drop proc fin_invoice_receipt_add
go
create proc fin_invoice_receipt_add
@customer_id int,
@invoice_receipt_id int out
as begin
insert into fin_invoice_receipt(customer_id)values(@customer_id)
set @invoice_receipt_id=@@IDENTITY
end
go

--drop proc fin_invoice_receipt_edit
go

create proc fin_invoice_receipt_edit
@invoice_receipt_id int,
@develivery_date varchar(10),
@messanger_id int,
@receipt_date varchar(10),
@receipt_name varchar(50)
as begin
update fin_invoice_receipt
	set deliver_date=case when @develivery_date='' then null else dbo.f_ConverToDate103(@develivery_date) end,
	messanger_id=@messanger_id,
	receipt_date=case when @receipt_date='' then null else dbo.f_ConverToDate103(@receipt_date) end,receipt_name=@receipt_name
	where invoice_receipt_id=@invoice_receipt_id
end
go

--drop proc fin_invoice_receipt_delete
go 

create proc fin_invoice_receipt_delete
@invoice_receipt_id int
as begin
delete fin_invoice_receipt_sales where invoice_receipt_id=@invoice_receipt_id
delete fin_invoice_receipt_service where invoice_receipt_id=@invoice_receipt_id
delete fin_invoice_receipt where invoice_receipt_id=@invoice_receipt_id
end
go

--drop proc ac_fin_invoice_receipt_allinvoicedata
go

create proc ac_fin_invoice_receipt_allinvoicedata
@customer_id int,
@invoice_no varchar(50),
@jenis varchar(2)
as begin
if @jenis='SL'
	select invoice_sales_id [value],Invoice_no [text] from v_fin_sales tbl where customer_id=6 and invoice_no like @invoice_no for xml auto,xmldata
else
	select invoice_service_id [value], invoice_no [text] from v_fin_service tbl where customer_id=6 and Invoice_no like @invoice_no for xml auto,xmldata
end
go

--drop proc fin_invoice_receipt_detail_add
go

create proc fin_invoice_receipt_detail_add
@invoice_receipt_id int,
@jenis varchar(2),
@id int
as begin
if @jenis='SL'
	begin
	select 'x' from fin_invoice_receipt_sales where invoice_receipt_id=@invoice_receipt_id and invoice_sales_id=@id
	if @@ROWCOUNT=0
		insert into fin_invoice_receipt_sales(invoice_receipt_id,invoice_sales_id)values(@invoice_receipt_id,@id)
	end
else
	begin
	select 'x' from fin_invoice_receipt_service where invoice_receipt_id=@invoice_receipt_id and invoice_service_id=@id
	if @@ROWCOUNT=0
		insert into fin_invoice_receipt_service(invoice_receipt_id,invoice_service_id)values(@invoice_receipt_id,@id)
	end
end
go

--drop proc fin_invoice_receipt_detail_delete
go
create proc fin_invoice_receipt_detail_delete
@invoice_receipt_id int,
@jenis varchar(2),
@id int
as begin
if @jenis='SL'
	delete fin_invoice_receipt_sales where invoice_receipt_id=@invoice_receipt_id and invoice_sales_id=@id
else
	delete fin_invoice_receipt_service where invoice_receipt_id=@invoice_receipt_id and invoice_service_id=@id
end
go