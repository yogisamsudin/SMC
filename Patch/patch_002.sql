/*
modul terupdate:
hr/employee.aspx
hr/employee_list.aspx
*/

CREATE TABLE [dbo].[hr_employee](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[nik] [varchar](10) NOT NULL,
	[employee_name] [varchar](150) NOT NULL,
	[date_in] [date] NOT NULL,
	[date_out] [date] NULL,
	[employee_position_id] [int] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_fin_employee] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hr_employee] ADD  CONSTRAINT [DF_fin_employee_status]  DEFAULT ((1)) FOR [status]
GO

CREATE TABLE [dbo].[hr_position](
	[employee_position_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_position_name] [varchar](50) NOT NULL,
	[delete_sts] [bit] NOT NULL,
 CONSTRAINT [PK_fin_employee_position] PRIMARY KEY CLUSTERED 
(
	[employee_position_id] ASC
)
) ON [PRIMARY]
GO


create TABLE [dbo].[hr_wageparam](
	[wageparam_id] [int] IDENTITY(1,1) NOT NULL,
	[wageparam_name] [varchar](50) NULL,
	type_id char(1),
	[delete_sts] [bit] NOT NULL,
 CONSTRAINT [PK_fin_wageparam] PRIMARY KEY CLUSTERED 
(
	[wageparam_id] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hr_wageparam] ADD  CONSTRAINT [DF_fin_wageparam_delete_sts]  DEFAULT ((0)) FOR [delete_sts]
GO


CREATE TABLE [dbo].[hr_employee_wageparam](
	[employeewageparam_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NOT NULL,
	[wageparam_id] [int] NOT NULL,
	[nilai] [money] NOT NULL,
	[delete_sts] [bit] NOT NULL,
 CONSTRAINT [PK_hr_employee_wageparam] PRIMARY KEY CLUSTERED 
(
	[employeewageparam_id] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hr_employee_wageparam] ADD  CONSTRAINT [DF_hr_employee_wageparam_delete_sts]  DEFAULT ((0)) FOR [delete_sts]
GO

CREATE TABLE [dbo].[hr_salary](
	[salary_id] [int] IDENTITY(1,1) NOT NULL,
	[salary_name] [varchar](100) NOT NULL,
	[month_issue] [smallint] NOT NULL,
	[year_issue] [int] NOT NULL,
	[salary_date] [date] NOT NULL,
 CONSTRAINT [PK_hr_salary] PRIMARY KEY CLUSTERED 
(
	[salary_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[hr_salary_employee](
	[salary_employee_id] [int] IDENTITY(1,1) NOT NULL,
	[salary_id] [int] NOT NULL,
	[employee_id] [int] NOT NULL,
 CONSTRAINT [PK_hr_salary_employee] PRIMARY KEY CLUSTERED 
(
	[salary_employee_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[hr_salary_employee_wageparam](
	[salary_employee_wageparam_id] [bigint] IDENTITY(1,1) NOT NULL,
	[salary_employee_id] [int] NOT NULL,
	[wageparam_id] [int] NOT NULL,
	[nilai] [money] NOT NULL,
	[total] [smallint] NOT NULL,
	[tetap_sts] [bit] NOT NULL,
 CONSTRAINT [PK_hr_salary_employee_wageparam] PRIMARY KEY CLUSTERED 
(
	[salary_employee_wageparam_id] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hr_salary_employee_wageparam] ADD  CONSTRAINT [DF_hr_salary_employee_wageparam_tetap_sts]  DEFAULT ((0)) FOR [tetap_sts]
GO



--view
create VIEW [dbo].[v_hr_position]
AS
SELECT        position_id, position_name
FROM            dbo.hr_position
where delete_sts=0
GO

CREATE VIEW [dbo].[v_hr_employee]
AS
SELECT        dbo.hr_employee.employee_id, dbo.hr_employee.nik, dbo.hr_employee.employee_name, dbo.hr_employee.date_in, dbo.hr_employee.date_out, dbo.hr_employee.position_id, dbo.hr_employee.status, 
                         dbo.hr_position.position_name
FROM            dbo.hr_employee INNER JOIN
                         dbo.hr_position ON dbo.hr_employee.position_id = dbo.hr_position.position_id
GO

insert into appCommonParameter(code, Keterangan, type)
values('1','Penambah','wageparamtype'),('2','Pengurang','wageparamtype')
go

create VIEW [dbo].[v_hr_wageparam]
AS
SELECT        wageparam_id, wageparam_name, type_id, dbo.appCommonParameter.Keterangan type_name
FROM            dbo.hr_wageparam
inner join dbo.appCommonParameter on dbo.appCommonParameter.Code=dbo.hr_wageparam.type_id and dbo.appCommonParameter.type='wageparamtype'
WHERE        (delete_sts = 0)
GO

create VIEW [dbo].[v_hr_employee_wageparam]
AS
SELECT        dbo.hr_employee_wageparam.employeewageparam_id, dbo.hr_employee_wageparam.employee_id, dbo.hr_employee_wageparam.wageparam_id, dbo.hr_employee_wageparam.nilai, dbo.hr_employee.employee_name, 
                         dbo.hr_wageparam.wageparam_name, dbo.hr_wageparam.type_id, dbo.appCommonParameter.Keterangan AS type_name
FROM            dbo.hr_employee_wageparam INNER JOIN
                         dbo.hr_employee ON dbo.hr_employee_wageparam.employee_id = dbo.hr_employee.employee_id INNER JOIN
                         dbo.hr_wageparam ON dbo.hr_employee_wageparam.wageparam_id = dbo.hr_wageparam.wageparam_id INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_wageparam.type_id = dbo.appCommonParameter.Code and dbo.appCommonParameter.type='wageparamtype'
WHERE        (dbo.hr_employee_wageparam.delete_sts = 0)
GO

CREATE VIEW [dbo].[v_hr_salary]
AS
SELECT        dbo.hr_salary.salary_id, dbo.hr_salary.salary_name, dbo.hr_salary.month_issue, dbo.hr_salary.year_issue, dbo.hr_salary.salary_date, dbo.appCommonParameter.Keterangan AS month_name
FROM            dbo.hr_salary INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_salary.month_issue = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'listmonth'
GO

CREATE VIEW [dbo].[v_hr_salary_employee]
AS
SELECT        dbo.hr_salary_employee.salary_employee_id, dbo.hr_salary_employee.salary_id, dbo.hr_salary_employee.employee_id, dbo.hr_employee.employee_name, dbo.hr_salary.salary_date,
isnull(dtl.total_salary,0)total_salary
FROM            dbo.hr_salary_employee INNER JOIN
                         dbo.hr_salary ON dbo.hr_salary_employee.salary_id = dbo.hr_salary.salary_id INNER JOIN
                         dbo.hr_employee ON dbo.hr_salary_employee.employee_id = dbo.hr_employee.employee_id
						 left join (
							select salary_employee_id,sum(case when type_id='1' then nilai else -nilai end *total)total_salary from hr_salary_employee_wageparam GROUP by salary_employee_id
						 )dtl on dtl.salary_employee_id=dbo.hr_salary_employee.salary_employee_id
GO

create VIEW [dbo].[v_hr_salary_employee_wageparam]
AS
SELECT        dbo.hr_salary_employee_wageparam.salary_employee_wageparam_id, dbo.hr_salary_employee_wageparam.salary_employee_id, dbo.hr_salary_employee_wageparam.wageparam_id, 
                         dbo.hr_salary_employee_wageparam.nilai, dbo.hr_salary_employee_wageparam.total, dbo.hr_salary_employee_wageparam.tetap_sts, dbo.hr_employee.employee_name, dbo.hr_salary.salary_name, 
                         dbo.hr_wageparam.wageparam_name, dbo.hr_wageparam.type_id, dbo.appCommonParameter.Keterangan AS type_name,dbo.hr_salary_employee.employee_id,
						 dbo.hr_salary_employee_wageparam.total*dbo.hr_salary_employee_wageparam.nilai total_nilai
FROM            dbo.hr_salary_employee_wageparam INNER JOIN
                         dbo.hr_salary_employee ON dbo.hr_salary_employee_wageparam.salary_employee_id = dbo.hr_salary_employee.salary_employee_id INNER JOIN
                         dbo.hr_salary ON dbo.hr_salary_employee.salary_id = dbo.hr_salary.salary_id INNER JOIN
                         dbo.hr_employee ON dbo.hr_salary_employee.employee_id = dbo.hr_employee.employee_id INNER JOIN
                         dbo.hr_wageparam ON dbo.hr_salary_employee_wageparam.wageparam_id = dbo.hr_wageparam.wageparam_id INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_wageparam.type_id = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'wageparamtype'
GO


--exec
create proc hr_position_add
@position_name varchar(50)
as begin
update hr_position set delete_sts=0 where position_name=@position_name
if @@rowcount=0
	insert into hr_position(position_name)values(@position_name)
end
go

create proc hr_position_edit
@position_id int,
@position_name varchar(50)
as begin
if not exists(select 'x' from hr_position where position_name=@position_name and position_id<>@position_id)
	update hr_position  set  position_name=@position_name where position_id=@position_id
end
go

create proc hr_position_delete
@position_id int
as begin
update hr_position  set  delete_sts=1 where position_id=@position_id
end
go

create proc hr_employee_add
@nik varchar(10),
@employee_name varchar(150),
@date_in varchar(10),
@date_out varchar(10),
@position_id int,
@status bit,
@id int out
as begin
insert into hr_employee(nik, employee_name, date_in, date_out, position_id, status)
values(@nik, @employee_name,dbo.f_ConverToDate103(@date_in),case when @date_out='' then null else dbo.f_ConverToDate103(@date_out) end,@position_id,@status)
set @id=@@IDENTITY
end
go

create proc hr_employee_edit
@employee_id int,
@nik varchar(10),
@employee_name varchar(150),
@date_in varchar(10),
@date_out varchar(10),
@position_id int,
@status bit
as begin
update hr_employee 
	set nik=@nik, employee_name=@employee_name, date_in=dbo.f_ConverToDate103(@date_in), 
	date_out=case when @date_out='' then null else dbo.f_ConverToDate103(@date_out) end, position_id=@position_id, status=@status
	where employee_id=@employee_id 
end
go




create proc hr_wageparam_add
@wageparam_name varchar(50),
@type_id char(1)
as begin
update hr_wageparam set delete_sts=0, type_id=@type_id where wageparam_name=@wageparam_name
if @@ROWCOUNT=0
	insert into hr_wageparam(wageparam_name, type_id)values(@wageparam_name,@type_id)
end
go

create proc hr_wageparam_edit
@wageparam_id int,
@wageparam_name varchar(50),
@type_id char(1)
as begin
if not exists(select 'x' from hr_wageparam where wageparam_name=@wageparam_name and wageparam_id<>@wageparam_id)
	update hr_wageparam set wageparam_name=@wageparam_name, type_id=@type_id where wageparam_id=@wageparam_id
end
go

create proc hr_wageparam_delete
@wageparam_id int
as begin
update hr_wageparam set delete_sts=1 where wageparam_id=@wageparam_id
end
go

create proc hr_employee_wageparam_add
@employee_id int,
@wageparam_id int,
@nilai money
as begin
update hr_employee_wageparam set nilai=@nilai,delete_sts=0 where employee_id=@employee_id and wageparam_id=@wageparam_id
if @@ROWCOUNT=0
	insert into hr_employee_wageparam(employee_id, wageparam_id, nilai)values(@employee_id,@wageparam_id,@nilai)
end
go

create proc hr_employee_wageparam_edit
@employeewageparam_id  int,
@nilai money
as begin
update hr_employee_wageparam set nilai=@nilai where employeewageparam_id =@employeewageparam_id 
end
go

create proc hr_employee_wageparam_delete
@employeewageparam_id  int
as begin
update hr_employee_wageparam set delete_sts=1 where employeewageparam_id =@employeewageparam_id 
end
go

create proc hr_salary_add
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

insert into hr_salary_employee_wageparam(salary_employee_id, wageparam_id,nilai, total, tetap_sts)
	select salary_employee_id,wageparam_id, nilai,1,1 from hr_salary_employee
	inner join hr_employee_wageparam on hr_employee_wageparam.employee_id=hr_salary_employee.employee_id
	where hr_salary_employee.salary_id=@id
end
go

create proc hr_salary_edit
@salary_id int,
@salary_name varchar(100),
@month_issue smallint,
@year_issue int,
@salary_date varchar(10)
as begin
update hr_salary set salary_name=@salary_name, 
	month_issue=@month_issue, year_issue=@year_issue, salary_date=dbo.f_ConverToDate103(@salary_date)
	where salary_id=@salary_id

end
go

create proc hr_salary_delete
@salary_id int
as begin
delete hr_salary_employee_wageparam where salary_employee_id in (select salary_employee_id from hr_salary_employee where salary_id=@salary_id)
delete hr_salary_employee where salary_id=@salary_id
delete hr_salary where salary_id=@salary_id
end
go

create proc hr_salary_employee_wageparam_add
@salaray_employee_id int,
@wageparam_id int,
@nilai money,
@total int
as begin
insert into hr_salary_employee_wageparam(salary_employee_id, wageparam_id, nilai,total,tetap_sts)
	values(@salaray_employee_id,@wageparam_id,@nilai,@total,0)
end
go

create proc hr_salary_employee_wageparam_edit
@salary_employee_wageparam_id int,
@nilai money,
@total int
as begin
update hr_salary_employee_wageparam set nilai=@nilai,total=@total where salary_employee_wageparam_id=@salary_employee_wageparam_id
end
go

create proc hr_salary_employee_wageparam_delete
@salary_employee_wageparam_id int
as begin
delete hr_salary_employee_wageparam where salary_employee_wageparam_id=@salary_employee_wageparam_id
end
go