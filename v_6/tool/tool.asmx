<%@ WebService Language="C#" Class="tool" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using _test;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class tool  : System.Web.Services.WebService {
    //STRUCT
    public struct s_dropdown
    {
        public string value, text;
        
        public s_dropdown(string _value, string _text)
        {
            value = _value;
            text = _text;
        }
    }
    public struct s_parameter
    {
        public string kode, keterangan, nilai, field_type_id;
        
        public s_parameter(string _kode, string _keterangan, string _nilai, string _field_type_id)
        {
            kode = _kode;
            keterangan = _keterangan;
            nilai = _nilai;
            field_type_id = _field_type_id;
        }
    }
    [WebMethod]
    public s_parameter app_parameter_data(string kode)
    {
        s_parameter data = new s_parameter();

        string strSQL = "select kode,nilai,keterangan,field_type_id from appparameter where kode='"+kode+"'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_parameter(row["kode"].ToString(),row["keterangan"].ToString(),row["nilai"].ToString(),row["field_type_id"].ToString());
        }

        return data;
    }
    public struct appMenuStruc
    {
        public int MenuID, SubMenuID, MenuUrut;
        public string MenuName, MenuUrl, Initial;
        public appMenuStruc(int _MenuID, int _subMenuID, int _MenuUrut, string _MenuName, string _MenuUrl, string _Initial = "")
        {
            MenuID = _MenuID;
            SubMenuID = _subMenuID;
            MenuUrut = _MenuUrut;
            MenuName = _MenuName;
            MenuUrl = _MenuUrl;
            Initial = _Initial;
        }
    }
    public struct appUserStruct
    {
        public string UserID, UserName, branch_name;
        public int GroupID, branch_id;
        public Boolean Active;

        public appUserStruct(string _UserID, string _UserName, Boolean _Active, int _GroupID, int _branch_id = 0, string _branch_name = "")
        {
            UserID = _UserID;
            UserName = _UserName;
            Active = _Active;
            GroupID = _GroupID;
            branch_id = _branch_id;
            branch_name = _branch_name;
        }
    }
    public struct appGroupStruc
    {
        public int GroupID;
        public string GroupName;

        public appGroupStruc(int _GroupID, string _GroupName)
        {
            GroupID = _GroupID;
            GroupName = _GroupName;
        }
    }
    public struct appMenuGroupPrivilege
    {
        public int GroupId, MenuId, SubMenuID, menuurut;
        public string MenuName, MenuURL;

        public appMenuGroupPrivilege(int _GroupId, int _MenuId, int _SubMenuID, int _menuurut, string _MenuName, string _MenuURL)
        {
            GroupId = _GroupId;
            MenuId = _MenuId;
            SubMenuID = _SubMenuID;
            menuurut = _menuurut;
            MenuName = _MenuName;
            MenuURL = _MenuURL;
        }
    }

    //QUERY
    [WebMethod]
    public void appGroupCreateMenuXML()
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appGroupCreateMenuXML", null);

    }
    [WebMethod]
    public String getMenuPriviledgeXML(int GroupID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("getMenuPriviledgeXML", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@GroupID",System.Data.SqlDbType.Int,0,GroupID),
                new _DBcon.sComParameter("@Ret",System.Data.SqlDbType.Xml,0,System.Data.ParameterDirection.Output)                
            });
        return hasil["@Ret"].ToString();
    }
    [WebMethod]
    public string appMenu_generate_xml_menu()
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appMenu_generate_xml_menu", new _DBcon.sComParameter[]{             
                new _DBcon.sComParameter("@Ret",System.Data.SqlDbType.Xml,0,System.Data.ParameterDirection.Output)               
            });

        return "<ul>" + hasil["@Ret"].ToString() + "</ul>"; ;
    }
    [WebMethod]
    public appUserStruct appUserByUserID(string UserID)
    {
        appUserStruct data = new appUserStruct();

        string strSQL = "select UserID,UserName,Active,GroupID,isnull(branch_id,0)branch_id , branch_name from v_appUser where UserID='" + UserID + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new appUserStruct(UserID, row["UserName"].ToString(), Convert.ToBoolean(row["Active"]), Convert.ToInt32(row["GroupID"]),Convert.ToInt32(row["branch_id"]), row["branch_name"].ToString());
        }

        return data;
    }
    [WebMethod]
    public appGroupStruc[] appGroupList(string strWhere)
    {
        List<appGroupStruc> data = new List<appGroupStruc>();
        string strSQL = "select GroupId,GroupName from v_appGroup order by GroupName";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new appGroupStruc(Convert.ToInt32(row["GroupID"].ToString()), row["GroupName"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public int appMenuAddChild(int SubMenuID, string MenuName, string MenuURL)
    {
        int ret;
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appMenuAddChild", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@MenuID",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output),
                new _DBcon.sComParameter("@MenuName",System.Data.SqlDbType.VarChar,100,MenuName),
                new _DBcon.sComParameter("@MenuURL",System.Data.SqlDbType.VarChar,100,MenuURL),
                new _DBcon.sComParameter("@SubMenuID",System.Data.SqlDbType.Int,0,SubMenuID)
            });

        ret = Convert.ToInt32(hasil["@MenuID"]);
        return ret;
    }
    [WebMethod]
    public s_dropdown[] par_branch_list(string strWhere)
    {
        List<s_dropdown> data = new List<s_dropdown>();
        string strSQL = "select * from (select '' value,'--Semua--' text union select branch_id, branch_name from v_par_branch)a";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new s_dropdown(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    
    //EXECUTE
    [WebMethod]
    public void appParameter_edit(string kode,string nilai)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appParameter_edit", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@kode",System.Data.SqlDbType.VarChar,25,kode),
                new _DBcon.sComParameter("@nilai",System.Data.SqlDbType.VarChar,50,nilai)
            });        
    }
    [WebMethod]
    public void appGroupPrivilegeSave(int GroupID, int[] arrMenuID)
    {
        System.Data.DataTable DataList = new System.Data.DataTable();
        DataList.Columns.Add("MenuID", typeof(int));
        foreach (int MenuID in arrMenuID)
        {
            System.Data.DataRow dr = DataList.NewRow();
            dr["MenuID"] = MenuID;
            DataList.Rows.Add(dr);
        }

        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appGroupPrivilegeSave", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@GroupID",System.Data.SqlDbType.Int,0,GroupID),                
                new _DBcon.sComParameter("@arrMenuID",System.Data.SqlDbType.Structured,0,DataList,"t_MenuID")
            });
    }    
    [WebMethod]
    public appMenuStruc appMenuByMenuID(Int32 MenuID)
    {
        appMenuStruc data = new appMenuStruc();

        string strSQL = "select MenuID,MenuName,MenuURL,isnull(SubMenuID,0)SubMenuID,MenuUrut,Initial from v_appMenu where MenuID='" + MenuID + "'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new appMenuStruc(MenuID, Convert.ToInt32(row["SubMenuID"]), Convert.ToInt32(row["MenuUrut"]), row["MenuName"].ToString(), row["MenuUrl"].ToString(), row["Initial"].ToString());
        }

        return data;
    }
    //#EXECUTE
    [WebMethod]
    public void appMenudelete(int MenuID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appMenudelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@MenuID",System.Data.SqlDbType.Int,0,MenuID)
            });
    }
    [WebMethod]
    public void appMenuSave(int MenuID, string MenuName, string MenuURL, int Urutan, string Initial)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appMenuSave", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@MenuID",System.Data.SqlDbType.Int,0,MenuID),
                new _DBcon.sComParameter("@MenuName",System.Data.SqlDbType.VarChar,35,MenuName),
                new _DBcon.sComParameter("@MenuURL",System.Data.SqlDbType.VarChar,100,MenuURL),
                new _DBcon.sComParameter("@Urutan",System.Data.SqlDbType.Int,0,Urutan),
                new _DBcon.sComParameter("@Initial",System.Data.SqlDbType.VarChar,3,Initial)
            });
    }
    [WebMethod]
    public void appMenuAdd(string MenuName, string MenuURL, int SubMenuID, int Urutan, string Initial)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appMenuAdd", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@MenuName",System.Data.SqlDbType.VarChar,35,MenuName),
                new _DBcon.sComParameter("@MenuURL",System.Data.SqlDbType.VarChar,200,MenuURL),
                new _DBcon.sComParameter("@SubMenuID",System.Data.SqlDbType.Int,0,SubMenuID),
                new _DBcon.sComParameter("@Urutan",System.Data.SqlDbType.Int,0,Urutan),
                new _DBcon.sComParameter("@Initial",System.Data.SqlDbType.VarChar,3,Initial)
            });
    }    
    [WebMethod]
    public void appUserDelete(string UserID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appUserDelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,UserID)
            });
    }
    [WebMethod]
    public void appUserChangePassword(string UserID, string Password)
    {
        Password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(Password, "SHA1");

        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appUserChangePassword", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,UserID),
                new _DBcon.sComParameter("@NewPassword",System.Data.SqlDbType.VarChar,40,Password)
            });
    }
    [WebMethod]
    public void appUserSave(string UserID, string Password, int GroupID, Boolean Active, string UserName, int branch_id)
    {
        if (Password != "")
        {
            Password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(Password, "SHA1");
        }
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appUserSave", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,15,UserID),
                new _DBcon.sComParameter("@Password",System.Data.SqlDbType.VarChar,40,Password),
                new _DBcon.sComParameter("@GroupID",System.Data.SqlDbType.Int,0,GroupID),
                new _DBcon.sComParameter("@Active",System.Data.SqlDbType.Bit,0,Active),
                new _DBcon.sComParameter("@UserName",System.Data.SqlDbType.VarChar,50,UserName),
                new _DBcon.sComParameter("@branch_id",System.Data.SqlDbType.Int,0,branch_id)
            });
    }        
    [WebMethod]
    public void appGroupSave(int GroupID, string GroupName)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appGroupSave", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@GroupID",System.Data.SqlDbType.Int,0,GroupID),
                new _DBcon.sComParameter("@GroupName",System.Data.SqlDbType.VarChar,25,GroupName)
            });
    }
    [WebMethod]
    public void appGroupDelete(int GroupID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appGroupDelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@GroupID",System.Data.SqlDbType.Int,0,GroupID)
            });
    }    
    [WebMethod]
    public appMenuGroupPrivilege[] appMenuGroupPrivilege_forReason_1(string UserID)
    {
        List<appMenuGroupPrivilege> data = new List<appMenuGroupPrivilege>();
        string strSQL = "select MenuId,MenuName from v_appMenuGroupPrivilege where isnull(menuurl,'')<>'' and GroupId=(select GroupId from appUser where UserID='" + UserID + "')";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new appMenuGroupPrivilege(0, Convert.ToInt32(row["MenuId"]), 0, 0, row["MenuName"].ToString(), ""));
        }

        return data.ToArray();
    }
    [WebMethod]
    public void appUserMenuPavoriteSave(string UserID, int nomor, int MenuID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appUserMenuPavoriteSave", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,20,UserID),
                new _DBcon.sComParameter("@Nomor",System.Data.SqlDbType.SmallInt,0,nomor),
                new _DBcon.sComParameter("@MenuID",System.Data.SqlDbType.Int,0,MenuID)
            });
    }
    [WebMethod]
    public void appUserMenuPavoriteDelete(string UserID, int nomor)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("appUserMenuPavoriteDelete", new _DBcon.sComParameter[]{                
                new _DBcon.sComParameter("@UserID",System.Data.SqlDbType.VarChar,20,UserID),
                new _DBcon.sComParameter("@Nomor",System.Data.SqlDbType.SmallInt,0,nomor)
            });
    }
    
    
}