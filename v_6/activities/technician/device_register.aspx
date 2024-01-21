<%@ Page Title="" Language="C#" MasterPageFile="~/page.master"theme="Page" %>

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
            <th>SN</th>
            <td><input type="text" id="cari_sn"/></td>
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
                    <th>SN</th>
                    <td><input type="text" id="mdl_sn" /></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><input type="text" id="mdl_device"/></td>
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
            tb_sn: apl.func.get("cari_sn"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var sn = escape(cari.tb_sn.value);
                cari.fl.src = "device_register_list.aspx?sn=" + sn;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                device_register_id: 0,
                tb_sn: apl.func.get("mdl_sn"),
                //ac_device: apl.createAutoComplete("mdl_device", activities.ac_device,600),
                ac_device: apl.create_auto_complete_text("mdl_device", activities.ac_device),
                val_sn: apl.createValidator("save", "mdl_sn", function () { return apl.func.emptyValueCheck(mdl.tb_sn.value); }, "Salah input"),
                val_device: apl.createValidator("save", "mdl_device", function () { return apl.func.emptyValueCheck(mdl.ac_device.input.value); }, "Salah input"),
                kosongkan:function()
                {
                    mdl.device_register_id = 0;
                    mdl.tb_sn.value = "";
                    mdl.ac_device.set_value("", "");
                    apl.func.validatorClear("save");
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Register - Tambah");                    
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.tec_device_register_data(id,
                        function (data)
                        {
                            mdl.device_register_id = data.device_register_id;
                            mdl.tb_sn.value = data.sn;
                            mdl.ac_device.set_value(data.device_id, data.device);
                            mdl.showEdit("Register - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    apl.func.hideSinkMessage();
                    cari.fl_refresh();
                    mdl.hide();
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_device_register_add(mdl.tb_sn.value, mdl.ac_device.id, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_device_register_edit(mdl.device_register_id,mdl.tb_sn.value, mdl.ac_device.id, mdl.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus");
                    activities.tec_device_register_delete(mdl.device_register_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        window.addEventListener("load",function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

