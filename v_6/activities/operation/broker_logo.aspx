<%@ Page Language="C#" Theme="Page"%>

<!DOCTYPE html>

<script runat="server">
    public int broker_id;
    public string field_image;
    
void Page_Load(object o , EventArgs e)
{
    broker_id = Convert.ToInt32( Request.QueryString["id"]);
    field_image = Request.QueryString["field"];

    load_data();

    if (hf_status.Value == "save")
    {
        System.IO.Stream fs = fu.PostedFile.InputStream;
        System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
        Byte[] bytes = br.ReadBytes((Int32)fs.Length);

        _test._DBcon d = new _test._DBcon();
        //_test._DBcon.arrOutComPar hasil = d.executeProcNQ("opr_broker_save_logo", new _test._DBcon.sComParameter[]{
        //                new _test._DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
        //                new _test._DBcon.sComParameter("@logo",System.Data.SqlDbType.Image,0,bytes)                        
        //});        
        _test._DBcon.arrOutComPar hasil = d.executeProcNQ("opr_broker_save_image", new _test._DBcon.sComParameter[]{
                        new _test._DBcon.sComParameter("@broker_id",System.Data.SqlDbType.Int,0,broker_id),
                        new _test._DBcon.sComParameter("@field_image",System.Data.SqlDbType.VarChar,25,field_image),
                        new _test._DBcon.sComParameter("@image",System.Data.SqlDbType.Image,0,bytes)                        
        });        
    }        
}

void load_data()
{
    System.Data.SqlClient.SqlConnection _con;
    System.Data.SqlClient.SqlCommand _com;

    _con = new System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["csApp"].ConnectionString);
    
    _con.Open();
    _com = new System.Data.SqlClient.SqlCommand();
    _com.Connection = _con;
    _com.CommandType = System.Data.CommandType.Text;
    _com.CommandText = "select logo,i_header, i_title, i_footer from opr_broker where broker_id="+broker_id.ToString();    
    _com.CommandTimeout = Convert.ToInt32((System.Configuration.ConfigurationManager.AppSettings["CommandTimeout"] == null) ? "0" : System.Configuration.ConfigurationManager.AppSettings["CommandTimeout"]);
     System.Data.SqlClient.SqlDataReader r= _com.ExecuteReader();

    r.Read();

    if (r[field_image].ToString()!="")
    {
        byte[] bytes = (byte[])r[field_image];
        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        gambar.ImageUrl = "data:image/png;base64," + base64String;
    }
    
    _com.Dispose();
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>    
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hf_status"/>
        <table class="formview">
            <tr>
                <th>Pilih Gambar '<%= field_image %>'</th>
                <td><asp:FileUpload ID="fu" runat="server" Width="600px"/></td>
            </tr>
            <tr>
                <th>Gambar Sebelum</th>
                <td><asp:Image ID="gambar" runat="server" /></td>
            </tr>            
        </table>        
    </form>
    <script type="text/javascript">
        var frm = document.getElementById("form1");
        var st = document.getElementById('<%= hf_status.ClientID %>');
        document.submit = function()
        {
            if(confirm("Yakin disimpan?"))
            {
                st.value = "save";
                frm.submit();
            }
        }
    </script>
</body>
</html>
