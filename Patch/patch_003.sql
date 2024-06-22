
CREATE TABLE [dbo].[hr_employee_loan](
	[loan_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NOT NULL,
	[loan_date] [date] NOT NULL,
	[note] [text] NOT NULL,
	[tenor] [smallint] NOT NULL,
	[loan_amount] [money] NOT NULL,
	[loan_no] [varchar](5) NOT NULL,
	[loan_start_month] [smallint] NOT NULL,
	[loan_start_year] [int] NOT NULL,
	[paidoff_sts] [bit] NOT NULL,
	[installment] [money] NOT NULL,
	[approve_sts] [bit] NOT NULL,
	[wageparam_id] [int] NOT NULL,
 CONSTRAINT [PK_hr_employee_loan] PRIMARY KEY CLUSTERED 
(
	[loan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[hr_employee_loan] ADD  CONSTRAINT [DF_hr_employee_loan_paidoff_sts]  DEFAULT ((0)) FOR [paidoff_sts]
GO

ALTER TABLE [dbo].[hr_employee_loan] ADD  CONSTRAINT [DF_hr_employee_loan_approve_sts]  DEFAULT ((0)) FOR [approve_sts]
GO




create VIEW [dbo].[v_hr_employee_loan]
AS
SELECT        dbo.hr_employee_loan.loan_id, dbo.hr_employee_loan.employee_id, dbo.hr_employee_loan.loan_date, dbo.hr_employee_loan.note, dbo.hr_employee_loan.tenor, dbo.hr_employee_loan.loan_amount, 
                         dbo.hr_employee_loan.loan_no, dbo.hr_employee_loan.loan_start_month, dbo.hr_employee_loan.loan_start_year, dbo.appCommonParameter.Keterangan AS loan_start_month_name, dbo.hr_employee.employee_name, 
                         dbo.hr_employee_loan.paidoff_sts, dbo.hr_employee_loan.installment, dbo.hr_employee_loan.approve_sts,dbo.hr_employee_loan.wageparam_id
FROM            dbo.hr_employee_loan INNER JOIN
                         dbo.hr_employee ON dbo.hr_employee_loan.employee_id = dbo.hr_employee.employee_id INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_employee_loan.loan_start_month = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'listmonth'
GO

create proc hr_employee_loan_add
@employee_id	int,
@loan_date	varchar(10),
@note	text,
@tenor	smallint,
@loan_amount	money,
@loan_start_month	smallint,
@loan_start_year	int,
@installment	money,
@wageparam_id int
as begin

insert into hr_employee_loan(employee_id, loan_date,note,loan_amount, loan_start_month, loan_start_year,installment,tenor,loan_no, paidoff_sts,approve_sts, wageparam_id)
values(@employee_id, dbo.f_ConverToDate103(@loan_date),@note,@loan_amount, @loan_start_month, @loan_start_year,@installment,@tenor,'*',0,0,@wageparam_id)
end
go

create proc hr_employee_loan_edit
@loan_id int,
@employee_id	int,
@loan_date	varchar(10),
@note	text,
@tenor	smallint,
@loan_amount	money,
@loan_start_month	smallint,
@loan_start_year	int,
@installment	money,
@wageparam_id int
as begin

update hr_employee_loan set employee_id=@employee_id, loan_date=dbo.f_ConverToDate103(@loan_date),note=@note,loan_amount=@loan_amount, 
	loan_start_month=@loan_start_month, loan_start_year=@loan_start_year,installment=@installment, tenor=@tenor, wageparam_id=@wageparam_id
where loan_id=@loan_id
end	
go

create proc hr_employee_loan_delete
@loan_id int
as begin
delete hr_employee_loan where loan_id=@loan_id and loan_id not in (select loan_id from hr_employee_loan_installment)
end
go

CREATE TABLE [dbo].[hr_employee_loan_installment](
	[loan_id] [int] NOT NULL,
	[ins_period] [smallint] NOT NULL,
	[ins_month] [smallint] NOT NULL,
	[ins_year] [int] NOT NULL,
	[paid_sts] [bit] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hr_employee_loan_installment] ADD  CONSTRAINT [DF_hr_employee_loan_installment_paid_sts]  DEFAULT ((0)) FOR [paid_sts]
GO

CREATE VIEW [dbo].[v_hr_employee_loan_installment]
AS
SELECT        dbo.hr_employee_loan_installment.loan_id, dbo.hr_employee_loan_installment.ins_period, dbo.hr_employee_loan_installment.ins_month, dbo.hr_employee_loan_installment.ins_year, 
                         dbo.appCommonParameter.Keterangan AS ins_month_name, dbo.hr_employee_loan_installment.paid_sts
FROM            dbo.hr_employee_loan_installment INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_employee_loan_installment.ins_month = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'listmonth'
GO

CREATE proc hr_employee_loan_approve
@loan_id int
as begin


declare @loan_amount money, @tenor smallint, @loan_start_month smallint, @loan_start_year int
select @loan_amount=loan_amount,@tenor=tenor,@loan_start_month=loan_start_month,@loan_start_year=loan_start_year from hr_employee_loan where loan_id=@loan_id

declare @last_nomor varchar(5),@nomor varchar(5)
set @last_nomor=(select top 1 loan_no from hr_employee_loan where approve_sts=1 order by cast(loan_no as int) desc)
set @nomor= isnull(cast(@last_nomor as int),0)+1
set @nomor= replicate('0',5-len(@nomor))+@nomor
select @nomor

update hr_employee_loan set approve_sts=1,loan_no=@nomor where loan_id=@loan_id
delete hr_employee_loan_installment where loan_id=@loan_id

declare @period smallint,@month smallint, @year int

set @period=1
set @month=@loan_start_month
set @year=@loan_start_year

while @period<=@tenor
	begin

	insert into hr_employee_loan_installment(loan_id,ins_period,ins_month,ins_year,paid_sts)
	values(@loan_id, @period,@month,@year,0)

	set @period=@period+1
	set @month=@month+1
	if @month>12 
		begin
		set @year=@year+1
		set @month=1
		end
	end

end
go

insert into appParameter(kode, nilai, Keterangan,field_type_id)
values('paramcutsal','0','Parameter Pemotongan Pinjaman','N')
go

ALTER proc [dbo].[hr_salary_add]
@salary_name varchar(100),
@month_issue smallint,
@year_issue int,
@salary_date varchar(10),
@id int out
as begin
insert into hr_salary(salary_name, month_issue, year_issue, salary_date)
	values(@salary_name,@month_issue,@year_issue,dbo.f_ConverToDate103(@salary_date))
set @id=@@IDENTITY

insert into hr_salary_employee (salary_id, employee_id)
	select @id, employee_id from hr_employee where status=1

insert into hr_salary_employee_wageparam(salary_employee_id, wageparam_id,nilai, total, tetap_sts, delete_restrict_sts)
	select salary_employee_id,wageparam_id, nilai,1,case when open_multiplier_sts=1 then 0 else 1 end,open_multiplier_sts 
	from hr_salary_employee
	inner join hr_employee_wageparam on hr_employee_wageparam.employee_id=hr_salary_employee.employee_id
	where hr_salary_employee.salary_id=@id

--insert from loan data
insert into hr_salary_employee_wageparam(salary_employee_id, wageparam_id,nilai, total, tetap_sts, delete_restrict_sts,note)
	select hr_salary_employee.salary_employee_id, hr_employee_loan.wageparam_id,hr_employee_loan.installment,1,1,1,
	'Cicilan '+cast(cast(hr_employee_loan.loan_amount as bigint) as varchar(20))+' ' + cast(hr_employee_loan_installment.ins_period as varchar(3))+'/'+cast(hr_employee_loan.tenor as varchar(3)) note
	from hr_salary_employee
	inner join hr_employee_loan on hr_employee_loan.employee_id=hr_salary_employee.employee_id 
		and hr_employee_loan.approve_sts=1 and hr_employee_loan.paidoff_sts=0
	inner join hr_employee_loan_installment on hr_employee_loan_installment.loan_id=hr_employee_loan.loan_id
	where hr_employee_loan_installment.ins_month=@month_issue and hr_employee_loan_installment.ins_year=@year_issue
		and hr_salary_employee.salary_id=@id
end
go