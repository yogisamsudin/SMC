/*
alter table exp_messanger add mobile_id varchar(10)
alter table exp_messanger add mobile_password varchar(50)
go

ALTER proc [dbo].[exp_messanger_add]
@messanger_name varchar(25),
@active_sts bit,
@mobile_id varchar(10),
@mobile_password varchar(50)
as begin
set transaction isolation level read committed
insert into exp_messanger(messanger_name,active_sts, mobile_id, mobile_password)
	values(@messanger_name,@active_sts,@mobile_id,@mobile_password)
end
go

ALTER proc [dbo].[exp_messanger_edit]
@messanger_id smallint,
@messanger_name varchar(25),
@active_sts bit,
@mobile_id varchar(10),
@mobile_password varchar(50)
as begin
set transaction isolation level read committed
update exp_messanger set messanger_name=@messanger_name, active_sts=@active_sts,
	mobile_id=@mobile_id, mobile_password=case when @mobile_password='' then mobile_password else @mobile_password end
	where messanger_id=@messanger_id
end
go

ALTER VIEW [dbo].[v_exp_messanger]
AS
SELECT messanger_id, messanger_name, active_sts, latitude, longitude, mobile_id, mobile_password
FROM   dbo.exp_messanger
GO

CREATE TABLE [dbo].[exp_messanger_geotag](
	[geotag_id] [bigint] IDENTITY(1,1) NOT NULL,
	[messanger_id] [int] NOT NULL,
	[ping_date] [bigint] NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
 CONSTRAINT [PK_exp_messanger_geotag] PRIMARY KEY CLUSTERED 
(
	[geotag_id] ASC
)
) ON [PRIMARY]
GO

create proc exp_messanger_geotag_add
@messanger_id int,
@ping_date bigint,
@latitude float,
@longitude float
as begin
insert into exp_messanger_geotag(messanger_id, ping_date, latitude, longitude)values(
@messanger_id,@ping_date,@latitude,@longitude)
end
go

alter table appuser add mobile_admin_sts bit
go
update appuser set mobile_admin_sts=1 where UserID='sa'
go

ALTER VIEW [dbo].[v_appuser]
AS
SELECT        dbo.appUser.UserID, dbo.appUser.UserName, dbo.appUser.Sandi, dbo.appUser.ctrSandi, dbo.appUser.Active, dbo.appUser.GroupID, dbo.appGroup.GroupName, 
                         dbo.appUser.Branch_id, dbo.par_branch.branch_name, dbo.appUser.mobile_admin_sts
FROM            dbo.appGroup INNER JOIN
                         dbo.appUser ON dbo.appGroup.GroupId = dbo.appUser.GroupID LEFT OUTER JOIN
                         dbo.par_branch ON dbo.appUser.Branch_id = dbo.par_branch.branch_id
GO

*/

