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
            <th>Kode</th>
            <td><input type="text" id="cari_code"/></td>
        </tr>
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
            <table>
                <tr>
                    <th>ID</th>
                    <td><label id="mdl_id"></label></td>
                </tr>
                <tr>
                    <th>Code</th>
                    <td><input type="text" id="mdl_code" size="10" maxlength="10"/></td>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_name" size="100" maxlength="100"/></td>
                </tr>
                <tr>
                    <th>Type</th>
                    <td><select id="mdl_type"></select></td>
                </tr>
                <tr>
                    <th>Transaksi</th>
                    <td><select id="mdl_transaction"></select></td>
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
            tb_code: apl.func.get("cari_code"),
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var code = escape(cari.tb_code.value);
                var name= escape(cari.tb_name.value);
                cari.fl.src = "coa_list.aspx?code=" + code + "&name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                coa_id: 0,
                lb_id: apl.func.get("mdl_id"),
                tb_code: apl.func.get("mdl_code"),
                tb_name: apl.func.get("mdl_name"),
                dl_type: apl.createDropdownWS("mdl_type",activities.dl_ticket_type_list),
                dl_transaction: apl.createDropdownWS("mdl_transaction", activities.dl_financial_transaction_type_list),
                val_code: apl.createValidator("save", "mdl_code", function () { return apl.func.emptyValueCheck(mdl.tb_code.value); }, "Salah input"),
                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                val_type: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.dl_type.value); }, "Salah input"),
                val_transaction: apl.createValidator("save", "mdl_transaction", function () { return apl.func.emptyValueCheck(mdl.dl_transaction.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.coa_id = 0;
                    mdl.lb_id.innerHTML = "";
                    mdl.tb_code.value = "";
                    mdl.tb_name.value = "";
                    mdl.dl_type.value = "";
                    mdl.dl_transaction.value = "";

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("COA - Tambah");
                },
                edit: function (id) {
                    mdl.kosongkan();                    
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.coa_id = id;
                    activities.fin_coa_data(id,
                        function (data)
                        {
                            mdl.lb_id.innerHTML = id;
                            mdl.tb_code.value = data.coa_code;
                            mdl.tb_name.value = data.coa_name;
                            mdl.dl_type.value = data.ticket_type_id;
                            mdl.dl_transaction.value = data.financial_transaction_type_id;
                            mdl.showEdit("COA - Edit");
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
                    activities.fin_coa_add(mdl.tb_code.value, mdl.tb_name.value, mdl.dl_type.value, mdl.dl_transaction.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.fin_coa_edit(mdl.coa_id, mdl.tb_code.value, mdl.tb_name.value, mdl.dl_type.value, mdl.dl_transaction.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus Data");
                    activities.fin_coa_delete(mdl.coa_id, mdl.refresh, apl.func.showError, "");
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

