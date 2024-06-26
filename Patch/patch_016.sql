if not exists(select'x' from  appParameter where kode='closeproses')
insert into appParameter(Kode,nilai, Keterangan,field_type_id)values('closeproses','1700','close step proses in opr','N')
go
if not exists(select'x' from  appParameter where kode='closechecking')
insert into appParameter(Kode,nilai, Keterangan,field_type_id)values('closechecking','1730','close step checking in teknisi','N')
go
update appparameter set nilai='1600' where kode='closehour'
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
@user_id varchar(25) = 'sa',
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

		reason_marketing_id=case when @sales_status_id in ('1','2') then '1' else null end
		where sales_id=@sales_id

	--disini data opr_sales_principal_price tidak di update dikarena historical yang dianut berdasarkan parameter pertamakali di add
	if @last_sales_status_id<>@sales_status_id
		insert into opr_sales_log(log_date,sales_id,user_id,sales_status_id)values(getdate(),@sales_id,@user_Id,@sales_status_id)
		end

end
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

--if DATEPART(HOUR, GETDATE()) > cast(dbo.f_getAppParameterValue('closehour') as int)
if cast(cast(DATEPART(HOUR, GETDATE()) as varchar(5))+cast(DATEPART(Minute, GETDATE()) as varchar(5)) as int) > cast(dbo.f_getAppParameterValue('closehour') as int)
	set @ret='Tutup transaksi, perubahan pada data tidak diperkenankan...'
else if @sales_status_id='5' and not exists(select 'x' from opr_sales_document where sales_id=@sales_id)
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