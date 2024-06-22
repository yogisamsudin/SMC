CREATE TABLE [dbo].[hr_nonsalary](
	[nonsalary_id] [int] IDENTITY(1,1) NOT NULL,
	[nonsalary_name] [varchar](100) NOT NULL,
	[month_issue] [int] NOT NULL,
	[year_issue] [int] NOT NULL,
	[nonsalary_date] [date] NOT NULL,
 CONSTRAINT [PK_hr_nonsalary] PRIMARY KEY CLUSTERED 
(
	[nonsalary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[hr_nonsalary_employee](
	[nonsalary_employee_id] [int] IDENTITY(1,1) NOT NULL,
	[nonsalary_id] [int] NOT NULL,
	[employee_id] [int] NOT NULL,
 CONSTRAINT [PK_hr_nonsalary_employee] PRIMARY KEY CLUSTERED 
(
	[nonsalary_employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[hr_nonsalary_employee_wageparam](
	[nonsalary_employee_wageparam_id] [int] IDENTITY(1,1) NOT NULL,
	[nonsalary_employee_id] [int] NOT NULL,
	[wageparam_id] [int] NOT NULL,
	[nilai] [money] NOT NULL,
	[total] [int] NOT NULL,
	[note] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



CREATE VIEW [dbo].[v_hr_nonsalary]
AS
SELECT dbo.hr_nonsalary.nonsalary_id, dbo.hr_nonsalary.nonsalary_name, dbo.hr_nonsalary.month_issue, dbo.hr_nonsalary.year_issue, dbo.hr_nonsalary.nonsalary_date, dbo.appCommonParameter.Keterangan AS month_issue_name
FROM   dbo.hr_nonsalary INNER JOIN
             dbo.appCommonParameter ON dbo.hr_nonsalary.month_issue = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'listmonth'
GO

create proc hr_nonsalary_add
@nonsalary_name varchar(100),
@month_issue int,
@year_issue int,
@nonsalary_date varchar(10),
@id int out
as begin
insert into hr_nonsalary (nonsalary_name,month_issue,year_issue,nonsalary_date)
	values(@nonsalary_name,@month_issue,@year_issue,dbo.f_ConverToDate103(@nonsalary_date))

set @id=@@IDENTITY
end
go

create proc hr_nonsalary_edit
@nonsalary_id int,
@nonsalary_name varchar(100),
@month_issue int,
@year_issue int,
@nonsalary_date varchar(10)

as begin
update hr_nonsalary set nonsalary_name=@nonsalary_name,month_issue=@month_issue,year_issue=@year_issue,
	nonsalary_date=dbo.f_ConverToDate103(@nonsalary_date)
		where nonsalary_id=@nonsalary_id
end
go

create proc hr_nonsalary_delete
@nonsalary_id int

as begin
delete hr_nonsalary_employee_wageparam where nonsalary_employee_id in (select nonsalary_employee_id from hr_nonsalary_employee where nonsalary_id=@nonsalary_id)
delete hr_nonsalary_employee where nonsalary_id=@nonsalary_id
delete hr_nonsalary where nonsalary_id=@nonsalary_id
end
go

create VIEW [dbo].[v_hr_nonsalary_employee]
AS
SELECT dbo.hr_nonsalary_employee.nonsalary_employee_id, dbo.hr_nonsalary_employee.nonsalary_id, dbo.hr_nonsalary_employee.employee_id, dbo.hr_employee.employee_name, isnull(total_salary,0) total_salary
FROM   dbo.hr_nonsalary_employee INNER JOIN
             dbo.hr_employee ON dbo.hr_nonsalary_employee.employee_id = dbo.hr_employee.employee_id
			 left join (
			 select nonsalary_employee_id,sum(total*nilai)total_salary from hr_nonsalary_employee_wageparam
			 group by nonsalary_employee_id
			 )d on d.nonsalary_employee_id=dbo.hr_nonsalary_employee.nonsalary_employee_id
GO

create proc hr_nonsalary_employee_add
@nonsalary_id int,
@employee_id int,
@id int out
as begin
select @id=nonsalary_employee_id from hr_nonsalary_employee where nonsalary_id=@nonsalary_id and employee_id=@employee_id
if @@ROWCOUNT=0
	begin
	insert into hr_nonsalary_employee(nonsalary_id,employee_id)values(@nonsalary_id,@employee_id)
	set @id=@@IDENTITY
	end
end
go

create proc hr_nonsalary_employee_delete
@nonsalary_employee_id int
as begin
delete hr_nonsalary_employee_wageparam where  nonsalary_employee_id=@nonsalary_employee_id
delete hr_nonsalary_employee where nonsalary_employee_id=@nonsalary_employee_id
end
go

create VIEW [dbo].[v_hr_nonsalary_employee_wageparam]
AS
SELECT dbo.hr_nonsalary_employee_wageparam.nonsalary_employee_wageparam_id, dbo.hr_nonsalary_employee_wageparam.nonsalary_employee_id, dbo.hr_nonsalary_employee_wageparam.wageparam_id, dbo.hr_nonsalary_employee_wageparam.nilai, 
             dbo.hr_nonsalary_employee_wageparam.total, dbo.hr_nonsalary_employee_wageparam.note, dbo.hr_wageparam.wageparam_name, dbo.hr_wageparam.[type_id], dbo.hr_employee.employee_name, dbo.appCommonParameter.keterangan as [type_name],
			 dbo.hr_nonsalary_employee_wageparam.total*dbo.hr_nonsalary_employee_wageparam.nilai as total_nilai 
FROM   dbo.hr_nonsalary_employee_wageparam INNER JOIN
             dbo.hr_wageparam ON dbo.hr_nonsalary_employee_wageparam.wageparam_id = dbo.hr_wageparam.wageparam_id INNER JOIN
             dbo.hr_nonsalary_employee ON dbo.hr_nonsalary_employee_wageparam.nonsalary_employee_id = dbo.hr_nonsalary_employee.nonsalary_employee_id INNER JOIN
             dbo.hr_employee ON dbo.hr_nonsalary_employee.employee_id = dbo.hr_employee.employee_id
			 inner join dbo.appCommonParameter on dbo.hr_wageparam.[type_id]=dbo.appCommonParameter.code and dbo.appCommonParameter.Type='wageparamtype'
GO

create proc hr_nonsalary_employee_wageparam_add
@nonsalary_employee_id int,
@wageparam_id int,
@total int,
@nilai money,
@note text
as begin
if not exists(select 'x' from hr_nonsalary_employee_wageparam where nonsalary_employee_id=@nonsalary_employee_id and wageparam_id=@wageparam_id)
	insert into hr_nonsalary_employee_wageparam(nonsalary_employee_id, wageparam_id, nilai, total, note)
		values(@nonsalary_employee_id,@wageparam_id,@nilai,@total,@note)
end
go

create proc hr_nonsalary_employee_wageparam_edit
@nonsalary_employee_wageparam_id int,
@total int,
@nilai money,
@note text
as begin
update hr_nonsalary_employee_wageparam set nilai=@nilai, total=@total, note=@note where nonsalary_employee_wageparam_id=@nonsalary_employee_wageparam_id
end
go

create proc hr_nonsalary_employee_wageparam_delete
@nonsalary_employee_wageparam_id int
as begin
delete hr_nonsalary_employee_wageparam  where nonsalary_employee_wageparam_id=@nonsalary_employee_wageparam_id
end
go