select * from appCommonParameter where type='availability'
go
if @@ROWCOUNT=0
	insert into appCommonParameter(code,Keterangan,type)values('1','Ready','availability'),('2','Indenty','availability')
go

