using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using _test;

public partial class login : System.Web.UI.Page
{
    public string strApplicationDate, strCallCutOff, strTglFin, strLat, strLng, str_branch_id, str_branch_name;
    public App a;

    protected void Page_Load(object sender, EventArgs e)
    {
        a = new App(Request,Response);
                
        if (hfValid.Value == "valid")
        {
            create_session(hfUser.Value, Session.SessionID);
            
            loadAppParameter();
            sCookie[] arrCookie = { 
                new sCookie(a.cookieSessionID, Session.SessionID), 
                new sCookie(a.cookieUserID, hfUser.Value), 
                //new sCookie(a.cookieHTMLMenu, getMenu(hfUser.Value)),
                //new sCookie(a.cookieListMenuPavorite, setMenuPavorite(hfUser.Value)),
                new sCookie(a.cookieApplicationDate, strApplicationDate),
                new sCookie(a.cookieCallCutOff, strCallCutOff),
                new sCookie(a.cookieBranchID, str_branch_id),
                new sCookie(a.cookieBranchName, str_branch_name)
            };

            createCookie(arrCookie);
            Response.Redirect("main.aspx");
        }
    }

    void create_session(string UserID, string SessionID )
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appCreateSession", new _DBcon.sComParameter[]{
             
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,UserID),
                new _DBcon.sComParameter("@SessionID",System.Data.SqlDbType.VarChar,50,SessionID)
            });
    }
    struct sCookie
    {
        public string ID, Value;
        public sCookie(string _ID, string _Value)
        {
            ID = _ID;
            Value = _Value;
        }
    }

    void createCookie(sCookie[] arrCookie)
    {
        foreach (var c in arrCookie)
        {
            Response.Cookies[c.ID].Value = c.Value;
            //Response.Cookies[c.ID].Expires = DateTime.Now.AddDays(1);
        }
    }
    String convertXmlToString(String xml)
    {
        return xml.Replace("<", "#").Replace(">", "$").Replace(";", "~");
    }
    String getMenu(string strUserID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("getMenuXMLUL", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,strUserID),
                new _DBcon.sComParameter("@Ret",System.Data.SqlDbType.Xml,0,System.Data.ParameterDirection.Output)                
            });

        return convertXmlToString(hasil["@Ret"].ToString());
    }
    string setMenuPavorite(string strUserID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("getXMLMenuPavorite", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,strUserID),
                new _DBcon.sComParameter("@Ret",System.Data.SqlDbType.Xml,0,System.Data.ParameterDirection.Output)                
            });

        return convertXmlToString(hasil["@Ret"].ToString());
    }
    void loadAppParameter()
    {
        /*
        string strSQL = "select * from(select dbo.f_convertDateToChar(dbo.f_getAplDate())ApplicationDate,dbo.f_getAppParameterValue('callcutoff') CallCutOff,dbo.f_getAppParameterValue('tglfin') TglFin, dbo.f_getAppParameterValue('lat') lat, dbo.f_getAppParameterValue('lng') lng)a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            strApplicationDate = row["ApplicationDate"].ToString();
            strCallCutOff = row["CallCutOff"].ToString();
            strTglFin = row["TglFin"].ToString();            
        }
        */
        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeProcQ("xml_login_loading", new _DBcon.sComParameter[]{             
            new _DBcon.sComParameter("@user_id",System.Data.SqlDbType.VarChar,50,hfUser.Value)
        }))
        {
            strApplicationDate = row["ApplicationDate"].ToString();
            strCallCutOff = row["CallCutOff"].ToString();
            strTglFin = row["TglFin"].ToString();
            str_branch_id = row["branch_id"].ToString();
            str_branch_name = row["branch_name"].ToString();
        }
    }
}