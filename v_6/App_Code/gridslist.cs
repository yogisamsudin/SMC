using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using _test;

/// <summary>
/// Summary description for gridslist
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class gridslist : System.Web.Services.WebService {

    public gridslist () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    public struct s_service_device
    {
        public double service_device_id; 
        public string date_in, sn, device,customer_name;
        public Boolean guarantee_sts, inventory_sts;

        public s_service_device(double _service_device_id, string _date_in, string _sn,string _device, string _customer_name,Boolean _guarantee_sts, Boolean _inventory_sts)
        {
            service_device_id = _service_device_id;
            date_in = _date_in;
            sn = _sn;
            device = _device;
            customer_name = _customer_name;
            guarantee_sts = _guarantee_sts;
            inventory_sts = _inventory_sts;
        }
    }
    [WebMethod]
    public s_service_device[] xml_service_device_list(string sn, string status, string name, string status_opr, string status_send, string inventory, string branch_id)
    {
        List<s_service_device> data = new List<s_service_device>();

         _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_service_device_list", new _DBcon.sComParameter[]{
            new _DBcon.sComParameter("@sn",System.Data.SqlDbType.VarChar,50,sn),
            new _DBcon.sComParameter("@status",System.Data.SqlDbType.Char,1,status),
            new _DBcon.sComParameter("@name",System.Data.SqlDbType.VarChar,50,name),
            new _DBcon.sComParameter("@status_opr",System.Data.SqlDbType.Char,1,status_opr),
            new _DBcon.sComParameter("@status_send",System.Data.SqlDbType.Char,1,status_send),
            new _DBcon.sComParameter("@inventory",System.Data.SqlDbType.Char,1,inventory),
            new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.VarChar,10,branch_id)
        }))
        {
            data.Add(new s_service_device(
                Convert.ToInt64(row["service_device_id"]), row["date_in"].ToString(), row["sn"].ToString(), row["device"].ToString(), row["customer_name"].ToString(), 
                Convert.ToBoolean( row["guarantee_sts"]), Convert.ToBoolean(row["inventory_sts"])
                ));
        }
        return data.ToArray();
    }
    
    
}
