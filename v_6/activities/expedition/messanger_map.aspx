<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<%@ Register Src="~/activities/map/wuc_map.ascx" TagPrefix="uc1" TagName="wuc_map" %>


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
            <th>Kurir</th>
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
                    <th>Lokasi</th>
                    <td>
                        <uc1:wuc_map runat="server" ID="mdl_map" />
                    </td>
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
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = cari.tb_name.value;

                cari.fl.src = "messanger_list.aspx?name=" + escape(name);
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var latitude = sessionStorage.getItem("lat");
        var longitude = sessionStorage.getItem("lng");
        var latlng = new ggl.maps.LatLng(latitude, longitude);

        var mdl = apl.createModal("mdl",
            {
                messanger_id: 0,
                tb_name: apl.func.get("mdl_name"),
                cb_active: apl.func.get("mdl_active"),
                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.tb_name.value = "";
                    mdl.cb_active.checked = true;
                    apl.func.validatorClear("save");
                },
                load_map:function()
                {
                    window.parent.document.initmap = initmap;
                    window.parent.document.initmap();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Kurir - Tambah");                    
                    document.mdl_map.open(latitude,longitude);
                },
                edit: function (id) {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_data(id,
                        function (data) {
                            mdl.messanger_id = id;
                            mdl.tb_name.value = data.messanger_name;
                            mdl.cb_active.checked = data.active_sts;
                            mdl.showEdit("Kurir - Edit");
                            apl.func.hideSinkMessage();
                            document.mdl_map.open(data.latitude, data.longitude);
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    cari.fl_refresh();
                    mdl.hide();
                    apl.func.hideSinkMessage();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_map_add(mdl.tb_name.value, mdl.cb_active.checked, document.mdl_map.latitude, document.mdl_map.longitude,mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_map_edit(mdl.messanger_id, mdl.tb_name.value, mdl.cb_active.checked,document.mdl_map.latitude,document.mdl_map.longitude, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.exp_messanger_delete(mdl.messanger_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        

        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;
        
    </script>
</asp:Content>

