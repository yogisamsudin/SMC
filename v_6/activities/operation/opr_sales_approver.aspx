<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>

    <table class="formview">
        <tr>
            <th>Nama</th>
            <td>
                <input type="text" id="cari_name" /></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="buttonCari" onclick="cari.load();">Cari</div>
            </td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fr"></iframe>

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td>
                        <input type="text" id="mdl_approver" size="50" maxlength="50" /></td>
                </tr>
                <tr>
                    <th>User ID</th>
                    <td>
                        <select id="mdl_user"></select></td>
                </tr>
                <tr>
                    <th>Limit Awal</th>
                    <td><input type="text" id="mdl_limitawal" size="20" maxlength="20" style="text-align: right" /></td>
                </tr>
                <tr>
                    <th>Limit Akhir</th>
                    <td><input type="text" id="mdl_limitakhir" size="20" maxlength="20" style="text-align: right" /></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td>
                        <input type="checkbox" id="mdl_sts" /></td>
                </tr>

            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "opr_sales_approver_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                approver_id: 0,
                tb_approver: apl.func.get("mdl_approver"),
                tb_limitawal: apl.createNumeric("mdl_limitawal"),
                tb_limitakhir: apl.createNumeric("mdl_limitakhir"),
                cb_sts: apl.func.get("mdl_sts"),
                ddl_user: apl.createDropdownWS("mdl_user", activities.ddl_user),
                val1: apl.createValidator("save", "mdl_approver", function () { return apl.func.emptyValueCheck(mdl.tb_approver.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_limitawal", function () { return apl.func.emptyValueCheck(mdl.tb_limitawal.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_limitakhir", function () { return apl.func.emptyValueCheck(mdl.tb_limitakhir.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_user", function () { return apl.func.emptyValueCheck(mdl.ddl_user.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.approver_id = 0;
                    mdl.tb_approver.value = "";
                    mdl.tb_limitawal.value = "";
                    mdl.tb_limitakhir.value = "";
                    mdl.cb_sts.checked = true;
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Broker - Tambah");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.opr_sales_approver_data(id,
                        function (data) {
                            mdl.approver_id = data.approver_id;
                            mdl.tb_approver.value = data.approver_name;
                            mdl.ddl_user.value = data.user_id;
                            mdl.tb_limitawal.setValue(data.limit_awal);
                            mdl.tb_limitakhir.setValue(data.limit_akhir);
                            mdl.cb_sts.checked = data.active_sts;
                            mdl.showEdit("Broker - Edit");
                        }, apl.func.showError, ""
                    );

                },
                refresh: function () {
                    mdl.hide();
                    cari.fl_refresh();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.opr_sales_approver_add(mdl.ddl_user.value, mdl.tb_approver.value, mdl.tb_limitawal.getIntValue(), mdl.tb_limitakhir.getIntValue(), mdl.cb_sts.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.opr_sales_approver_edit(mdl.approver_id, mdl.ddl_user.value, mdl.tb_approver.value, mdl.tb_limitawal.getIntValue(), mdl.tb_limitakhir.getIntValue(), mdl.cb_sts.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    activities.opr_sales_approver_delete(mdl.approver_id, mdl.refresh, apl.func.showError, "");
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

