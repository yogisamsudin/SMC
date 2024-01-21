<%@ WebHandler Language="C#" Class="passing_generator" %>

using System;
using System.Web;
using _test;

public class passing_generator : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        App a = new App(context.Request, context.Response);

        string js = "\n<script type='text/javascript'>\n";
        string strListID = context.Request["ListID"].ToString();
        string strFileName = context.Request["FileName"].ToString();
        string jsParam = "";
        string str_param = "";

        context.Response.ContentType = "text/HTML";
        context.Response.Write("<html xmlns='http://www.w3.org/1999/xhtml'>\n");
        context.Response.Write("<head>\n<script src='../js/Komponen.js' type='text/javascript'></script>");        
        context.Response.Write("<link href='../App_Themes/Page/General.css' type='text/css' rel='stylesheet' /><link href='../App_Themes/Page/Komponen.css' type='text/css' rel='stylesheet' /><link href='../App_Themes/Page/Page.css' type='text/css' rel='stylesheet' />\n</head>\n");        
        context.Response.Write("<body id='bodyContent'>\n");
        //context.Response.Write("<script src='Report.asmx/jsdebug' type='text/javascript'></script>\n");
        context.Response.Write("<table class='formview' >");

        string strSQL = "select PromptText,parameter,FieldDataType,FieldInputType,FieldSize,FieldName, FieldText,FieldCondition,Source from rptSetting where listid=" + strListID + " order by ParameterID";
        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            str_param = row["parameter"].ToString().Replace("@","a");
            
            context.Response.Write("\n<tr>");
            
            //if (row["FieldDataType"].ToString() == "3") //date
            //{
            //    context.Response.Write("<th>"+row["PromptText"].ToString()+"</th>");
            //}

            context.Response.Write("<th>" + row["PromptText"].ToString() + "</th>");
            
            switch (row["FieldInputType"].ToString())
            {
                case "1": //date
                    context.Response.Write("<td><input type='text' id='" + str_param + "' size='" + row["FieldSize"].ToString() + "'></td>");

                    js += "var tb" + str_param + "=apl.createCalender('" + str_param + "');\n";
                    js += "var val"+str_param+" = apl.createValidator('grpCetak', '"+str_param+"', function () { return apl.func.emptyValueCheck(tb"+str_param+".value); }, 'Tanggal harus di isi');\n";
                    js += "tb" + str_param+".value='"+a.ApplicationDate + "';\n";

                    jsParam += "+'&" + row["parameter"].ToString() + "='+tb" + str_param + ".value";                
                    break;
                case "2":   //textbox
                    context.Response.Write("<td><input type='text' id='" + str_param + "' size='" + row["FieldSize"].ToString() + "'></td>");

                    if (row["FieldDataType"].ToString() == "2") //numeric
                    {
                        js += "var tb" + str_param + " = apl.createNumeric('" + str_param + "',false);\n";
                        js += "tb" + str_param + ".style.textAlign = 'Right';\n";
                        js += "var val" + str_param + " = apl.createValidator('grpCetak', '" + str_param + "', function () { return apl.func.emptyValueCheck(tb" + str_param + ".value); }, 'Invalid input');\n";
                    }
                    else
                    {
                        js += "var tb" + str_param + " = apl.func.get('" + str_param + "');\n";
                    }



                    jsParam += "+'&" + row["parameter"].ToString() + "='+tb" + str_param + ".value";
                    break;
                    
                case "3":   //dropdown
                    context.Response.Write("<td><select id='" + str_param + "'>");

                    string _strCondition;

                    if (row["FieldCondition"].ToString() == "")
                    {
                        _strCondition = "";
                    }
                    else
                    {
                        _strCondition = " where " + row["FieldCondition"].ToString();
                        
                    }
                    
                    string _strSQL = "select " + row["FieldName"].ToString() + " as value, " + row["FieldText"].ToString() + " as text from " + row["source"].ToString() + _strCondition;                    
                    using (_DBcon _c = new _DBcon())
                    {
                        foreach (System.Data.DataRow _row in _c.executeTextQ(_strSQL))
                        {
                            //context.Response.Write("<option value='" + _row[row["FieldName"].ToString()].ToString() + "'>" + _row[row["FieldText"].ToString()].ToString() + "</option>");
                            context.Response.Write("<option value='" + _row["value"].ToString() + "'>" + _row["text"].ToString() + "</option>");
                        }
                    }
                    
                    
                    context.Response.Write("</select></td>");

                    js += "var ddl" + str_param + " = apl.func.get('" + str_param + "');\n";


                    jsParam += "+'&" + row["parameter"].ToString() + "='+ddl" + str_param + ".value";
                    break;
            }
            
            //if (row["FieldInputType"].ToString() == "1") //date
            //{
            //    context.Response.Write("<td><input type='text' id='" + str_param + "' size='" + row["FieldSize"].ToString() + "'></td>");

            //    js += "var tb" + str_param + "=apl.createCalender('" + str_param + "');\n";
            //    js += "var val"+str_param+" = apl.createValidator('grpCetak', '"+str_param+"', function () { return apl.func.emptyValueCheck(tb"+str_param+".value); }, 'Tanggal harus di isi');\n";
            //    js += "tb" + str_param+".value='"+a.ApplicationDate + "';\n";

            //    jsParam += "+'&" + str_param + "='+tb" + str_param+".value";                
            //}
            
            context.Response.Write("</tr>\n");
            
        }
        context.Response.Write("<tr><th>Hasil</th><td><select id='hasil'><option value='1' selected>PDF</option><option value='2'>Excel</option><option value='3'>Word</option></select></td></tr>\n");
        context.Response.Write("</table>\n");
        context.Response.Write("<div class='panelDBUpdate'>\n<input type='button' value='Cetak' id='mdl_passing_cetak'/><input type='button' value='Close' id='mdl_passing_btnclose'/>\n</div>");

        js += "var sel=apl.func.get('hasil');\n";
        js += "var strFileName='" + strFileName + "';\n";
        /*
        js += "var btnCetak=(function(){ var _o=apl.func.get('mdl_passing_cetak');_o.onclick=function(){ if (apl.func.validatorCheck('grpCetak')) { window.location='generate_pdf.aspx?ListID=" + strListID + "&pdfName='+strFileName+'&fileType=\'+sel.value" + jsParam + "; }};return _o;})();\n";
        js += "var btnClose = (function () { var _o = apl.func.get('mdl_passing_btnclose'); _o.onclick = function () { window.parent.document.closeModulPassing();};return _o;})();\n";
         */
        js += "var btnCetak=(function(){ var _o=apl.func.get('mdl_passing_cetak');_o.onclick=function(){ if (apl.func.validatorCheck('grpCetak')) { window.location='report_generator.ashx?ListID=" + strListID + "&pdfName='+strFileName+'&fileType=\'+sel.value" + jsParam + "; }};return _o;})();\n";
        js += "var btnClose = (function () { var _o = apl.func.get('mdl_passing_btnclose'); _o.onclick = function () { window.parent.document.closeModulPassing();};return _o;})();\n";
        js += "</script>\n";
        
        context.Response.Write(js);
        context.Response.Write("</body>\n</html>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}