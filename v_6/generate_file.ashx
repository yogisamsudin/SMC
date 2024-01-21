<%@ WebHandler Language="C#" Class="generate_file" %>

using System;
using System.Web;
using System.Data.SqlClient;
using _test;

public class generate_file : IHttpHandler {
    
    private void write_image(HttpContext cont, string sql)
    {
        _DBcon c = new _DBcon();
        using (SqlConnection _con = new SqlConnection(c.getConnectionString()))
        {
            _con.Open();
            SqlCommand _com = new SqlCommand();
            _com.Connection = _con;
            _com.CommandType = System.Data.CommandType.Text;
            _com.CommandText = sql;
            _com.CommandTimeout = c.getCommandTimeout();
            SqlDataReader row = _com.ExecuteReader();

            if (row.Read())
            {
                if (row["img"] != null)
                {
                    cont.Response.ContentType = row["file_type"].ToString();
                    cont.Response.AddHeader("Content-Disposition", "attachment; filename=tandatanganmarketing.jpg");
                    cont.Response.BinaryWrite((byte[])row["img"]);
                }
                
            }

            _com.Dispose();

        }
    }
    
    public void ProcessRequest (HttpContext context) {
        if (context.Request.QueryString["jenis"] == null) return;
        
        string jenis = context.Request.QueryString["jenis"].ToString();
        string param1 = (context.Request.QueryString["param1"] == null) ? "" : context.Request.QueryString["param1"].ToString();
        string param2 = (context.Request.QueryString["param2"] == null) ? "" : context.Request.QueryString["param2"].ToString();        

        switch (jenis)
        {
            case "marketing":                
                write_image(context, "select ttd_image img,file_type from act_marketing where marketing_id='" + param1 + "'");
                break;
            
        }        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}