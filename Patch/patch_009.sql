
CREATE TABLE [dbo].[fin_fee_pph21](
	[fee_pph21_id] [int] IDENTITY(1,1) NOT NULL,
	[fee1] [money] NOT NULL,
	[fee2] [money] NOT NULL,
	[dpp] [float] NOT NULL,
	[tarif] [float] NOT NULL,
	[npwp_sts] [bit] NOT NULL,
 CONSTRAINT [PK_fin_fee_pph21] PRIMARY KEY CLUSTERED 
(
	[fee_pph21_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create proc fin_fee_pph21_add
@fee1 money,
@fee2 money,
@dpp float,
@tarif float,
@npwp_sts bit
as begin
insert into fin_fee_pph21(fee1,fee2,dpp,tarif,npwp_sts)values(@fee1,@fee2,@dpp,@tarif,@npwp_sts)
end
go

create proc fin_fee_pph21_edit
@fee_pph21_id int,
@fee1 money,
@fee2 money,
@dpp float,
@tarif float,
@npwp_sts bit
as begin
update fin_fee_pph21 set fee1=@fee1,fee2=@fee2,dpp=@dpp, tarif=@tarif,npwp_sts=@npwp_sts where fee_pph21_id=@fee_pph21_id
end
go

create proc fin_fee_pph21_delete
@fee_pph21_id int
as begin
delete fin_fee_pph21 where fee_pph21_id=@fee_pph21_id
end
go
