<%@ Control Language="C#" ClassName="wuc_view_sales" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        //parent_id = "frm_page";
        //cover_id = "mdl";
    }
</script>
