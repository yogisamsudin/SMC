
alter proc xmlgrid_service_device
@sn varchar(50),
@status char(1) = '%',
@name varchar(50),
@status_opr char(1) = '%',
@status_send char(1) = '%',
@inventory char(1) = '%',
@branch_id varchar(10) = '%'
as begin
set nocount on
select top 1000 service_device_id, convert(varchar(10),date_in,111)date_in, sn, device,
	guarantee_sts,customer_name, case when last_inventory_id=0 then 0 else 1 end inventory_sts,
	branch_name 
from v_tec_service_device where sn like @sn and service_device_sts_id like @status and customer_name like @name
	and isnull(service_status_id,' ') like @status_opr and send_sts like @status_send and case when last_inventory_id=0 then '0' else '1' end like @inventory and
	branch_id like @branch_id
for xml auto,xmldata
--print @status+':'+@status_opr
end