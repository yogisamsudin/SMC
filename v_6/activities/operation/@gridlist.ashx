<%@ WebHandler Language="C#" Class="_gridlist" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using _test;

public class _gridlist : IHttpHandler
{
    public struct s_tec_service_device_component
    {
        public string sn, device, customer_name,component;
        public int total, service_device_id, device_id;
        public long service_id;
        
        public s_tec_service_device_component(string _sn, string _device, string _customer_name, string _component, int _total, int _service_device_id, int _device_id, long _service_id)
        {
            sn = _sn;            
            device = _device;
            customer_name = _customer_name;
            component = _component;
            total = _total;
            service_device_id = _service_device_id;
            device_id = _device_id;
            service_id = _service_id;
        }
    }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request.QueryString["kode"] == null) return;

        switch (context.Request.QueryString["kode"].ToString())
        {
            case "service_device_component":
                List<s_tec_service_device_component> arr = new List<s_tec_service_device_component>();
                

                _DBcon c = new _DBcon();
                foreach (System.Data.DataRow row in c.executeProcQ("xmlgrid_service_device_component", new _DBcon.sComParameter[]{             
                    new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,context.Request.QueryString["sn"].ToString()),
                    new _DBcon.sComParameter("@customer_name",System.Data.SqlDbType.VarChar,50,context.Request.QueryString["custname"].ToString())
                }))
                {
                    arr.Add(new s_tec_service_device_component(
                        row["sn"].ToString(), row["device"].ToString(), row["customer_name"].ToString(), row["component"].ToString(),
                        Convert.ToInt32(row["total"]), Convert.ToInt32(row["service_device_id"]), Convert.ToInt32(row["device_id"]),
                        Convert.ToInt64(row["service_id"])
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