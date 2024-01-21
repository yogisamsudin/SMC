<%@ WebHandler Language="C#" Class="_gridlist" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using _test;

public class _gridlist : IHttpHandler
{
    public struct s_data
    {
        public double service_device_id;
        public string date_in, sn, device, customer_name, branch_name;
        public Boolean guarantee_sts, inventory_sts;

        public s_data(double _service_device_id, string _date_in, string _sn, string _device, string _customer_name, string _branch_name,
            Boolean _guarantee_sts, Boolean _inventory_sts)
        {
            service_device_id = _service_device_id;
            date_in = _date_in;
            sn = _sn;
            device = _device;
            customer_name = _customer_name;
            branch_name = _branch_name;
            guarantee_sts = _guarantee_sts;
            inventory_sts = _inventory_sts;
        }
    }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request.QueryString["kode"] == null) return;

        switch (context.Request.QueryString["kode"].ToString())
        {
            case "service_device":
                List<s_data> arr = new List<s_data>();
                

                _DBcon c = new _DBcon();
                foreach (System.Data.DataRow row in c.executeProcQ("xmlgrid_service_device", new _DBcon.sComParameter[]{             
                    new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,context.Request.QueryString["sn"].ToString()),
                    new _DBcon.sComParameter("@status",System.Data.SqlDbType.Char,1,context.Request.QueryString["status"].ToString()),
                    new _DBcon.sComParameter("@name",System.Data.SqlDbType.VarChar,50,context.Request.QueryString["name"].ToString()),
                    new _DBcon.sComParameter("@status_opr",System.Data.SqlDbType.Char,1,context.Request.QueryString["status_opr"].ToString()),
                    new _DBcon.sComParameter("@status_send",System.Data.SqlDbType.Char,1,context.Request.QueryString["status_send"].ToString()),
                    new _DBcon.sComParameter("@inventory",System.Data.SqlDbType.Char,1,context.Request.QueryString["inventory"].ToString()),
                    new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.VarChar,10,'%')
                }))
                {
                    arr.Add(new s_data(
                        Convert.ToInt64(row["service_device_id"]),row["date_in"].ToString(),row["sn"].ToString(),row["device"].ToString(),row["customer_name"].ToString(),row["branch_name"].ToString(),
                        Convert.ToBoolean(row["guarantee_sts"]), Convert.ToBoolean(row["inventory_sts"])    
                    ));
                }
                

                context.Response.Write(new JavaScriptSerializer().Serialize(arr));
                break;
        }


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}