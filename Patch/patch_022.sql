--begin tran
go
create view v_act_pasif_customer as
select v_act_customer.customer_id, customer_name, marketing_id, last_trandate from v_act_customer
inner join (select customer_id,max(invoice_date)last_trandate from v_fin_sales group by customer_id) a on a.customer_id=v_act_customer.customer_id
where v_act_customer.customer_id not in (
select act_sales.customer_id from fin_sales 
inner join fin_sales_opr on fin_sales.invoice_sales_id=fin_sales_opr.invoice_sales_id
inner join opr_sales on opr_sales.sales_id=fin_sales_opr.sales_id
inner join act_sales on act_sales.sales_id=opr_sales.sales_id
where invoice_date>DATEADD(month,-6,getdate())
)
go

--select customer_id, customer_name, marketing_id, last_trandate, dbo.f_convertDateToChar(last_trandate)str_last_trandate from v_act_pasif_customer order by last_trandate desc, customer_name

GO

CREATE TABLE [dbo].[tmp_pajak_faktur](
	[baris] [int] NULL,
	[tglfaktur] [date] NULL,
	[jenisfaktur] [varchar](10) NULL,
	[kodetransaksi] [varchar](5) NULL,
	[keterangantambahan] [varchar](50) NULL,
	[dokpendukung] [varchar](50) NULL,
	[referensi] [varchar](50) NULL,
	[capfasilitas] [varchar](50) NULL,
	[idtkupenjual] [varchar](30) NULL,
	[npwpnikpembeli] [varchar](30) NULL,
	[jenisidpembeli] [varchar](5) NULL,
	[negarapembeli] [varchar](5) NULL,
	[nodokpembeli] [varchar](30) NULL,
	[namapembeli] [varchar](50) NULL,
	[alamatpembeli] [varchar](100) NULL,
	[emailpembeli] [varchar](50) NULL,
	[idtkupembeli] [varchar](30) NULL,
	[id][bigint] null
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tmp_pajak_fakturdetail](
	[baris] [int] NULL,
	[barangjasa] [varchar](3) NULL,
	[namabarangjasa] [varchar](50) NULL,
	[kodebarangjasa] [varchar](10) NULL,
	[namasatuanukur] [varchar](10) NULL,
	[hargasatuan] [money] NULL,
	[jumlahbarangjasa] [int] NULL,
	[totaldiskon] [money] NULL,
	[dpp] [money] NULL,
	[dppnilailain] [money] NULL,
	[tarifppn] [float] NULL,
	[ppn][money] null,
	[tarifppnbm] [float] NULL,
	[ppnbm] [money] NULL,
	[id][bigint] null
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[act_jenisidpembeli](
	[jenisidpembeli_id] [varchar](15) NULL,
	[jenisidpembeli_name] [varchar](50) NULL
) ON [PRIMARY]
GO

insert into act_jenisidpembeli(jenisidpembeli_id, jenisidpembeli_name)values('TIN','NPWP')
go
insert into act_jenisidpembeli(jenisidpembeli_id, jenisidpembeli_name)values('National ID','NIK')
go
insert into act_jenisidpembeli(jenisidpembeli_id, jenisidpembeli_name)values('Passport','Paspor')
go
insert into act_jenisidpembeli(jenisidpembeli_id, jenisidpembeli_name)values('Other ID','Dokumen Lainnya')
go

alter table act_customer add jenisidpembeli_id varchar(15)
go
alter table act_customer add tkuid varchar(50)
go

ALTER VIEW [dbo].[v_act_customer]
AS
SELECT        dbo.act_customer.customer_id, dbo.act_customer.customer_name, dbo.act_customer.customer_phone, dbo.act_customer.customer_fax, 
                         dbo.act_customer.marketing_id, dbo.act_customer.customer_email, dbo.act_marketing.marketing_name, dbo.act_marketing.marketing_phone, 
                         dbo.act_marketing.all_access, dbo.act_customer.customer_address, dbo.act_customer.customer_address_location_id, 
                         dbo.exp_location.location_address AS customer_address_location, ISNULL(dbo.exp_location.distance, 0) AS distance, dbo.act_customer.group_customer_id, 
                         act_customer_1.customer_name AS group_customer, dbo.act_customer.npwp, dbo.act_customer.address_id, dbo.exp_address.latitude, dbo.exp_address.longitude, 
                         dbo.act_customer.branch_id, dbo.par_branch.branch_name, dbo.act_customer.user_device_mandatory,
						 dbo.act_customer.jenisidpembeli_id, dbo.act_jenisidpembeli.jenisidpembeli_name, dbo.act_customer.tkuid
FROM            dbo.act_customer INNER JOIN
                         dbo.act_marketing ON dbo.act_customer.marketing_id = dbo.act_marketing.marketing_id INNER JOIN
                         dbo.act_customer AS act_customer_1 ON dbo.act_customer.group_customer_id = act_customer_1.customer_id LEFT OUTER JOIN
                         dbo.par_branch ON dbo.act_customer.branch_id = dbo.par_branch.branch_id LEFT OUTER JOIN
                         dbo.exp_address ON dbo.act_customer.address_id = dbo.exp_address.address_id LEFT OUTER JOIN
                         dbo.exp_location ON dbo.act_customer.customer_address_location_id = dbo.exp_location.location_id
						 left join dbo.act_jenisidpembeli on dbo.act_jenisidpembeli.jenisidpembeli_id=dbo.act_customer.jenisidpembeli_id
GO

create proc act_customer_finance_update
@customer_id bigint,
@npwp varchar(50),
@tkuid varchar(50),
@jenisidpembeli_id varchar(15)
as begin
update act_customer set npwp=@npwp, tkuid=@tkuid, jenisidpembeli_id=@jenisidpembeli_id where customer_id=@customer_id
end


go


create proc tmp_generate_cortex
@tanggal varchar(10)
as begin
--set @tanggal='05/12/2024'

declare @tgl date
set @tgl=dbo.f_ConverToDate103(@tanggal)
select @tgl

declare @id bigint, @jenis char(1)

declare 
@baris	int
,@tglfaktur	date
,@jenisfaktur	varchar(10)
,@kodetransaksi	varchar(5)
,@keterangantambahan	varchar(50)
,@dokpendukung	varchar(50)
,@referensi	varchar(50)
,@capfasilitas	varchar(50)
,@idtkupenjual	varchar(30)
,@npwpnikpembeli	varchar(30)
,@jenisidpembeli	varchar(5)
,@negarapembeli	varchar(5)
,@nodokpembeli	varchar(30)
,@namapembeli	varchar(50)
,@alamatpembeli	varchar(100)
,@emailpembeli	varchar(50)
,@idtkupembeli	varchar(30)

declare
@barangjasa	varchar(3)
,@namabarangjasa	varchar(50)
,@namasatuanukur	varchar(10)
,@hargasatuan	money
,@jumlahbarangjasa	int
,@totaldiskon	money
,@dpp	money
,@dppnilailain	money
,@tarifppn	float
,@tarifppnbm	float
,@ppnbm	money
	
	

truncate table tmp_pajak_faktur
truncate table tmp_pajak_fakturdetail

declare csr cursor for 
	select 
	a.invoice_sales_id,
	'1' jenis--sales
	--Baris	
	,a.invoice_date tglfaktur--Tanggal Faktur	
	,'normal' jnsfaktur--Jenis Faktur	
	,'04' kdtransaksi --Kode Transaksi	
	,'' keterangan --Keterangan Tambahan	
	,'' dokpendukung --Dokumen Pendukung	
	,'' referensi --Referensi	
	,'' capfasilitas --Cap Fasilitas	
	,'0537037731044000' idtkupenjual --ID TKU Penjual	
	,b.npwp idpembeli --NPWP/NIK Pembeli	
	,b.jenisidpembeli_id jnidpembeli --Jenis ID Pembeli	
	,'IDN' negarapembeli --Negara Pembeli	
	,a.invoice_no nodocpembeli -- Nomor Dokumen Pembeli	
	,a.customer_name nmpembeli --Nama Pembeli	
	,b.customer_address almpembeli -- Alamat Pembeli	
	,b.customer_email epembeli-- Email Pembeli	
	,b.tkuid idtkupembeli -- id ID TKU Pembeli

	from v_fin_sales a
	inner join act_customer b on a.customer_id = b.customer_id
	where invoice_date=@tgl
	union
	select 
	a.invoice_service_id
	,'2' --service
	--Baris	
	,a.invoice_date tglfaktur--Tanggal Faktur	
	,'normal' jnsfaktur--Jenis Faktur	
	,'04' kdtransaksi --Kode Transaksi	
	,'' keterangan --Keterangan Tambahan	
	,'' dokpendukung --Dokumen Pendukung	
	,'' referensi --Referensi	
	,'' capfasilitas --Cap Fasilitas	
	,'0537037731044000' idtkupenjual --ID TKU Penjual	
	,b.npwp idpembeli --NPWP/NIK Pembeli	
	,b.jenisidpembeli_id  jnidpembeli --Jenis ID Pembeli	
	,'IDN' negarapembeli --Negara Pembeli	
	,a.invoice_no nodocpembeli -- Nomor Dokumen Pembeli	
	,a.customer_name nmpembeli --Nama Pembeli	
	,b.customer_address almpembeli -- Alamat Pembeli	
	,b.customer_email epembeli-- Email Pembeli	
	,b.tkuid idtkupembeli -- id ID TKU Pembeli

	from v_fin_service a
	inner join act_customer b on a.customer_id = b.customer_id
	where invoice_date=@tgl

open csr

fetch next from csr into @id, @jenis,@tglfaktur,@jenisfaktur,@kodetransaksi,@keterangantambahan,@dokpendukung,@referensi,@capfasilitas,@idtkupenjual
	,@npwpnikpembeli,@jenisidpembeli,@negarapembeli,@nodokpembeli,@namapembeli,@alamatpembeli,@emailpembeli,@idtkupembeli
	
set @baris=1
while @@FETCH_STATUS=0
	begin
	insert into tmp_pajak_faktur(baris,	tglfaktur,jenisfaktur,kodetransaksi,keterangantambahan,dokpendukung,referensi
		,capfasilitas,idtkupenjual,npwpnikpembeli,jenisidpembeli,negarapembeli,nodokpembeli,namapembeli,alamatpembeli
		,emailpembeli,idtkupembeli, id)
	values(@baris,@tglfaktur,@jenisfaktur,@kodetransaksi,@keterangantambahan,@dokpendukung,@referensi
		,@capfasilitas,@idtkupenjual,@npwpnikpembeli,@jenisidpembeli,@negarapembeli,@nodokpembeli,@namapembeli,@alamatpembeli
		,@emailpembeli,@idtkupembeli, @id)

	if (@jenis='1') --sales
		begin
		insert into tmp_pajak_fakturdetail(	baris,barangjasa,kodebarangjasa,namabarangjasa,namasatuanukur,hargasatuan,jumlahbarangjasa,
			totaldiskon,dpp,dppnilailain,tarifppn,ppn,tarifppnbm,ppnbm, id)
		select 
			@baris
			,'A'--Barang/Jasa	
			,'000000'--Kode Barang Jasa	
			,b.device  --Nama Barang/Jasa	
			,'UM.0021' --Nama Satuan Ukur	
			,b.price_customer -- Harga Satuan	
			,b.qty --Jumlah Barang Jasa	
			,0 --Total Diskon	
			,b.price_customer * b.qty -- DPP	
			,(c.ppn/12) * b.price_customer * b.qty --DPP Nilai Lain	
			,c.ppn -- Tarif PPN	
			,(c.ppn/100) * b.price_customer * b.qty -- PPN	
			,0 --Tarif PPnBM	
			,0 --PPnBM
			,@id
			from fin_sales_opr a
			inner join v_opr_sales_device b on a.sales_id=b.sales_id
			inner join opr_sales c on a.sales_id=c.sales_id
			where a.invoice_sales_id=@id
		end
	if (@jenis='2')
		begin
		insert into tmp_pajak_fakturdetail(	baris,barangjasa,kodebarangjasa,namabarangjasa,namasatuanukur,hargasatuan,jumlahbarangjasa,
			totaldiskon,dpp,dppnilailain,tarifppn,ppn,tarifppnbm,ppnbm,id )
		select 
			@baris --Baris	
			,a.jenis--Barang/Jasa	
			,a.kodebarang--Kode Barang Jasa	
			,a.device  --Nama Barang/Jasa	
			,a.satukur --Nama Satuan Ukur	
			,a.price_customer -- Harga Satuan	
			,a.qty --Jumlah Barang Jasa	
			,0 --Total Diskon	
			,a.price_customer * a.qty -- DPP	
			,(b.ppn/12) * a.price_customer * a.qty --DPP Nilai Lain	
			,b.ppn -- Tarif PPN	
			,(b.ppn/100) * a.price_customer * a.qty -- PPN	
			,0 --Tarif PPnBM	
			,0 --PPnBM
			,@id
			 from(
				select service_id, 'Service Fee '+device + ' sn: '+sn device,service_cost price_customer, 1 qty, 'B' jenis, '200103' kodebarang, 'UM.0033' satukur
				from v_opr_service_device where service_cost>0 --and service_id=112040
				union
				select service_id, device, price_customer, total,'A', '000000','UM.0021'
			from v_opr_service_device_component --where service_id=112040
			)a 
			inner join opr_service b on a.service_id=b.service_id
			inner join fin_service_opr c on c.service_id=a.service_id
			where c.invoice_service_id=@id
		end

	fetch next from csr into @id, @jenis,@tglfaktur,@jenisfaktur,@kodetransaksi,@keterangantambahan,@dokpendukung,@referensi,@capfasilitas,@idtkupenjual
		,@npwpnikpembeli,@jenisidpembeli,@negarapembeli,@nodokpembeli,@namapembeli,@alamatpembeli,@emailpembeli,@idtkupembeli

	set @baris=@baris + 1
	end

close csr

deallocate csr

--select top 1 * from act_customer

end
go

--rollback