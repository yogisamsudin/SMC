using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using _test;

public partial class upload_image : System.Web.UI.Page
{
    private void save_marketing(byte[] obj_file, string marketing_id)
    {
        _DBcon c = new _DBcon();
        _DBcon.arrOutComPar retval = c.executeProcNQ("act_marketing_save_ttd", new _DBcon.sComParameter[]
                {
                    new _DBcon.sComParameter("@marketing_id",System.Data.SqlDbType.VarChar,15,marketing_id),
                    new _DBcon.sComParameter("@ttd_image",System.Data.SqlDbType.Image,0,obj_file),
                    new _DBcon.sComParameter("@file_type",System.Data.SqlDbType.VarChar,200,hf_filetype.Value),
                }
        );
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        hf_status.Value = "";

        if (Request.QueryString["jenis"] == null) return;
        if (fu.HasFile == false) return;

        string param1 = "", param2 = "";
        int len = fu.PostedFile.ContentLength;
        byte[] obj_file = new byte[len];
        fu.PostedFile.InputStream.Read(obj_file, 0, len);

        string jenis = Request.QueryString["jenis"].ToString();

        if (Request.QueryString["param1"] != null) param1 = Request.QueryString["param1"].ToString();
        if (Request.QueryString["param2"] != null) param2 = Request.QueryString["param2"].ToString();

        switch (jenis)
        {
            case "marketing": 
                
                save_marketing(obj_file, param1);
                break;
        }

        hf_status.Value = "simpan";
    }
}