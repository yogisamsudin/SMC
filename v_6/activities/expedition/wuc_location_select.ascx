<%@ Control Language="C#" ClassName="wuc_location_select" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }
    public string select_function { set; get; }

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
    }
</script>

<div id="<%= ClientID %>_">
<fieldset>
    <legend></legend>
    <table class="formview">
        <tr>
            <th>Alamat</th>
            <td><input type="text" id="<%= ClientID %>_address" size="100" maxlength="300"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="document.<%= ClientID %>.fl_load()">Cari</div></td>
        </tr>
    </table>

    <iframe class="frameList" id="<%= ClientID %>_fr_list"></iframe>  

    <div style="padding-top:5px;" class="button_panel">
        <input type="button" value="Close"/>
    </div>
</fieldset>
</div>

<script type="text/javascript">
    window.addEventListener("load",
        function () {
            var o = document["<%= ClientID %>"] = apl.createModal("<%= ClientID %>_",
                {
                    tb_address: apl.func.get("<%= ClientID %>_address"),
                    fl: apl.func.get("<%= ClientID %>_fr_list"),                    
                    fl_load: function () {
                        var address = escape(o.tb_address.value);
                        o.fl.src = "../expedition/location_select_list.aspx?address=" + address + "&select=<%= select_function %>";
                    },
                    open: function () {
                        o.tb_address.value = "";
                        o.fl_load();
                        o.showEdit("Location - Select");                        
                    },
                    close:function()
                    {
                        o.hide();
                    }
                },
                undefined, undefined, undefined, "<%= parent_id %>", "<%= cover_id %>", ""
            );
        }
    );
</script>