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
    
    <div id="mdl" class="modal"> 
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_name" size="50" maxlength="50"/></td>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "position_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                id: 0,
                tb_name: apl.func.get("mdl_name"),
                
                val1: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                
                init: function () {
                    mdl.id = 0;
                    mdl.tb_name.value = "";
                    

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function (parent_coa_id) {
                    mdl.init();

                    mdl.showAdd("Tambah Data");

                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.init();
                    mdl.id = id;

                    activities.hr_position_data(id,
                        function (data) {
                            mdl.tb_name.value = data.position_name;
                            mdl.showEdit("Edit Data");
                        }, apl.func.showError, ""
                    );
                },
                close: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.hr_position_add(mdl.tb_name.value, mdl.close, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.hr_position_edit(mdl.id, mdl.tb_name.value, mdl.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_position_delete(mdl.id, mdl.close, apl.func.showError, "");
            }, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

