<%@ Control Language="C#" ClassName="wuc_device_register_select" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }
    public string function_select { set; get; }

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
                <th>SN</th>
                <td><input type="text" id="<%= ClientID %>_sn" /></td>
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
    window.addEventListener("load", function ()
    {
        var mdl = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>",
            {
                tb_sn: apl.func.get("<%= ClientID %>_sn"),
                fr: apl.func.get("<%= ClientID %>_fr"),
                open:function()
                {
                    mdl.tb_sn.value = "";
                    mdl.fr.src = "";
                    mdl.showAdd("SN - Select");
                },
                load:function()
                {
                    var sn = escape(mdl.tb_sn.value);
                    mdl.fr.src = "device_register_select_list.aspx?sn=" + sn + "&select=<%= ClientID %>_select";
                },
                select:function(id)
                {
                    mdl.hide();
                    <%= function_select %>(id);
                }
            },
            undefined, undefined, undefined, "<%= parent_id%>", "<%= cover_id %>"
        );

        document["<%= ClientID %>_select"] = mdl.select;
    });

</script>