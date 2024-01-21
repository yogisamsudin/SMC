<%@ WebService Language="C#" Class="report" %>

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
public class report  : System.Web.Services.WebService {

    public struct s_rpt_list
    {
        public int module_code, list_id;
        public string display_name, file_name;
        
        public s_rpt_list(int _module_code, int _list_id, string _display_name,string _file_name)
        {
            module_code = _module_code;
            list_id = _list_id;
            display_name = _display_name;
            file_name = _file_name;
        }
    }
    public struct DropDrownList_Struct
    {
        public string value, text;
        public DropDrownList_Struct(string _value, string _text)
        {
            value = _value;
            text = _text;
        }
    }
    public struct rptModulStruc
    {
        public int moduleCode;
        public string Name;
        public rptModulStruc(int _moduleCode, string _Name)
        {
            moduleCode = _moduleCode;
            Name = _Name;
        }
    }
    //#query
    [WebMethod]
    public s_rpt_list rpt_list_data(string module_code, string list_id)
    {
        s_rpt_list data = new s_rpt_list();

        string strSQL = "select ModuleCode, ListId, DisplayName, FileName from rptlist where ModuleCode="+module_code+" and ListId="+list_id;        

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new s_rpt_list(Convert.ToInt32(row["ModuleCode"]),Convert.ToInt32(row["ListId"]),row["DisplayName"].ToString(),row["FileName"].ToString());
        }

