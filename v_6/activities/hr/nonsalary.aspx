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
                    <th>Tanggal</th>
                    <td>
                        <input type="text" id="mdl_date" size="10" maxlength="10" readonly="readonly" /></td>
                </tr>
                <tr>
                    <th>Nama</th>
                    <td>
                        <input type="text" id="mdl_name" size="50" maxlength="50" /></td>
                </tr>
                <tr>
                    <th>Bulan</th>
                    <td>
                        <select id="mdl_month"></select></td>
                </tr>
                <tr>
                    <th>Tahun</th>
                    <td>
                        <input type="text" size="4" maxlength="4" id="mdl_year" /></td>
                </tr>
                <tr>
                    <th>Karyawan</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width: 25px">
                                    <div class="tambah" onclick="mdldtl.prop.tambah();"></div>
                                </th>
                                <th>Nama</th>
                                <th>Total</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Close" />

                <select id="mdl_cetak_type_mdl" style="float: right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="mdl.prop.print(document.getElementById('mdl_cetak_type_mdl').value);" style="float: right;" />
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdldtl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td>
                        <select id="mdldtl_name"></select>
                        <label id="mdldtl_name2"></label>
                    </td>
                </tr>
                <tr>
                    <th>Tgl.Masuk</th>
                    <td><label id="mdldtl_datein"></label></td>
                </tr>
                <tr>
                    <th>Jabatan</th>
                    <td><label id="mdldtl_jabatan"></label></td>
                </tr>
                <tr>
                    <th>Komp.Pengupahan</th>
                    <td>
                        <table class="gridView" id="mdldtl_tblk">
                            <tr>
                                <th>Keterangan</th>
                                <th>Nilai</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Rincian</th>
                    <td>
                        <table class="gridView" id="mdldtl_tbl">
                            <tr>
                                <th style="width: 25px">
                                    <div class="tambah" onclick="mdldtl1.prop.tambah();"></div>
                                </th>
                                <th>Parameter</th>
                                <th>Tipe</th>
                                <th>Nilai</th>
                                <th>Note</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Delete" />
                <input type="button" value="Close" />
                <select id="mdl_cetak_type" style="float: right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="mdldtl.prop.print(document.getElementById('mdl_cetak_type').value);" style="float: right;" />
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdldtl1">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Pengupahan</th>
                    <td>
                        <select id="mdldtl1_wageparam"></select>
                        <label id="mdldtl1_wageparam2"></label>
                    </td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td>
                        <input type="text" id="mdldtl1_nilai" size="20" maxlength="20" style="text-align: right" /></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td>
                        <input type="text" id="mdldtl1_total" size="3" maxlength="3" style="text-align: right" /></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td>
                        <textarea id="mdldtl1_note"></textarea></td>
                </tr>
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        let waktu = new Date();
        let cur_month = waktu.getMonth() + 1;
        let cur_year = waktu.getFullYear();

        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "nonsalary_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.create_modal("mdl",
            {
                id: 0,
                tb_date: apl.createCalender("mdl_date"),
                tb_name: apl.func.get("mdl_name"),
                dl_month: apl.createDropdownWS("mdl_month", activities.dl_list_month),
                tb_year: apl.func.get("mdl_year"),
                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("nonsalary_employee_id", undefined, [apl.createTableWS.attribute("class", "edit")], function (d) { mdldtl.prop.edit(d.nonsalary_employee_id, d.employee_name, d.employee_id); }, undefined, "DIV", "D"),
                    apl.createTableWS.column("employee_name"),
                    apl.createTableWS.column("total_salary", undefined, [apl.createTableWS.attribute("style", "text-align:right;")], undefined, true)
                ]),

                val1: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.prop.tb_name.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.prop.tb_date.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_month", function () { return apl.func.emptyValueCheck(mdl.prop.dl_month.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_year", function () { return apl.func.emptyValueCheck(mdl.prop.tb_year.value); }, "Salah input"),

                init: function () {
                    mdl.prop.id = 0;
                    mdl.prop.tb_name.value = "";
                    mdl.prop.tb_date.value = "";
                    mdl.prop.dl_month.value = "";
                    mdl.prop.tb_year.value = "";

                    mdl.prop.tbl.clearAllRow();
                    mdl.prop.tbl.Hide();

                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tbl_load: function () {
                    activities.hr_nonsalary_employee_list(mdl.prop.id, function (arr) { mdl.prop.tbl.load(arr); }, apl.func.showError, "");
                },
                tambah: function () {
                    mdl.prop.init();

                    mdl.showAdd("Tambah Data");

                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.prop.init();
                    mdl.prop.id = id;
                    mdl.prop.tbl_load();
                    mdl.prop.tbl.Show();

                    activities.hr_nonsalary_data(id,
                        function (data) {
                            mdl.prop.tb_name.value = data.nonsalary_name;
                            mdl.prop.tb_date.value = data.nonsalary_date;
                            mdl.prop.dl_month.value = data.month_issue;
                            mdl.prop.tb_year.value = data.year_issue;
                            mdl.showEdit("Edit Data");

                            if (data.month_issue >= cur_month && data.year_issue >= cur_year) {
                                mdl.btnSave.show();
                                mdl.btnDelete.show();
                            } else {
                                mdl.btnSave.hide();
                                mdl.btnDelete.hide();
                            }

                        }, apl.func.showError, ""
                    );
                },
                close: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                print: function (file_type) {
                    if (mdl.prop.id != 0) {
                        var fName = mdl.prop.tb_name.value;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=31&nonsalary_id=" + mdl.prop.id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menambah Data");
                    activities.hr_nonsalary_add(mdl.prop.tb_name.value, mdl.prop.dl_month.value, mdl.prop.tb_year.value, mdl.prop.tb_date.value,
                        function (id) {
                            mdl.prop.edit(id);
                        },
                        apl.func.showError, ""
                    );
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.hr_nonsalary_edit(mdl.prop.id, mdl.prop.tb_name.value, mdl.prop.dl_month.value, mdl.prop.tb_year.value, mdl.prop.tb_date.value, mdl.prop.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_nonsalary_delete(mdl.prop.id, mdl.prop.close, apl.func.showError, "");
            }, "frm_page", "cover_content"
        );

        var mdldtl = apl.create_modal("mdldtl",
            {
                nonsalary_employee_id: 0,
                employee_id: 0,

                lb_datein: apl.func.get("mdldtl_datein"),
                lb_jabatan:apl.func.get("mdldtl_jabatan"),
                lb_name: apl.func.get("mdldtl_name2"),
                dl_name: apl.createDropdownWS("mdldtl_name", activities.dl_employee, undefined, undefined, false, function () { return "employee_id not in(select employee_id from hr_nonsalary_employee where nonsalary_id=" + mdl.prop.id + ")" }),
                tbl: apl.createTableWS.init("mdldtl_tbl", [
                    apl.createTableWS.column("nonsalary_employee_wageparam_id", undefined, [apl.createTableWS.attribute("class", "edit")], function (d) { mdldtl1.prop.edit(d.nonsalary_employee_wageparam_id); }, undefined, "DIV", "D",
                        function (e, d) {
                            if (d.tetap_sts == true) e.style.display = "none"; else e.style.display = "";
                        }
                    ),
                    apl.createTableWS.column("wageparam_name"),
                    apl.createTableWS.column("type_name"),
                    apl.createTableWS.column("total_nilai", undefined, [apl.createTableWS.attribute("style", "text-align:right;")], undefined, true),
                    apl.createTableWS.column("note"),
                ]),
                tblk: apl.createTableWS.init("mdldtl_tblk", [
                   apl.createTableWS.column("wageparam_name"),
                    apl.createTableWS.column("nilai", undefined, [apl.createTableWS.attribute("style", "text-align:right;")], undefined, true)
                ]),

                var1: apl.createValidator("savedtl", "mdldtl_name", function () { return apl.func.emptyValueCheck(mdldtl.prop.dl_name.value) }, "Invalid entry"),

                tbl_load: function () {
                    //alert(mdldtl.prop.nonsalary_employee_id);
                    activities.hr_employee_wageparam_list(mdldtl.prop.employee_id, function (arr) { mdldtl.prop.tblk.load(arr); }, apl.func.showError, "");
                    activities.hr_nonsalary_employee_wageparam_list(mdldtl.prop.nonsalary_employee_id, function (arr) { mdldtl.prop.tbl.load(arr); }, apl.func.showError, "");
                },

                tambah: function () {
                    mdldtl.showAdd("Tambah Data");
                    mdldtl.prop.dl_name.setValue("");

                    mdldtl.prop.tbl.Hide();
                    mdldtl.prop.tblk.Hide();

                    mdldtl.prop.nonsalary_employee_id = 0;
                    mdldtl.prop.employee_id = 0;

                    mdldtl.prop.dl_name.Show();
                    mdldtl.prop.lb_name.Hide();

                    mdldtl.prop.lb_datein.innerHTML = "";
                    mdldtl.prop.lb_jabatan.innerHTML = "";

                },

                edit: function (nonsalary_employee_id, employee_name, employee_id) {

                    mdldtl.prop.nonsalary_employee_id = nonsalary_employee_id;
                    mdldtl.prop.lb_name.innerHTML = employee_name;
                    mdldtl.prop.employee_id = employee_id;

                    mdldtl.prop.tbl.Show();
                    mdldtl.prop.tblk.Show();

                    mdldtl.prop.dl_name.Hide();
                    mdldtl.prop.lb_name.Show();

                    mdldtl.prop.tbl_load();
                    activities.hr_employee_data(employee_id,
                        function (data) {
                            mdldtl.prop.lb_datein.innerHTML = data.date_in;
                            mdldtl.prop.lb_jabatan.innerHTML = data.position_name;
                        },
                        apl.func.showError, ""
                    );

                    mdldtl.showEdit("Edit Data");
                },
                close: function () {
                    mdldtl.hide();
                    mdl.prop.tbl_load();
                },
                print: function (file_type) {
                    if (mdldtl.prop.nonsalary_employee_id != 0) {
                        var fName = mdldtl.prop.lb_name.innerHTML + "_" + mdl.prop.tb_year.value + "-" + mdl.prop.dl_month.value;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=30&nonsalari_employee_id=" + mdldtl.prop.nonsalary_employee_id + "&pdfName=" + fName + "&fileType=" + file_type;
                        //alert("../../report/report_generator.ashx?ListID=30&nonsalari_employee_id=" + mdldtl.prop.nonsalary_employee_id + "&pdfName=" + fName + "&fileType=" + file_type);
                    }
                }
            },
            function () {
                if (apl.func.validatorCheck("savedtl")) {
                    activities.hr_nonsalary_employee_add(mdl.prop.id, mdldtl.prop.dl_name.value,
                        function (id) {
                            let i = mdldtl.prop.dl_name.selectedIndex;
                            mdldtl.prop.edit(id, mdldtl.prop.dl_name.options[i].text, mdldtl.prop.dl_name.value);
                            mdl.prop.tbl_load();
                        },
                        apl.func.showError, ""
                    );
                }
            }, undefined,
            function () {
                if (confirm("Yakin akan dihapus")) activities.hr_nonsalary_employee_delete(mdldtl.prop.nonsalary_employee_id, mdldtl.prop.close, apl.func.showError, "");
            }, "frm_page", "mdl"
        );

        var mdldtl1 = apl.create_modal("mdldtl1",
            {
                nonsalary_employee_wageparam_id: 0,

                dl_wageparam: apl.createDropdownWS("mdldtl1_wageparam", activities.dl_hr_wageparam, undefined, undefined, false, function () { return "wageparam_id not in (select wageparam_id from hr_nonsalary_employee_wageparam where nonsalary_employee_id=" + mdldtl.prop.nonsalary_employee_id + ")"; }),
                tb_nilai: apl.createNumeric("mdldtl1_nilai"),
                tb_total: apl.createNumeric("mdldtl1_total"),
                tb_note: apl.func.get("mdldtl1_note"),
                lb_wageparam: apl.createNumeric("mdldtl1_wageparam2"),

                val1: apl.createValidator("savedtl1", "mdldtl1_wageparam", function () { return (apl.func.emptyValueCheck(mdldtl1.prop.dl_wageparam.value) && mdldtl1.prop.nonsalary_employee_wageparam_id == 0); }, "Invalid input"),
                val2: apl.createValidator("savedtl1", "mdldtl1_nilai", function () { return apl.func.emptyValueCheck(mdldtl1.prop.tb_nilai.value); }, "Invalid input"),
                val3: apl.createValidator("savedtl1", "mdldtl1_total", function () { return apl.func.emptyValueCheck(mdldtl1.prop.tb_total.value); }, "Invalid input"),

                init: function () {

                    mdldtl1.prop.nonsalary_employee_wageparam_id = 0;
                    mdldtl1.prop.dl_wageparam.setValue("");
                    mdldtl1.prop.tb_nilai.value = "";
                    mdldtl1.prop.tb_total.value = "1";
                    mdldtl1.prop.tb_note.value = "";
                    mdldtl1.prop.lb_wageparam.innerHTML = "";

                    mdldtl1.prop.dl_wageparam.Show();
                    mdldtl1.prop.lb_wageparam.Hide();

                    apl.func.validatorClear("savedtl1");
                    apl.func.hideSinkMessage();

                },

                tambah: function () {
                    mdldtl1.prop.init();
                    mdldtl1.showAdd("Tambah Data");


                },
                edit: function (id) {
                    mdldtl1.prop.init();
                    mdldtl1.prop.nonsalary_employee_wageparam_id = id;
                    activities.hr_nonsalary_employee_wageparam_data(id,
                        function (data) {

                            mdldtl1.prop.lb_wageparam.innerHTML = data.wageparam_name;
                            mdldtl1.prop.tb_nilai.setValue(data.nilai);
                            mdldtl1.prop.tb_total.setValue(data.total);
                            mdldtl1.prop.tb_note.value = data.note;

                            mdldtl1.prop.dl_wageparam.Hide();
                            mdldtl1.prop.lb_wageparam.Show();

                            mdldtl1.showEdit("Edit Data");
                        },
                        apl.func.showError, ""
                    );
                },
                close: function () {
                    mdldtl1.hide();
                    mdldtl.prop.tbl_load();
                    mdl.prop.tbl_load();
                }
            },
            function () {
                if (apl.func.validatorCheck("savedtl1")) activities.hr_nonsalary_employee_wageparam_add(mdldtl.prop.nonsalary_employee_id, mdldtl1.prop.dl_wageparam.value, mdldtl1.prop.tb_total.getIntValue(), mdldtl1.prop.tb_nilai.getIntValue(), mdldtl1.prop.tb_note.value, mdldtl1.prop.close, apl.func.showError, "");
            },
            function () {
                if (apl.func.validatorCheck("savedtl1")) activities.hr_nonsalary_employee_wageparam_edit(mdldtl1.prop.nonsalary_employee_wageparam_id, mdldtl1.prop.tb_total.getIntValue(), mdldtl1.prop.tb_nilai.getIntValue(), mdldtl1.prop.tb_note.value, mdldtl1.prop.close, apl.func.showError, "");
            },
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_nonsalary_employee_wageparam_delete(mdldtl1.prop.nonsalary_employee_wageparam_id, mdldtl1.prop.close, apl.func.showError, "");
            }, "frm_page", "mdldtl"
        );

        window.addEventListener("load", function () {
            document.list_add = mdl.prop.tambah;
            document.list_edit = mdl.prop.edit;
        });
    </script>
</asp:Content>

