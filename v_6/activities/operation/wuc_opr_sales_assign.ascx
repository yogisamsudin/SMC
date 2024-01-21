<%@ Control Language="C#" ClassName="wuc_opr_sales_assign" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }
    public string function_select { set; get; }
    public string branch_id { set; get; }

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        function_select = (function_select == null) ? "undefined" : function_select;
    }
</script>

<div id="<%= ClientID %>">
    <fieldset>
        <legend></legend>
        <table class="formview">
            <tr>
                <th>Pelanggan</th>
                <td><input type="text" id="<%= ClientID %>_customer" /></td>
            </tr>   
            <tr>
                <th></th>
                <td><div class="buttonCari" onclick="document['<%= ClientID %>'].load();">Cari</div></td>
            </tr>    
        </table> 

        <iframe class="frameList" id="<%= ClientID %>_fr"></iframe>            

        <div style="padding-top:5px;" class="button_panel">
            <input type="button" value="Close"/>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    window.addEventListener("load", function () {
        var mdl = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>",
            {
                tb_customer: apl.func.get("<%= ClientID %>_customer"),
                fr: apl.func.get("<%= ClientID %>_fr"),
                open: function () {
                    mdl.tb_customer.value = "";
                    mdl.fr.src = "";
                    mdl.showAdd("Pelanggan - Select");
                },
                load: function () {
                    var cust = escape(mdl.tb_customer.value);
                    mdl.fr.src = "opr_sales_assign_list.aspx?select=<%= ClientID %>_select&cust=" + cust+"&branch=<%= branch_id %>";
                },
                select: function (id) {                    
                    mdl.hide();
                    <%= function_select %>(id);
                }
            },
            undefined, undefined, undefined, "<%= parent_id%>", "<%= cover_id %>"
        );

        document["<%= ClientID %>_select"] = mdl.select;
    });

</script>