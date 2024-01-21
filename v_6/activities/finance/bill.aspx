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
            <th>No.Rekening</th>
            <td><input type="text" id="cari_no"/></td>
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
                    <th>No</th>
                    <td><input type="text" id="mdl_no" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Nama Pemilik</th>
                    <td><input type="text" id="mdl_name" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Nama Bank</th>
                    <td><input type="text" id="mdl_bank" size="50" maxlength="50"/></td>
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
            tb_no: apl.func.get("cari_no"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var no = escape(cari.tb_no.value);
                cari.fl.src = "bill_list.aspx?no=" + no;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                bill_id: 0,
                tb_no: apl.func.get("mdl_no"),
                tb_name: apl.func.get("mdl_name"),
                tb_bank: apl.func.get("mdl_bank"),
                val_no: apl.createValidator("save", "mdl_no", function () { return apl.func.emptyValueCheck(mdl.tb_no.value); }, "Salah input"),
                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Salah input"),
                val_bank: apl.createValidator("save", "mdl_bank", function () { return apl.func.emptyValueCheck(mdl.tb_bank.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.bill_id = 0;
                    mdl.tb_no.value = "";
                    mdl.tb_name.value = "";
                    mdl.tb_bank.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Rekening - Tambah");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.fin_bill_data(id,
                        function (data) {
                            mdl.bill_id = id;
                            mdl.tb_no.value = data.bill_no;
                            mdl.tb_name.value = data.bill_name;
                            mdl.tb_bank.value = data.bill_bank_name;
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
                    activities.fin_bill_add(mdl.tb_name.value,mdl.tb_no.value,mdl.tb_bank.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.fin_bill_edit(mdl.bill_id,mdl.tb_name.value, mdl.tb_no.value, mdl.tb_bank.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus Data");
                    activities.fin_bill_delete(mdl.bill_id, mdl.refresh, apl.func.showError, "");
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

