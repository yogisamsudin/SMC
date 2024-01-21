<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th>Nama</th>
            <td><input type="text" id="cari_name"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe> 

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_name"/></td>
                </tr>
                <tr>
                    <th>Aktif</th>
                    <td><input type="checkbox" id="mdl_active"/></td>
                </tr>
                <tr>
                    <th>ID.Mobile</th>
                    <td><input type="text" size="10" id="mdl_mobileid"/></td>
                </tr>
                <tr>
                    <th>Pass.Mobile</th>
                    <td><input type="password" size="10" id="mdl_mobilepass"/></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_name:apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),            
            load: function () {
                var name = cari.tb_name.value;
                
                cari.fl.src = "messanger_list.aspx?name=" + escape(name);
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                messanger_id: 0,
                tb_name: apl.func.get("mdl_name"),
                cb_active: apl.func.get("mdl_active"),
                tb_mobileid: apl.func.get("mdl_mobileid"),
                tb_mobilepass:apl.func.get("mdl_mobilepass"),
                val1: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_mobileid", function () { return apl.func.emptyValueCheck(mdl.tb_mobileid.value); }, "Salah input"),

                kosongkan:function()
                {
                    mdl.tb_name.value = "";
                    mdl.cb_active.checked = true;
                    mdl.tb_mobileid.value = "";
                    mdl.tb_mobilepass.value = "";
                    apl.func.validatorClear("save");
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Kurir - Tambah")
                },
                edit:function(id)
                {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_data(id,
                        function (data) {
                            mdl.messanger_id = id;
                            mdl.tb_name.value = data.messanger_name;
                            mdl.cb_active.checked = data.active_sts;
                            mdl.tb_mobileid.value = data.mobile_id;
                            
                            mdl.showEdit("Kurir - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    cari.fl_refresh();
                    mdl.hide();
                    apl.func.hideSinkMessage();
                }
            },
            function()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_add(mdl.tb_name.value, mdl.cb_active.checked,mdl.tb_mobileid.value,mdl.tb_mobilepass.value, mdl.refresh, apl.func.showError, "");
                }
            }, 
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_edit(mdl.messanger_id, mdl.tb_name.value, mdl.cb_active.checked, mdl.tb_mobileid.value, mdl.tb_mobilepass.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_delete(mdl.messanger_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;
    </script>
</asp:Content>

