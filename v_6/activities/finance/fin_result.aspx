<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

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
            <th>Hasil Tagih</th>
            <td><input type="text" id="cari_result"/></td>
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
            <table>
                <tr>
                    <th>Keterangan</th>
                    <td><input type="text" id="mdl_result" size="50" maxlength="100"/></td>
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
            tb_result: apl.func.get("cari_result"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var result = escape(cari.tb_result.value);
                cari.fl.src = "fin_result_list.aspx?result=" + result;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                result_id: 0,
                tb_result: apl.func.get("mdl_result"),
                val_result: apl.createValidator("save", "mdl_result", function () { return apl.func.emptyValueCheck(mdl.tb_result.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.result_id = 0;
                    mdl.tb_result.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Keterangan - Tambah");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.fin_result_data(id,
                        function (data) {
                            mdl.result_id = id;
                            mdl.tb_result.value = data.result;
                            mdl.showEdit("Rekening - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.fin_result_add(mdl.tb_result.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.fin_result_edit(mdl.result_id, mdl.tb_result.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus Data");
                    activities.fin_result_delete(mdl.result_id, mdl.refresh, apl.func.showError, "");
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

