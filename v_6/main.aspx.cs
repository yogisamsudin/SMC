using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using _test;

public partial class main : System.Web.UI.Page
{
    public App a;    
    public string initial, menu_name,menu_url, lat, lng;
    protected void Page_Load(object sender, EventArgs e)
    {
        a = new App(Request,Response);
        Boolean status = false;


        load_firstmenuid();

        try
        {
            _DBcon d = new _DBcon();
            _DBcon.arrOutComPar hasil = d.executeProcNQ("appSessionCheck", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,a.cookieUserIDValue),
                new _DBcon.sComParameter("@SessionID",System.Data.SqlDbType.VarChar,50,a.cookieSessionIDValue),
                new _DBcon.sComParameter("@Ret",System.Data.SqlDbType.Bit,0,System.Data.ParameterDirection.Output)
            });

            status = Convert.ToBoolean(hasil["@Ret"]);
        }
        catch 
        {
            status = false;
        }
        finally
        {
            if (status == false) 
            {
                Response.Redirect("login.aspx");        
            }else{
                lMenu.Text = getMenuXML(a.cookieUserIDValue);
                load_geotag();
            }
            
        }        
    }

    void load_geotag()
    {
        string strSQL = "select * from(select dbo.f_convertDateToChar(dbo.f_getAplDate())ApplicationDate,dbo.f_getAppParameterValue('callcutoff') CallCutOff,dbo.f_getAppParameterValue('tglfin') TglFin, dbo.f_getAppParameterValue('lat') lat, dbo.f_getAppParameterValue('lng') lng)a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            lat= row["lat"].ToString();
            lng= row["lng"].ToString();            
        }
    }
    void load_firstmenuid()
    {
        string strSQL = "select menuurl,initial,menuname from appmenu where menuid=dbo.f_getAppParameterValue('firstmenuid')";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            menu_url = row["menuurl"].ToString();
            menu_name = row["menuname"].ToString();
            initial = row["initial"].ToString();
        }
    }
    string getMenuXML(string userID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("getMenuXMLUL", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,userID),
                new _DBcon.sComParameter("@Ret",System.Data.SqlDbType.Xml,0,System.Data.ParameterDirection.Output)                
            });

        return hasil["@Ret"].ToString();
    }
    protected void lb_logout_Click(object sender, EventArgs e)
    {
        appSessionDelete(a.cookieUserIDValue);
        a.deleteAllCookies();
        Response.Redirect("login.aspx");
    }
    void appSessionDelete(string UserID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appSessionDelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,UserID)
            });
    }    
}