        return data;
    }
    //#drowpdown
    [WebMethod]
    public DropDrownList_Struct[] dl_setting_input(string where)
    {
        List<DropDrownList_Struct> data = new List<DropDrownList_Struct>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='FieldinputType'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new DropDrownList_Struct(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public DropDrownList_Struct[] dl_setting_type(string where)
    {
        List<DropDrownList_Struct> data = new List<DropDrownList_Struct>();

        string strSQL = "select code value, keterangan text from appcommonparameter where type='FieldDataType'";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new DropDrownList_Struct(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public DropDrownList_Struct[] generateDataDDL(string field_value, string field_text, string Kondisi, string source, string orderby)
    {
        List<DropDrownList_Struct> data = new List<DropDrownList_Struct>();

        string strWhere, strOrderBy;

        if (Kondisi == "")
        {
            strWhere = "";
        }
        else
        {
            strWhere = " where " + Kondisi;
        }

        if (orderby == "")
        {
            strOrderBy = "";
        }
        else
        {
            strOrderBy = " order by " + orderby;
        }

        string strSQL = "select " + field_value + " as value, " + field_text + " as text from " + source + " " + strWhere + strOrderBy;


        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new DropDrownList_Struct(row["value"].ToString(), row["text"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public rptModulStruc rptModulByModuleCode(string moduleCode)
    {
        rptModulStruc data = new rptModulStruc();

        string strSQL = "select ModuleCode,Name from v_rptModul where ModuleCode=" + moduleCode;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new rptModulStruc(Convert.ToInt32(row["ModuleCode"].ToString()), row["Name"].ToString());
        }

        return data;
    }
    [WebMethod]
    public int rptModuleAdd(string Name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptModuleAdd", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@Name",System.Data.SqlDbType.VarChar,50,Name),
                new _DBcon.sComParameter("@ModuleCode",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
            });
        return Convert.ToInt32(hasil["@ModuleCode"]);
    }
    [WebMethod]
    public void rptModuleSave(int moduleCode, string Name)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptModuleSave", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@ModuleCode",System.Data.SqlDbType.Int,0,moduleCode),
                new _DBcon.sComParameter("@Name",System.Data.SqlDbType.VarChar,50,Name)
            });
    }
    [WebMethod]
    public void rptModuleDelete(int moduleCode)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptModuleDelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@ModuleCode",System.Data.SqlDbType.Int,0,moduleCode)
            });
    }

    public struct rptListStruc
    {
        public int ModuleCode, ListID;
        public string ModuleName, DisplayName, FileName;
        public rptListStruc(int _ModuleCode, int _ListID, string _ModuleName, string _DisplayName, string _FileName)
        {
            ModuleCode = _ModuleCode;
            ListID = _ListID;
            ModuleName = _ModuleName;
            DisplayName = _DisplayName;
            FileName = _FileName;
        }
    }
    [WebMethod]
    public rptListStruc[] rptList(string moduleCode)
    {
        List<rptListStruc> data = new List<rptListStruc>();

        string strSQL = "select ModuleCode,ListId,ModuleName,DisplayName,FileName from v_rptList where ModuleCode=" + moduleCode;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new rptListStruc(Convert.ToInt32(row["ModuleCode"]), Convert.ToInt32(row["ListId"]), row["ModuleName"].ToString(), row["DisplayName"].ToString(), row["FileName"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public rptListStruc rptListByCodeID(string moduleCode, string ListID)
    {
        rptListStruc data = new rptListStruc();

        string strSQL = "select ModuleCode,ListId,ModuleName,DisplayName,FileName from v_rptList where ModuleCode=" + moduleCode + " and ListID=" + ListID;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new rptListStruc(Convert.ToInt32(row["ModuleCode"].ToString()), Convert.ToInt32(row["ListId"].ToString()), row["ModuleName"].ToString(), row["DisplayName"].ToString(), row["FileName"].ToString());
        }

        return data;
    }
    [WebMethod]
    public int rptListAdd(int moduleCode, string DisplayName, string FileName)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptListAdd", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@ModuleCode",System.Data.SqlDbType.Int,0,moduleCode),
                new _DBcon.sComParameter("@DisplayName",System.Data.SqlDbType.VarChar,50,DisplayName),
                new _DBcon.sComParameter("@FileName",System.Data.SqlDbType.Text,0,FileName),
                new _DBcon.sComParameter("@ListId",System.Data.SqlDbType.Int,0,System.Data.ParameterDirection.Output)
            });
        return Convert.ToInt32(hasil["@ListId"]);
    }
    [WebMethod]
    public void rptListEdit(int ListID, string DisplayName, string FileName)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptListEdit", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@ListID",System.Data.SqlDbType.Int,0,ListID),
                new _DBcon.sComParameter("@DisplayName",System.Data.SqlDbType.VarChar,50,DisplayName),
                new _DBcon.sComParameter("@FileName",System.Data.SqlDbType.Text,0,FileName)
            });
    }
    [WebMethod]
    public void rptListDelete(int ListID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptListDelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@ListID",System.Data.SqlDbType.Int,0,ListID)
            });
    }
    public struct rptSettingStruc
    {
        public int ListID, ParameterID, FieldDataTypeID, FieldInputTypeID, Size;
        public string Parameter, PromptText, FieldDataType, FieldInputType, FieldName, FieldText, FieldCondition, Source;
        public rptSettingStruc(int _ListID, int _ParameterID, int _FieldDataTypeID, int _FieldInputTypeID, int _size, string _Parameter, string _PromptText, string _FieldDataType, string _FieldInputType, string _FieldName, string _FieldText, string _FieldCondition, string _Source)
        {
            ListID = _ListID;
            ParameterID = _ParameterID;
            FieldDataTypeID = _FieldDataTypeID;
            FieldInputTypeID = _FieldInputTypeID;
            Size = _size;
            Parameter = _Parameter;
            PromptText = _PromptText;
            FieldDataType = _FieldDataType;
            FieldInputType = _FieldInputType;
            FieldName = _FieldName;
            FieldText = _FieldText;
            FieldCondition = _FieldCondition;
            Source = _Source;
        }
    }
    [WebMethod]
    public rptSettingStruc rptSettingByParameterID(string ParameterID)
    {
        rptSettingStruc data = new rptSettingStruc();

        string strSQL = "select listId,ParameterId,Parameter,PromptText,FieldDataType,FieldInputType,FieldDataTypeName,FieldInputTypeName,FieldSize,FieldName,FieldText,FieldCondition,Source from v_rptSetting where ParameterId=" + ParameterID;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data = new rptSettingStruc(
                    Convert.ToInt32(row["ListID"].ToString()), Convert.ToInt32(row["ParameterID"].ToString()),
                    Convert.ToInt32(row["FieldDataType"].ToString()), Convert.ToInt32(row["FieldInputType"].ToString()),
                    Convert.ToInt32(row["FieldSize"].ToString()), row["Parameter"].ToString(), row["PromptText"].ToString(),
                    row["FieldDatatypeName"].ToString(), row["fieldInputTypeName"].ToString(), row["FieldName"].ToString(),
                    row["FieldText"].ToString(), row["FieldCondition"].ToString(), row["Source"].ToString()
                );
        }

        return data;
    }
    [WebMethod]
    public rptSettingStruc[] rptSettingList(string ListID)
    {
        List<rptSettingStruc> data = new List<rptSettingStruc>();

        string strSQL = "select listId,ParameterId,Parameter,PromptText,FieldDataType,FieldInputType,FieldDataTypeName,FieldInputTypeName,FieldSize,FieldName,FieldText,FieldCondition,Source from v_rptSetting where ListID=" + ListID;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(
                new rptSettingStruc(
                    Convert.ToInt32(row["ListID"].ToString()), Convert.ToInt32(row["ParameterID"].ToString()),
                    Convert.ToInt32(row["FieldDataType"].ToString()), Convert.ToInt32(row["FieldInputType"].ToString()),
                    Convert.ToInt32(row["FieldSize"].ToString()), row["Parameter"].ToString(), row["PromptText"].ToString(),
                    row["FieldDatatypeName"].ToString(), row["fieldInputTypeName"].ToString(), row["FieldName"].ToString(),
                    row["FieldText"].ToString(), row["FieldCondition"].ToString(), row["Source"].ToString()
                )
            );
        }

        return data.ToArray();
    }
    public struct appCommonParamStruc
    {
        public string Code, Keterangan;
        public appCommonParamStruc(string _Code, string _Keterangan)
        {
            Code = _Code;
            Keterangan = _Keterangan;
        }
    }
    [WebMethod]
    public appCommonParamStruc[] appCommParameterList(string strWhere)
    {
        List<appCommonParamStruc> data = new List<appCommonParamStruc>();

        string strSQL = "select Code,Keterangan from appCommonParam" + strWhere;

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            data.Add(new appCommonParamStruc(row["Code"].ToString(), row["Keterangan"].ToString()));
        }

        return data.ToArray();
    }
    [WebMethod]
    public void rptSettingAdd(int ListID, string Parameter, string PromptText, string FieldDataType, string FieldDataInput, int Size, string FieldValue, string FieldText, string Condition, string Source)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptSettingAdd", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@ListID",System.Data.SqlDbType.Int,0,ListID),
                new _DBcon.sComParameter("@Parameter",System.Data.SqlDbType.VarChar,35,Parameter),
                new _DBcon.sComParameter("@PromptText",System.Data.SqlDbType.VarChar,35,PromptText),
                new _DBcon.sComParameter("@FieldDataType",System.Data.SqlDbType.Char,1,FieldDataType),
                new _DBcon.sComParameter("@FieldInputType",System.Data.SqlDbType.Char,1,FieldDataInput),
                new _DBcon.sComParameter("@FieldSize",System.Data.SqlDbType.Int,0,Size),
                new _DBcon.sComParameter("@FieldValue",System.Data.SqlDbType.VarChar,35,FieldValue),
                new _DBcon.sComParameter("@FieldText",System.Data.SqlDbType.VarChar,35,FieldText),
                new _DBcon.sComParameter("@Condition",System.Data.SqlDbType.VarChar,100,Condition),
                new _DBcon.sComParameter("@Source",System.Data.SqlDbType.VarChar,100,Source)
            });
    }
    [WebMethod]
    public void rptSettingEdit(int ParameterID, string Parameter, string PromptText, string FieldDataType, string FieldDataInput, int Size, string FieldValue, string FieldText, string Condition, string Source)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptSettingEdit", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@parameterID",System.Data.SqlDbType.Int,0,ParameterID),
                new _DBcon.sComParameter("@Parameter",System.Data.SqlDbType.VarChar,35,Parameter),
                new _DBcon.sComParameter("@PromptText",System.Data.SqlDbType.VarChar,35,PromptText),
                new _DBcon.sComParameter("@FieldDataType",System.Data.SqlDbType.Char,1,FieldDataType),
                new _DBcon.sComParameter("@FieldInputType",System.Data.SqlDbType.Char,1,FieldDataInput),
                new _DBcon.sComParameter("@FieldSize",System.Data.SqlDbType.Int,0,Size),
                new _DBcon.sComParameter("@FieldValue",System.Data.SqlDbType.VarChar,35,FieldValue),
                new _DBcon.sComParameter("@FieldText",System.Data.SqlDbType.VarChar,35,FieldText),
                new _DBcon.sComParameter("@Condition",System.Data.SqlDbType.VarChar,100,Condition),
                new _DBcon.sComParameter("@Source",System.Data.SqlDbType.VarChar,100,Source)
            });
    }
    [WebMethod]
    public void rptSettingDelete(int ParameterID)
    {
        _DBcon d = new _DBcon();
        _DBcon.arrOutComPar hasil = d.executeProcNQ("rptSettingDelete", new _DBcon.sComParameter[]{
                new _DBcon.sComParameter("@parameterID",System.Data.SqlDbType.Int,0,ParameterID)
        });
    }
    
}