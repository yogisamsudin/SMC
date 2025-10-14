<%@ WebHandler Language="C#" Class="_gridcustomer" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using _test;

public class _gridcustomer : IHttpHandler {
    public struct s_data
    {
        public double customer_id;
        public string customer_name, customer_phone, marketing_id, alt_code;

        public s_data(double _customer_id, string _customer_name, string _customer_phone, string _marketing_id, string _alt_code)
        {
            customer_id = _customer_id;
            customer_name = _customer_name;
            customer_phone = _customer_phone;
            marketing_id = _marketing_id;
            alt_code = _alt_code;
        }
    }
    public struct s_customer_contact
    {
        public int contact_id, customer_id;
        public string contact_name, contact_phone, customer_name;

        public s_customer_contact(int _contact_id, int _customer_id, string _contact_name, string _contact_phone, string _customer_name)
        {
            contact_id = _contact_id;
            customer_id = _customer_id;
            contact_name = _contact_name;
            contact_phone = _contact_phone;
            customer_name = _customer_name;

        }
    }
    public struct s_customer2
    {
        public int customer_id, distance, customer_address_location_id, group_customer_id, branch_id;
        public string customer_name, customer_address, customer_phone, customer_fax, customer_email, marketing_id, customer_address_location, group_customer, npwp, latitude, longitude, branch_name;
        public Boolean user_device_mandatory;
        public string tkuid, jenisidpembeli_id, jenisidpembeli_name, alt_code;
        public s_customer_contact[] arr_contact;

        public s_customer2(int _customer_id, int _distance, string _customer_name, string _customer_address, string _customer_phone, string _customer_fax, string _customer_email, string _marketing_id,
            int _customer_address_location_id, string _customer_address_location,
            int _group_customer_id, string _group_customer, string _npwp = "", string _latitude = "", string _longitude = "",
            int _branch_id = 0, string _branch_name = "",
            Boolean _user_device_mandatory = false,
            string _tkuid = "", string _jenisidpembeli_id = "", string _jenisidpembeli_name = "",
            string _alt_code = "", s_customer_contact[] _arr_contact = null)
        {
            customer_id = _customer_id;
            customer_name = _customer_name;
            customer_address = _customer_address;
            customer_phone = _customer_phone;
            customer_fax = _customer_fax;
            customer_email = _customer_email;
            distance = _distance;
            marketing_id = _marketing_id;
            customer_address_location_id = _customer_address_location_id;
            customer_address_location = _customer_address_location;
            group_customer_id = _group_customer_id;
            group_customer = _group_customer;
            npwp = _npwp;
            latitude = _latitude;
            longitude = _longitude;
            branch_id = _branch_id;
            branch_name = _branch_name;
            user_device_mandatory = _user_device_mandatory;
            tkuid = _tkuid;
            jenisidpembeli_id = _jenisidpembeli_id;
            jenisidpembeli_name = _jenisidpembeli_name;

            alt_code = _alt_code;
            arr_contact = _arr_contact;
        }
    }
    void generateArrCustomer(HttpContext context)
    {
        if (context.Request.QueryString["name"] == null) return;

        List<s_data> arr = new List<s_data>();
        string strSQL = "select top 10 customer_id, customer_name, customer_phone,marketing_id, alt_code from v_act_customer where alt_code like dbo.f_getAppParameterValue('altcode')+'%' and customer_name like '" + context.Request.QueryString["name"].ToString() + "'";
        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            arr.Add(
                new s_data(Convert.ToInt64(row["customer_id"]), row["customer_name"].ToString(), row["customer_phone"].ToString(), row["marketing_id"].ToString(), row["alt_code"].ToString())
            );
        }

        JavaScriptSerializer js = new JavaScriptSerializer();
        string jsonOutput = js.Serialize(arr);
        context.Response.Write(jsonOutput);
        //context.Response.Write(new JavaScriptSerializer().Serialize(arr));
        
    }
    s_customer_contact[] act_customer_contact_list(string customer_id)
    {
        List<s_customer_contact> data = new List<s_customer_contact>();

        string strSQL = "select contact_id, customer_id, contact_name,contact_phone, customer_name from v_act_customer_contact where customer_id=" + customer_id;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_customer_contact(Convert.ToInt32(row["contact_id"]), Convert.ToInt32(row["customer_id"]), row["contact_name"].ToString(), row["contact_phone"].ToString(), row["customer_name"].ToString()));
        }

        return data.ToArray();
    }
    void generateCustomerData(HttpContext context)
    {
        if (context.Request.QueryString["custid"] == null) return;
        s_customer2 data = new s_customer2();

        string strSQL = "select user_device_mandatory,npwp,customer_id, customer_name, customer_address, customer_phone,customer_fax,distance,marketing_id,customer_email,customer_address_location_id, customer_address_location,group_customer_id, group_customer, latitude, longitude, branch_id, branch_name, tkuid, jenisidpembeli_id, jenisidpembeli_name, alt_code from v_act_customer where customer_id=" + context.Request.QueryString["custid"].ToString();

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_customer2(Convert.ToInt32(row["customer_id"]), Convert.ToInt32(row["distance"]),
                        row["customer_name"].ToString(), row["customer_address"].ToString(), row["customer_phone"].ToString(), row["customer_fax"].ToString(), row["customer_email"].ToString(), row["marketing_id"].ToString(),
                        Convert.ToInt32(row["customer_address_location_id"]), row["customer_address_location"].ToString(),
                        Convert.ToInt32(row["group_customer_id"]), row["group_customer"].ToString(), row["npwp"].ToString(),
                        row["latitude"].ToString(), row["longitude"].ToString(),
                        Convert.ToInt32(row["branch_id"]), row["branch_name"].ToString(),
                        Convert.ToBoolean(row["user_device_mandatory"]),
                        row["tkuid"].ToString(), row["jenisidpembeli_id"].ToString(), row["jenisidpembeli_name"].ToString(),
                        row["alt_code"].ToString(),act_customer_contact_list(row["customer_id"].ToString())
            );
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        string jsonOutput = js.Serialize(data);
        context.Response.Write(jsonOutput);
        
    }
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //context.Response.ContentType = "application/json";
        

        if (context.Request.QueryString["code"] == null) return;

        switch (context.Request.QueryString["code"].ToString())
        {
            case "1":
                generateArrCustomer(context);
                break;
            case "2":
                generateCustomerData(context);
                break;
        }
        
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}