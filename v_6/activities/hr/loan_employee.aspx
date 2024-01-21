<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    public string param_pot;
    void Page_Load()
    {
        string strSQL = "select * from (select Nilai from appParameter where kode='paramcutsal')a";

        _test._DBcon c = new _test._DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            param_pot = row["nilai"].ToString();
        }
        
        //param_pot = "7";
    }
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
                        <select id="mdl_param"></select></td>
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
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "loan_employee_list.aspx?name=" + name;
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
                dl_param: apl.createDropdownWS("mdl_param", activities.dl_hr_wageparam, undefined, undefined, true, function () { return " wageparam_id=<%= param_pot %>"; }),


                val1: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.prop.dl_name.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.prop.tb_date.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_amount", function () { return apl.func.emptyValueCheck(mdl.prop.tb_amount.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_tenor", function () { return apl.func.emptyValueCheck(mdl.prop.tb_tenor.value); }, "Salah input"),
                val5: apl.createValidator("save", "mdl_installment", function () { return apl.func.emptyValueCheck(mdl.prop.tb_angsuran.value); }, "Salah input"),
                val6: apl.createValidator("save", "mdl_note", function () { return apl.func.emptyValueCheck(mdl.prop.tb_note.value); }, "Salah input"),
                val7: apl.createValidator("save", "mdl_month", function () { return apl.func.emptyValueCheck(mdl.prop.dl_month.value); }, "Salah input"),
                val8: apl.createValidator("save", "mdl_year", function () { return apl.func.emptyValueCheck(mdl.prop.tb_year.value); }, "Salah input"),
                val9: apl.createValidator("save", "mdl_param", function () { return apl.func.emptyValueCheck(mdl.prop.dl_param.value); }, "Salah input"),

                init: function () {
                    var d = new Date();
                    var m = d.getMonth();
                    var y = d.getFullYear();

                    mdl.prop.id = 0;

                    mdl.prop.dl_name.value = "";
                    mdl.prop.tb_date.value = "";
                    mdl.prop.tb_amount.value = "";
                    mdl.prop.tb_tenor.value = "1";
                    mdl.prop.tb_angsuran.value = "";
                    mdl.prop.tb_note.value = "";
                    mdl.prop.dl_month.value = m + 1;
                    mdl.prop.tb_year.value = y;


                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function (parent_coa_id) {
                    mdl.prop.init();

                    mdl.showAdd("Tambah Data");

                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.prop.init();
                    mdl.prop.id = id;

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
                            mdl.prop.dl_param.setValue(data.wageparam_id);

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
                    activities.hr_employee_loan_add(mdl.prop.dl_name.value, mdl.prop.tb_date.value, mdl.prop.tb_note.value, mdl.prop.tb_tenor.getIntValue(), mdl.prop.tb_amount.getIntValue(), mdl.prop.dl_month.value, mdl.prop.tb_year.getIntValue(), mdl.prop.tb_angsuran.getIntValue(),mdl.prop.dl_param.value, mdl.prop.close, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.hr_employee_loan_edit(mdl.prop.id, mdl.prop.dl_name.value, mdl.prop.tb_date.value, mdl.prop.tb_note.value, mdl.prop.tb_tenor.getIntValue(), mdl.prop.tb_amount.getIntValue(), mdl.prop.dl_month.value, mdl.prop.tb_year.getIntValue(), mdl.prop.tb_angsuran.getIntValue(), mdl.prop.dl_param.value, mdl.prop.close, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) activities.hr_employee_loan_delete(mdl.prop.id, mdl.prop.close, apl.func.showError, "");
            }, "frm_page", "cover_content"
        );

        function get_installment(e) {
            var nilai = parseInt(mdl.prop.tb_amount.getIntValue() / mdl.prop.tb_tenor.getIntValue());
            mdl.prop.tb_angsuran.setValue(nilai);
        }

        window.addEventListener("load", function () {
            document.list_add = mdl.prop.tambah;
            document.list_edit = mdl.prop.edit;

            mdl.prop.tb_amount.addEventListener("focusout", get_installment);
            mdl.prop.tb_tenor.addEventListener("focusout", get_installment);

        });

    </script>
</asp:Content>

