USE [TEST4]
drop table tec_onsite
GO

insert into appCommonParameter(code, Keterangan,type)values('1','Sales','onsitedevicests'),('2','Service','onsitedevicests')

CREATE TABLE [dbo].[tec_onsite](
	[onsite_id] [bigint] IDENTITY(1,1) NOT NULL,
	[onsite_no] [varchar](20) NULL,
	[customer_id] [int] NOT NULL,
	[an_id] [int] NOT NULL,
	[onsite_date] [date] NULL,
	[onsite_date2] [date] NULL,
	[request_date] [date] NOT NULL,
	[technician_name] [varchar](25) NULL,
	[done_date] [date] NULL,
	[note] [text] NULL,
	[onsitests_id] [varchar](1) NOT NULL,
	[marketing_id] [varchar](25) NOT NULL,
 CONSTRAINT [PK_tec_onsite] PRIMARY KEY CLUSTERED 
(
	[onsite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tec_onsite_workorders](
	[workorder_id] [bigint] IDENTITY(1,1) NOT NULL,
	[onsite_id] [bigint] NOT NULL,
	[device_id] [int] NOT NULL,
	[sn] [varchar](50) NOT NULL,
	[note] [text] NOT NULL,
	[complient_note] [text] NOT NULL,
	[onsitedevicests_id] [varchar](1) NOT NULL,
	[segeldate] [date] NULL
 CONSTRAINT [PK_onsite_complients] PRIMARY KEY CLUSTERED 
(
	[workorder_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

create TABLE [dbo].[tec_onsite_workorders_parts](
	[workorder_id] [bigint] NOT NULL,
	[part_id] [int] NOT NULL,
	[total] [int] NOT NULL,
 CONSTRAINT [PK_tec_onsite_workorders_parts] PRIMARY KEY CLUSTERED 
(
	[workorder_id] ASC,
	[part_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER VIEW [dbo].[v_tec_onsite]
AS
SELECT dbo.tec_onsite.onsite_id, dbo.tec_onsite.onsite_no, dbo.tec_onsite.onsite_date, dbo.tec_onsite.request_date, dbo.tec_onsite.technician_name, dbo.tec_onsite.done_date, dbo.tec_onsite.Note, dbo.tec_onsite.onsitests_id,
	v_act_customer.customer_name, dbo.tec_onsite.customer_id, v_act_customer.marketing_id, dbo.v_act_customer.customer_address, dbo.v_act_customer.customer_address_location,
	dbo.appCommonParameter.Keterangan onsitests, dbo.tec_onsite.an_id, dbo.act_customer_contact.contact_name,
	dbo.tec_onsite.onsite_date2,case when exists(select 'x' from tec_onsite_workorders where tec_onsite_workorders.onsite_id = dbo.tec_onsite.onsite_id) then 'Ya' else 'None' end workorder_sts
FROM   dbo.tec_onsite 
			 INNER JOIN  dbo.v_act_customer ON dbo.tec_onsite.customer_id = dbo.v_act_customer.customer_id
			 inner join dbo.appCommonParameter on dbo.appCommonParameter.code = dbo.tec_onsite.onsitests_id and dbo.appCommonParameter.type='onsitests'
			 inner join dbo.act_customer_contact on act_customer_contact.contact_id=dbo.tec_onsite.an_id
GO


create VIEW [dbo].[v_tec_onsite_workorders]
AS
SELECT workorder_id, onsite_id, dbo.tec_onsite_workorders.device_id, sn, note, complient_note, dbo.tec_device.device, 
dbo.tec_onsite_workorders.segeldate,dbo.tec_onsite_workorders.onsitedevicests_id, par.Keterangan onsitedevicests
FROM   dbo.tec_onsite_workorders
inner join dbo.tec_device on dbo.tec_device.device_id=dbo.tec_onsite_workorders.device_id
inner join appCommonParameter par on par.Code = dbo.tec_onsite_workorders.onsitedevicests_id and par.type='onsitedevicests'
GO

ALTER proc [dbo].[tec_onsite_add]
@customer_id int,
@an_id int,
@note text,
@user_id varchar(25),
@ret bigint out
as begin
declare @onsite_no varchar(50),@marketing_id varchar(15), @req_date date

set @req_date=GETDATE()

select @marketing_id=marketing_id from act_marketing where [user_id]=@user_id
if @@ROWCOUNT>0
	begin
	insert into tec_onsite(customer_id,request_date,note, onsitests_id, marketing_id, an_id)
		values(@customer_id,@req_date,@note, '1', @marketing_id, @an_id)
	set @ret=@@IDENTITY

	update tec_onsite set onsite_no = dbo.f_set_receipt_number(@ret,@req_date,'onsitecode','SMC') where onsite_id=@ret
	end
else
	set @ret=0
end
go

if  not exists(select 'x' from appParameter where kode='onsitecode')
	insert into appParameter(kode, nilai, Keterangan,field_type_id)values('onsitecode','OT','Kode Onsite','C')
go

ALTER proc [dbo].[tec_onsite_edit1]
@onsite_id bigint,
@note text,
@onsitests_id varchar(1)
as begin
update tec_onsite set note=@note, onsitests_id=@onsitests_id where onsite_id=@onsite_id
end
go

ALTER proc [dbo].[tec_onsite_edit2]
@onsite_id bigint,
@note text,
@onsite_date varchar(10),
@onsite_date2 varchar(10),
@technician_name varchar(50),
@done_sts bit
as begin
declare @onsitests_id varchar(2)
set @onsitests_id=case when @done_sts=1 then '4' else '3' end

update tec_onsite set note=@note, onsite_date=dbo.f_ConverToDate103(@onsite_date), 
	onsite_date2=dbo.f_ConverToDate103(@onsite_date2), technician_name=@technician_name,
	onsitests_id=@onsitests_id, done_date=  case when  @onsitests_id='4' then GETDATE() else null end 
	where onsite_id=@onsite_id
end
go

create proc tec_onsite_workorders_add
@onsite_id bigint,
@device_id int,
@sn varchar(50),
@note text,
@complient_note text,
@onsitedevicests_id varchar(1),
@segeldate varchar(10),
@ret bigint out
as begin
insert into tec_onsite_workorders(onsite_id,device_id, sn, note, complient_note, onsitedevicests_id, segeldate)values(@onsite_id,@device_id,@sn,@note,@complient_note,@onsitedevicests_id, dbo.f_ConverToDate103( @segeldate))
set @ret=@@IDENTITY
end
go

create proc tec_onsite_workorders_edit
@workorder_id bigint,
@device_id int,
@sn varchar(50),
@note text,
@complient_note text,
@onsitedevicests_id varchar(1),
@segeldate varchar(10)
as begin
update tec_onsite_workorders set device_id=@device_id, sn=@sn, note=@note, complient_note=@complient_note, segeldate=dbo.f_ConverToDate103(@segeldate),
	onsitedevicests_id=@onsitedevicests_id
	where workorder_id=@workorder_id
end
go

create proc tec_onsite_workorders_delete
@workorder_id bigint
as begin
delete tec_onsite_workorders_parts where workorder_id=@workorder_id
delete tec_onsite_workorders where workorder_id=@workorder_id
end
go

create VIEW [dbo].[v_tec_onsite_workorders_parts]
AS
SELECT dbo.tec_onsite_workorders_parts.workorder_id, dbo.tec_onsite_workorders_parts.part_id, dbo.tec_onsite_workorders_parts.total, dbo.tec_device.device AS part
FROM   dbo.tec_onsite_workorders_parts INNER JOIN
             dbo.tec_device ON dbo.tec_onsite_workorders_parts.part_id = dbo.tec_device.device_id
GO


create proc tec_onsite_workorders_parts_add
@workorder_id bigint,
@part_id int,
@total int
as begin
select 'x' from tec_onsite_workorders_parts where workorder_id=@workorder_id and part_id=@part_id
if @@ROWCOUNT=0
	insert into tec_onsite_workorders_parts(workorder_id,part_id,total)values(@workorder_id, @part_id,@total)
end
go

create proc tec_onsite_workorders_parts_edit
@workorder_id bigint,
@part_id int,
@total int
as begin
update tec_onsite_workorders_parts set total=@total where workorder_id=@workorder_id and part_id=@part_id
end
go

create proc tec_onsite_workorders_parts_delete
@workorder_id bigint,
@part_id int
as begin
delete tec_onsite_workorders_parts where workorder_id=@workorder_id and part_id=@part_id
end
go
