ALTER proc [dbo].[act_marketing_group_add]
@marketing_group_name varchar(50),
@target_value money
as begin
if not exists(select 'x' from act_marketing_group where marketing_group_name=@marketing_group_name)
	insert into act_marketing_group(marketing_group_name, target_value)values(@marketing_group_name,@target_value)
end
go

ALTER proc [dbo].[act_marketing_group_edit]
@marketing_group_id int,
@marketing_group_name varchar(50),
@target_value money
as begin
update act_marketing_group set marketing_group_name=@marketing_group_name, target_value=@target_value where marketing_group_id=@marketing_group_id
end
go

ALTER VIEW [dbo].[v_act_marketing_group]
AS
SELECT        marketing_group_id, marketing_group_name, target_value
FROM            dbo.act_marketing_group
GO

