--update messanger location

ALTER VIEW [dbo].[v_exp_messanger]
AS
SELECT dbo.exp_messanger.messanger_id, dbo.exp_messanger.messanger_name, dbo.exp_messanger.active_sts, dbo.exp_messanger.mobile_id, dbo.exp_messanger.mobile_password, dbo.exp_messanger_geotag.latitude, dbo.exp_messanger_geotag.longitude, 
             dbo.exp_messanger_geotag.ping_date
FROM   dbo.exp_messanger LEFT OUTER JOIN
             dbo.exp_messanger_geotag ON dbo.exp_messanger.geotag_id = dbo.exp_messanger_geotag.geotag_id
GO

ALTER VIEW [dbo].[v_exp_messanger_geotag]
AS
SELECT dbo.exp_messanger_geotag.geotag_id, dbo.exp_messanger_geotag.messanger_id, dbo.exp_messanger_geotag.ping_date, dbo.exp_messanger_geotag.latitude, dbo.exp_messanger_geotag.longitude, dbo.exp_messanger.messanger_name,
CONVERT(varchar, dbo.exp_messanger_geotag.ping_date,8)ping_time
FROM   dbo.exp_messanger_geotag INNER JOIN
             dbo.exp_messanger ON dbo.exp_messanger_geotag.messanger_id = dbo.exp_messanger.messanger_id
GO


