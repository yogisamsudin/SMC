alter table dbo.hr_employee_wageparam add open_multiplier_sts bit
go

update hr_employee_wageparam set open_multiplier_sts=0
go

alter table dbo.hr_salary_employee_wageparam add delete_restrict_sts  bit
go

alter table dbo.hr_salary_employee_wageparam add note  text
go

update hr_salary_employee_wageparam set delete_restrict_sts=0
go



update dbo.hr_salary_employee_wageparam set delete_restrict_sts=0
go

ALTER VIEW [dbo].[v_hr_employee_wageparam]
AS
SELECT        dbo.hr_employee_wageparam.employeewageparam_id, dbo.hr_employee_wageparam.employee_id, dbo.hr_employee_wageparam.wageparam_id, dbo.hr_employee_wageparam.nilai, dbo.hr_employee.employee_name, 
                         dbo.hr_wageparam.wageparam_name, dbo.hr_wageparam.[type_id], dbo.appCommonParameter.Keterangan AS [type_name], dbo.hr_employee_wageparam.open_multiplier_sts
FROM            dbo.hr_employee_wageparam INNER JOIN
                         dbo.hr_employee ON dbo.hr_employee_wageparam.employee_id = dbo.hr_employee.employee_id INNER JOIN
                         dbo.hr_wageparam ON dbo.hr_employee_wageparam.wageparam_id = dbo.hr_wageparam.wageparam_id INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_wageparam.[type_id] = dbo.appCommonParameter.Code AND dbo.appCommonParameter.Type = 'wageparamtype'
WHERE        (dbo.hr_employee_wageparam.delete_sts = 0)
GO

ALTER proc [dbo].[hr_employee_wageparam_add]
@employee_id int,
@wageparam_id int,
@nilai money,
@open_multiplier_sts bit
as begin
update hr_employee_wageparam set nilai=@nilai,delete_sts=0 where employee_id=@employee_id and wageparam_id=@wageparam_id
if @@ROWCOUNT=0
	insert into hr_employee_wageparam(employee_id, wageparam_id, nilai, open_multiplier_sts)values(@employee_id,@wageparam_id,@nilai,@open_multiplier_sts)
end
GO

ALTER VIEW [dbo].[v_hr_salary_employee_wageparam]
AS
SELECT        dbo.hr_salary_employee_wageparam.salary_employee_wageparam_id, dbo.hr_salary_employee_wageparam.salary_employee_id, dbo.hr_salary_employee_wageparam.wageparam_id, 
                         dbo.hr_salary_employee_wageparam.nilai, dbo.hr_salary_employee_wageparam.total, dbo.hr_salary_employee_wageparam.tetap_sts, dbo.hr_employee.employee_name, dbo.hr_salary.salary_name, 
                         dbo.hr_wageparam.wageparam_name, dbo.hr_wageparam.[type_id], dbo.appCommonParameter.Keterangan AS [type_name],dbo.hr_salary_employee.employee_id,
						 dbo.hr_salary_employee_wageparam.total*dbo.hr_salary_employee_wageparam.nilai total_nilai, dbo.hr_salary_employee_wageparam.delete_restrict_sts,
						 dbo.hr_salary_employee_wageparam.note
FROM            dbo.hr_salary_employee_wageparam INNER JOIN
                         dbo.hr_salary_employee ON dbo.hr_salary_employee_wageparam.salary_employee_id = dbo.hr_salary_employee.salary_employee_id INNER JOIN
                         dbo.hr_salary ON dbo.hr_salary_employee.salary_id = dbo.hr_salary.salary_id INNER JOIN
                         dbo.hr_employee ON dbo.hr_salary_employee.employee_id = dbo.hr_employee.employee_id INNER JOIN
                         dbo.hr_wageparam ON dbo.hr_salary_employee_wageparam.wageparam_id = dbo.hr_wageparam.wageparam_id INNER JOIN
                         dbo.appCommonParameter ON dbo.hr_wageparam.[type_id] = dbo.appCommonParameter.Code AND dbo.appCommonParameter.[Type] = 'wageparamtype'
GO



ALTER proc [dbo].[hr_employee_wageparam_edit]
@employeewageparam_id  int,
@nilai money,
@open_multiplier_sts bit
as begin
update hr_employee_wageparam set nilai=@nilai,open_multiplier_sts=@open_multiplier_sts where employeewageparam_id =@employeewageparam_id 
end
GO

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
	select salary_employee_id,wageparam_id, nilai,1,case when open_multiplier_sts=1 then 0 else 1 end,open_multiplier_sts from hr_salary_employee
	inner join hr_employee_wageparam on hr_employee_wageparam.employee_id=hr_salary_employee.employee_id
	where hr_salary_employee.salary_id=@id
end
go

ALTER proc [dbo].[hr_salary_employee_wageparam_add]
@salaray_employee_id int,
@wageparam_id int,
@nilai money,
@total int,
@note text
as begin
insert into hr_salary_employee_wageparam(salary_employee_id, wageparam_id, nilai,total,tetap_sts,delete_restrict_sts, note)
	values(@salaray_employee_id,@wageparam_id,@nilai,@total,0,0,@note)
end
go

ALTER proc [dbo].[hr_salary_employee_wageparam_edit]
@salary_employee_wageparam_id int,
@nilai money,
@total int,
@note text
as begin
update hr_salary_employee_wageparam set nilai=@nilai,total=@total,note=@note where salary_employee_wageparam_id=@salary_employee_wageparam_id
end
GO
