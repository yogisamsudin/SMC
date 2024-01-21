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
            <th>Device</th>
            <td><input type="text" id="cari_device"/></td>
        </tr>
        <tr>
            <th>Part Sts</th>
            <td><input type="checkbox" id="cari_part_status"/></td>
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
                    <th>Device</th>
                    <td><input type="text" id="mdl_device" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Type</th>
                    <td><select id="mdl_type"></select></td>
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
            tb_type: apl.func.get("cari_device"),
            cb_part_sts: apl.func.get("cari_part_status"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_type.value);
                var ps = cari.cb_part_sts.checked;
                cari.fl.src = "device_list.aspx?name=" + name + "&ps=" + ps;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                device_id: 0,
                tb_device: apl.func.get("mdl_device"),
                dl_type: apl.createDropdownWS("mdl_type", activities.dl_device_type_nonpart, undefined, undefined, false),
                val_device: apl.createValidator("save", "mdl_device", function () { return apl.func.emptyValueCheck(mdl.tb_device.value); }, "Salah input"),
                val_type: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.dl_type.value); }, "Salah input"),
                kosongkan:function()
                {
                    mdl.device_id = 0;
                    mdl.tb_device.value = "";
                    mdl.dl_type.load();
                    apl.func.validatorClear("save");
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Device - Tambah");
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.tec_device_data(id,
                        function (data)
                        {
                            mdl.device_id = id;
                            mdl.tb_device.value = data.device;
                            mdl.dl_type.value = data.device_type_id;
                            mdl.showEdit("Device - Edit");
                            apl.func.hideSinkMessage();
                        },
                        apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    cari.fl_refresh();
                    mdl.hide();
                    apl.func.hideSinkMessage();
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    activities.tec_device_add(mdl.tb_device.value, mdl.dl_type.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.tec_device_edit(mdl.device_id,mdl.tb_device.value, mdl.dl_type.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.tec_device_delete(mdl.device_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content");

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

