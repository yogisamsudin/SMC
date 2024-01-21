<%@ Control Language="C#" ClassName="wuc_location" %>

<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }

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
            <td><div class="buttonCari" id="<%= ClientID %>_cari">Cari</div></td>
        </tr>
    </table>

    <iframe class="frameList" id="<%= ClientID %>_fr_list"></iframe>  

    <div style="padding-top:5px;" class="button_panel">
        <input type="button" value="Close"/>
    </div>
</fieldset>
</div>

<div id="<%= ClientID %>_panel_">
<fieldset>
    <legend></legend>
    <table class="formview">
        <tr>
            <th>Alamat</th>
            <td><textarea id="<%= ClientID %>_panel_address" maxlength="300"></textarea></td>
        </tr>                
    </table>

    <div style="padding-top:5px;" class="button_panel">
        <input type="button" value="Add"/>
        <input type="button" value="Save"/>
        <input type="button" value="Delete"/>
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
                    bt_cari: apl.func.get("<%= ClientID %>_cari"),
                    fl_load:function()
                    {
                        var name=escape(o.tb_address.value);
                        o.fl.src = "../expedition/location_list.aspx?edit=location_edit&add=location_add&select=location_select&name="+name;
                    },
                    open:function()
                    {
                        o.tb_address.value = "";                        
                        o.fl_load();
                        o.showEdit("Location - Select");
                    }
                },
                undefined, undefined, undefined, "<%= parent_id %>", "<%= cover_id %>", ""
            );

            var o2 = document["<%= ClientID %>_panel"] = apl.createModal("<%= ClientID %>_panel_",
                {
                    tb_address: apl.func.get("<%= ClientID %>_panel_address"),                           
                    val_address: apl.createValidator("<%= ClientID %>_panel_save", "<%= ClientID %>_panel_address", function () { return apl.func.emptyValueCheck(o2.tb_address.value); }, "Inputan salah"),
                    kosongkan:function()
                    {
                        o2.tb_address.value = "";                        
                    },
                    tambah:function()
                    {
                        o2.kosongkan();
                        o2.showAdd("Location - Tambah");
                    }
                },
                function ()
                {
                    apl.func.validatorCheck("<%= ClientID %>_panel_save");
                }, undefined, undefined, "<%= parent_id %>", "<%= ClientID %>_", ""
            );

            o.bt_cari.onclick = o.fl_load;
            document.location_add = o2.tambah;
        });
</script>