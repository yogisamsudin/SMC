<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

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
            <td><input type="text" id="cari_nama"/></td>
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
                    <td><input type="text" id="mdl_name" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Active</th>
                    <td><input type="checkbox" id="mdl_active"/></td>
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
            tb_name: apl.func.get("cari_nama"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "technician_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                technician_id:0,
                tb_name: apl.func.get("mdl_name"),
                cb_active: apl.func.get("mdl_active"),
                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.technician_id= 0;
                    mdl.tb_name.value = "";
                    mdl.cb_active.checked = true;
                    apl.func.validatorClear("save");
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Teknisi - Tambah");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.tec_technician_data(id,
                        function (data) {
                            mdl.technician_id = id;
                            mdl.tb_name.value = data.technician_name;
                            mdl.cb_active.checked = data.active_sts;
                            mdl.showEdit("Teknisi - Edit");
                            apl.func.hideSinkMessage();
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
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_technician_add(mdl.tb_name.value, mdl.cb_active.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_technician_edit(mdl.technician_id,mdl.tb_name.value, mdl.cb_active.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus");
                    activities.tec_technician_delete(mdl.technician_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

