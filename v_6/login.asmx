<%@ WebService Language="C#" Class="login" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using _test;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]

public class login  : System.Web.Services.WebService {

    [WebMethod]
    public string loginCheck(string ID, string Pass, string sessionID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appUserLoginCheck", new _DBcon.sComParameter[]{
             
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,ID),
                new _DBcon.sComParameter("@Sandi",System.Data.SqlDbType.VarChar,50,System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(Pass, "SHA1").ToString()),
                new _DBcon.sComParameter("@SessionID",System.Data.SqlDbType.VarChar,50,sessionID),
                new _DBcon.sComParameter("@Retval",System.Data.SqlDbType.VarChar,100,System.Data.ParameterDirection.Output)               
            });

        return hasil["@Retval"].ToString();
    }
    
}