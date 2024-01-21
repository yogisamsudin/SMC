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

    <iframe class="frameList" id="cari_list"></iframe>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_name" autocomplete="off" size="50" /></td>
                </tr>                
            </table>
            <div class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script>
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl_list: apl.func.get("cari_list"),
            load: function () {
                var name = window.escape(cari.tb_name.value);

                cari.fl_list.src = "vendor_category_list.aspx?name=" + name;
            },
            refresh: function () {
                cari.fl_list.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                vendor_category_id: 0,
                tb_name: apl.func.get("mdl_name"),
                
                val01: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Invalid input"),

                tambah: function () {
                    apl.func.validatorClear("save");
                    mdl.vendor_category_id = 0;
                    mdl.tb_name.value = "";
                    
                    mdl.showAdd("Data - Tambah");

                },
                edit: function (id) {
                    apl.func.validatorClear("save");
                    mdl.vendor_category_id = id;
                    apl.func.showSinkMessage("Memuat...");
                    activities.par_vendor_category_data(id,
                        function (data)
                        {
                            mdl.tb_name.value = data.vendor_category_name;
                            apl.func.hideSinkMessage();
                            mdl.showEdit("Data - Edit");
                        },
                        apl.func.showError, ""
                    );
                },
                close: function () {
                    apl.func.hideSinkMessage();
                    cari.refresh();
                    mdl.hide();                    
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.par_vendor_category_add(mdl.tb_name.value, mdl.close, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.par_vendor_category_edit(mdl.vendor_category_id, mdl.tb_name.value, mdl.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus...");
                    activities.par_vendor_category_delete(mdl.vendor_category_id, mdl.close, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;
    </script>
</asp:Content>

