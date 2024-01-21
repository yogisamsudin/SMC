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
                    <th>Nilai 1</th>
                    <td><input type="text" id="mdl_fee1" autocomplete="off" size="15" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Nilai 2</th>
                    <td><input type="text" id="mdl_fee2" autocomplete="off" size="15" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>DPP</th>
                    <td><input type="text" id="mdl_dpp" autocomplete="off" size="6" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Tarif</th>
                    <td><input type="text" id="mdl_tarif" autocomplete="off" size="6" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Sts. NPWP</th>
                    <td><input type="checkbox" id="mdl_npwp"/></td>
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
    <script type="text/javascript">


        var cari = {
            fl_list: apl.func.get("cari_list"),
            load: function () {
                cari.fl_list.src = "feepph21_list.aspx";
            },
            refresh: function () {
                cari.fl_list.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                feepph21_id: 0,
                tb_fee1: apl.createNumeric("mdl_fee1",true,0),
                tb_fee2: apl.createNumeric("mdl_fee2",true,0),
                tb_dpp: apl.createNumeric("mdl_dpp",false,2),
                tb_tarif: apl.createNumeric("mdl_tarif",false,2),
                cb_npwp: apl.func.get("mdl_npwp"),

                val1: apl.createValidator("save", "mdl_fee1", function () { return apl.func.emptyValueCheck(mdl.tb_fee1.value); }, "Invalid input"),
                val2: apl.createValidator("save", "mdl_fee2", function () { return apl.func.emptyValueCheck(mdl.tb_fee2.value); }, "Invalid input"),
                val3: apl.createValidator("save", "mdl_dpp", function () { return apl.func.emptyValueCheck(mdl.tb_dpp.value); }, "Invalid input"),
                val4: apl.createValidator("save", "mdl_tarif", function () { return apl.func.emptyValueCheck(mdl.tb_tarif.value); }, "Invalid input"),

                kosongkan: function () {
                    mdl.tb_fee1.value = "";
                    mdl.tb_fee2.value = "";
                    mdl.tb_dpp.value = "";
                    mdl.tb_tarif.value = "";
                    mdl.cb_npwp.checked=true;
                    apl.func.validatorClear("save");
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Cabang - Tambah");

                },
                edit: function (branch_id) {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat...")
                    activities.par_branch_data(branch_id,
                        function (data) {
                            mdl.branch_id = data.branch_id;
                            mdl.tb_branch.value = data.branch_name;
                            mdl.cb_active.checked = data.active_sts;
                            mdl.ac_location.set_value(data.location_id, data.location_address);
                            mdl.tb_address.value = data.address;
                            mdl.tb_phone.value = data.phone;
                            mdl.tb_fax.value = data.fax;
                            mdl.showEdit("Cabang - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.par_branch_add(mdl.tb_branch.value, mdl.cb_active.checked, mdl.ac_location.id, mdl.tb_address.value, mdl.tb_phone.value, mdl.tb_fax.value, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.par_branch_edit(mdl.branch_id, mdl.tb_branch.value, mdl.cb_active.checked, mdl.ac_location.id, mdl.tb_address.value, mdl.tb_phone.value, mdl.tb_fax.value, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus...");
                    activities.par_branch_delete(mdl.branch_id, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;

    </script>
</asp:Content>

