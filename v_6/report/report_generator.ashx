<%@ WebHandler Language="C#" Class="report_generator" %>

using System;
using System.Web;
using CrystalDecisions.CrystalReports.Engine;
using _test;
using System.IO;


public class report_generator : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string nilai, ListID = context.Request.QueryString["ListID"], strPdfName = context.Request.QueryString["pdfName"], strFileType = context.Request.QueryString["fileType"];

        strPdfName = strPdfName.Replace(".rpt", "");

        BinaryReader stream = null;
        context.Response.ClearContent();
        context.Response.ClearHeaders();
        
        using(ReportDocument repDoc = new ReportDocument())
        {
            rpt r = new rpt();

            string repFilePath = context.Server.MapPath(loadReportFile(ListID));
            repDoc.Load(repFilePath);
            r.ConnectionInfo(repDoc);


            string strSQL = "select Parameter,FieldDataType from v_rptSetting where listId=" + ListID;
            _DBcon c = new _DBcon();
            foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
            {
                if (row["FieldDataType"].ToString() == "3")
                {
                    string tanggal = context.Request[row["Parameter"].ToString()];
                    tanggal = tanggal.Substring(3, 2) + '/' + tanggal.Substring(0, 2) + '/' + tanggal.Substring(6, 4);
                    nilai = tanggal;
                }
                else
                {
                    nilai = context.Request[row["Parameter"].ToString()];
                }

                repDoc.SetParameterValue(row["Parameter"].ToString(), nilai);
            }
            /*
            repDoc.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.ExcelWorkbook, context.Response, true, strPdfName);
            repDoc.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, context.Response, true, strPdfName);
            */
            
            switch (strFileType)
            {
                default:
                    stream = new BinaryReader(repDoc.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat));
                    context.Response.ContentType = "application/pdf";
                    strPdfName = strPdfName + ".pdf";
                    
                    break;
                case "2":
                    stream = new BinaryReader(repDoc.ExportToStream(CrystalDecisions.Shared.ExportFormatType.Excel));
                    //context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    context.Response.ContentType = "application/vnd.ms-excel";
                    strPdfName = strPdfName + ".xls";
                    break;
                case "3":
                    stream = new BinaryReader(repDoc.ExportToStream(CrystalDecisions.Shared.ExportFormatType.WordForWindows));
                    //context.Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                    context.Response.ContentType = "application/msword";
                    strPdfName = strPdfName + ".doc";
                    break;
                    
            }
        }

        context.Response.AddHeader("content-disposition", "attachment; filename=" + strPdfName);
        context.Response.AddHeader("content-length", stream.BaseStream.Length.ToString());
        context.Response.BinaryWrite(stream.ReadBytes(Convert.ToInt32(stream.BaseStream.Length)));
        context.Response.Flush();
        context.Response.Close();         
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    string loadReportFile(string ListID)
    {
        string strSQL = "select ListId,DisplayName, FileName from v_rptList where ListID=" + ListID;
        string strFileName = "";

        _DBcon c = new _DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            strFileName = row["FileName"].ToString();
        }
        return strFileName;
    }  

}