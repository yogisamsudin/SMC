use test4
go

insert into appMenu(MenuName,MenuURL,SubMenuID,MenuUrut,Initial)values
	('Inquery Penjualan',	'activities/operation/opr_sales_inq.aspx',	101,	9,	'OIP')
go

ALTER proc [dbo].[opr_sales_edit_marketing]
@sales_id bigint,
@sales_status_marketing_id char(1),
@reason_marketing_id varchar(3) = null,
@user_id varchar(25) = 'sa',
@ret varchar(100) = '' out,
@discount_type_id char(1),
@discount_value money
as begin
set nocount on
set transaction isolation level read committed

set @ret = ''

declare @sales_status_id varchar(1), @grand_price money, @limit_approve_sts bit

set @limit_approve_sts=0

set @sales_status_id=case 
	when @sales_status_marketing_id='3' then '4' --batal; diopr:4 batal
	when @sales_status_marketing_id='4' then '1' --balikan ke register
	when @sales_status_marketing_id='2' then '5' --otorisasi
	else '2'
end

select @grand_price=grand_price from v_opr_sales where sales_id=@sales_id

if DATEPART(HOUR, GETDATE()) > cast(dbo.f_getAppParameterValue('closehour') as int)
	set @ret='Tutup transaksi, perubahan pada data tidak diperkenankan...'
if @sales_status_id='5' and not exists(select 'x' from opr_sales_document where sales_id=@sales_id)
	set @ret='File PO tidak ditemukan...'
else begin
	
	update act_sales set submit_date=case when @sales_status_marketing_id in ('3','4') then getdate() else null end where sales_id=@sales_id

	--otorisasi
	if @sales_status_id='5' and @limit_approve_sts=0 and not exists (select 'x' from opr_sales_approver where @grand_price between limit_awal and limit_akhir)
		begin
		set @limit_approve_sts=1
		set @sales_status_id='6'
		end


	update opr_sales set sales_status_marketing_id=@sales_status_marketing_id,reason_marketing_id=@reason_marketing_id,
		sales_status_marketing_updatedate=case when @sales_status_marketing_id!=sales_status_marketing_id then getdate() else sales_status_marketing_updatedate end ,
		sales_status_id=@sales_status_id, limit_approve_sts=@limit_approve_sts,discount_type_id=@discount_type_id,discount_value=@discount_value
		where sales_id=@sales_id

	if @sales_status_id in ('1','4','6') 
		insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
	
	end
end
go