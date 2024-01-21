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

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td>
                        <select id="mdl_name"></select></td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td>
                        <input type="text" id="mdl_date" size="10" readonly="readonly" /></td>
                </tr>
                <tr>
                    <th>Pinjaman</th>
                    <td>
                        <input type="text" id="mdl_amount" size="20" maxlength="25" style="text-align: right;" /></td>
                </tr>
                <tr>
                    <th>Tenor(Bulan)</th>
                    <td>
                        <input type="text" id="mdl_tenor" size="3" maxlength="3" style="text-align: right;" /></td>
                </tr>
                <tr>
                    <th>Angsuran</th>
                    <td>
                        <input type="text" id="mdl_installment" size="20" maxlength="25" style="text-align: right;" disabled="disabled" /></td>
                </tr>
                <tr>
                    <th>Keterangan</th>
                    <td>
                        <textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th>Awal Bulan Tertagih</th>
                    <td>
                        <select id="mdl_month"></select></td>
                </tr>
                <tr>
                    <th>Awal Tahun Tertagih</th>
                    <td>
                        <input type="text" id="mdl_year" size="4" maxlength="4" /></td>
                </tr>
                <tr>
                    <th>Param.Pemotongan</th>
                    <td>
                        <select id="mdl_param" disabled="disabled"></select>
                    </td>
                </tr>
                <tr>
                    <th>Approve</th>
                    <td>
                        <input type="checkbox" id="mdl_approve" /></td>
                </tr>
                <tr>
                    <th>Angsuran</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th>Periode</th>
                                <th>Bulan</th>
                                <th>Tahun</th>
                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>
    <div class="modal" id="mdllis">
        <fieldset>
            <legend></legend>
            <table class="gridView" id="mdllis_tbl">
                <tr>
                    <th style="width: 25px;"></th>
                    <th>Nama</th>
                    <th>Nilai</th>
                    <th>Tenor</th>
                    <th>Angsuran</th>
                </tr>
            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Close" />
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
                cari.fl.src = "loan_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.create_modal("mdl",
            {
                id: 0,
                dl_name: apl.createDropdownWS("mdl_name", activities.dl_employee),
                tb_date: apl.createCalender("mdl_date"),
                tb_amount: apl.createNumeric("mdl_amount"),
                tb_tenor: apl.createNumeric("mdl_tenor"),
                tb_angsuran: apl.createNumeric("mdl_installment"),
                tb_note: apl.func.get("mdl_note"),
                dl_month: apl.createDropdownWS("mdl_month", activities.dl_list_month),
                tb_year: apl.createNumeric("mdl_year", false),
                cb_apporve: apl.func.get("mdl_approve"),
                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("ins_period"),
                    apl.createTableWS.column("ins_month_name"),
                    apl.createTableWS.column("ins_year"),
                    //apl.createTableWS.column("paid_sts", undefined, [apl.createTableWS.attribute("type", "checkbox"), apl.createTableWS.attribute("disabled", "disabled")], undefined, undefined, "input", "checked")
                ]),
                dl_param: apl.createDropdownWS("mdl_param", activities.dl_hr_wageparam),

                val1: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.prop.dl_name.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.prop.tb_date.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_amount", function () { return apl.func.emptyValueCheck(mdl.prop.tb_amount.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_tenor", function () { return apl.func.emptyValueCheck(mdl.prop.tb_tenor.value); }, "Salah input"),
                val5: apl.createValidator("save", "mdl_installment", function () { return apl.func.emptyValueCheck(mdl.prop.tb_angsuran.value); }, "Salah input"),
                val6: apl.createValidator("save", "mdl_note", function () { return apl.func.emptyValueCheck(mdl.prop.tb_note.value); }, "Salah input"),
                val7: apl.createValidator("save", "mdl_month", function () { return apl.func.emptyValueCheck(mdl.prop.dl_month.value); }, "Salah input"),
                val8: apl.createValidator("save", "mdl_year", function () { return apl.func.emptyValueCheck(mdl.prop.tb_year.value); }, "Salah input"),

                tbl_load: function () {
                    activities.hr_employee_loan_installment_list(mdl.prop.id, function (arr) { mdl.prop.tbl.load(arr); }, apl.func.showError, "");
                },

                init: function () {
                    var d = new Date();
                    var m = d.getMonth();
                    var y = d.getFullYear();

                    mdl.prop.id = 0;

                    mdl.prop.dl_name.disabled = true;
                    mdl.prop.tb_date.disabled = true;
                    mdl.prop.tb_amount.disabled = true;
                    mdl.prop.tb_tenor.disabled = true;
                    mdl.prop.tb_angsuran.disabled = true;
                    mdl.prop.tb_note.disabled = true;
                    mdl.prop.dl_month.disabled = true;
                    mdl.prop.tb_year.disabled = true;
                    mdl.prop.cb_apporve.checked = false;
                    mdl.prop.tbl.clearAllRow();


                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function (parent_coa_id) {
                    mdl.prop.init();

                    mdl.showAdd("Tambah Data");

                },
                edit: function (id, s) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.prop.init();
                    mdl.prop.id = id;

                    if (s == 'A') {
                        mdl.prop.cb_apporve.disabled = false;
                        mdl.prop.tbl.Hide();
                    } else {
                        mdl.prop.cb_apporve.disabled = true;
                        mdl.prop.tbl_load();
                        mdl.prop.tbl.Show();
                    }

                    activities.hr_employee_loan_data(id,
                        function (data) {
                            mdl.prop.dl_name.value = data.employee_id;
                            mdl.prop.tb_date.value = data.loan_date;
                            mdl.prop.tb_amount.setValue(data.loan_amount);
                            mdl.prop.tb_tenor.value = data.tenor;
                            mdl.prop.tb_angsuran.setValue(data.installment);
                            mdl.prop.tb_note.value = data.note;
                            mdl.prop.dl_month.value = data.loan_start_month;
                            mdl.prop.tb_year.value = data.loan_start_year;
                            mdl.prop.cb_apporve.checked = data.approve_sts;
                            mdl.prop.dl_param.value = data.wageparam_id;

                            mdl.showEdit("Edit Data");
                            mdl.btnSave.hide();
                        }, apl.func.showError, ""
                    );
                },
                close: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                }
            },
           undefined,
            function () {
                if (apl.func.validatorCheck("save") && mdl.prop.cb_apporve.checked == true) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.hr_employee_loan_approve(mdl.prop.id, mdl.prop.close, apl.func.showError, "");
                }
            },
            undefined, "frm_page", "cover_content"
        );

        function get_installment(e) {
            var nilai = parseInt(mdl.prop.tb_amount.getIntValue() / mdl.prop.tb_tenor.getIntValue());
            mdl.prop.tb_angsuran.setValue(nilai);
        }

        var mdllis = apl.create_modal("mdllis", {

            tbl: apl.createTableWS.init("mdllis_tbl", [
                apl.createTableWS.column("loan_id", undefined, [apl.createTableWS.attribute("class", "edit")], function (d) { mdl.prop.edit(d.loan_id, 'A'); mdllis.hide(); }, undefined, "DIV", "d"),
                apl.createTableWS.column("employee_name"),
                apl.createTableWS.column("loan_amount", undefined, undefined, undefined, true),
                apl.createTableWS.column("tenor", undefined, undefined, undefined, true),
                apl.createTableWS.column("installment", undefined, undefined, undefined, true)
            ]),
            tbl_load: function () {
                activities.hr_employee_loan_unapprove_list(function (arr) { mdllis.prop.tbl.load(arr); }, apl.func.showError, "");
            },
            tambah: function () {
                mdllis.showAdd("Tambah Data");
                mdllis.prop.tbl_load();
            }
        },
            undefined, undefined, undefined, "frm_page", "cover_content"
        );


        window.addEventListener("load", function () {
            document.list_add = mdllis.prop.tambah;
            document.list_edit = mdl.prop.edit;

            mdl.prop.tb_amount.addEventListener("focusout", get_installment);
            mdl.prop.tb_tenor.addEventListener("focusout", get_installment);
            mdl.prop.cb_apporve.addEventListener("click", function (e) {
                if (e.target.checked) mdl.btnSave.show(); else mdl.btnSave.hide();
            });

        });

    </script>
</asp:Content>

