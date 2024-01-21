<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<script runat="server">
    public _test.App a;
    public string tanggal,branch_id, disabled_sts;    
    
    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
        tanggal = a.cookieApplicationDateValue;        
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";
    }
    
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
            <th>Cabang</th>
            <td><select id="cari_branch" <%= disabled_sts %>></select></td>
        </tr>
        <tr>
            <th>No.</th>
            <td><input type="text" id="cari_no"/></td>
        </tr>
        <tr>
            <th>Sts.Bayar</th>
            <td><input type="checkbox" id="cari_paid"/></td>
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
                    <th>Tanggal</th>
                    <td><input type="text" id="mdl_date" size="10"/></td>
                </tr>
                <tr>
                    <th>Cabang</th>
                    <td><select id="mdl_branch" <%= disabled_sts %>></select></td>
                </tr>
                <tr>
                    <th>Broker</th>
                    <td><select id="mdl_broker"></select></td>
                </tr>
                <tr>
                    <th>No</th>
                    <td><input type="text" id="mdl_no" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Vendor</th>
                    <td><input type="text" id="mdl_vendor"/></td>
                </tr>
                <tr>
                    <th>Rekening</th>
                    <td><select id="mdl_bill"></select></td>
                </tr>
                <tr>
                    <th>Tipe</th>
                    <td><select id="mdl_type"></select></td>
                </tr>
                <tr>
                    <th>Jumlah</th>
                    <td><input type="text" id="mdl_amount" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>PPN %</th>
                    <td><input type="text" id="mdl_ppn" style="text-align:right;" size="3"/></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th>Tgl.Terima Dok.</th>
                    <td><input type="text" id="mdl_receivedoc" size="10"/></td>
                </tr>
                <tr>
                    <th>Sts.Bayar</th>
                    <td><input type="checkbox" id="mdl_paid"/></td>
                </tr>
                <tr>
                    <th>Tgl.Lunas</th>
                    <td><input type="text" id="mdl_paiddate" size="10"/></td>
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
            dl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list, undefined, undefined, true),
            tb_no: apl.func.get("cari_no"),
            cb_paid: apl.func.get("cari_paid"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var branch = escape(cari.dl_branch.value);
                var no = escape(cari.tb_no.value);
                var paid = (cari.cb_paid.checked) ? 1 : 0;
                cari.fl.src = "fin_transaction_vendor_list.aspx?no=" + no+"&paid="+paid+"&branch="+branch;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                transaction_vendor_id: 0,
                dl_branch:apl.createDropdownWS("mdl_branch",activities.dl_par_branch_list_1,undefined,undefined,true),
                dl_broker: apl.createDropdownWS("mdl_broker", activities.dl_opr_broker_list, undefined, undefined, true),
                tb_date: apl.createCalender("mdl_date"),
                tb_no: apl.func.get("mdl_no"),
                ac_vendor: apl.create_auto_complete_text("mdl_vendor", activities.ac_vendor),
                ddl_type: apl.createDropdownWS("mdl_type", activities.dl_transaction_vendor_type_list),
                tb_amount: apl.createNumeric("mdl_amount"),
                tb_note:apl.func.get("mdl_note"),
                cb_paid: apl.func.get("mdl_paid"),
                dl_bill: apl.createDropdownWS("mdl_bill", activities.dl_opr_vendor_bill_list, undefined, undefined, true, function () { var id = (mdl.ac_vendor.id == null || mdl.ac_vendor.id == "") ? 0 : mdl.ac_vendor.id;; return "vendor_id=" + id; }),
                tb_ppn: apl.createNumeric("mdl_ppn", true, 2),
                tb_receive_doc: apl.createCalender("mdl_receivedoc"),
                tb_paiddate: apl.createCalender("mdl_paiddate"),

                val_date: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Invalid input"),
                val_no: apl.createValidator("save", "mdl_no", function () { return apl.func.emptyValueCheck(mdl.tb_no.value); }, "Invalid input"),
                val_vendor: apl.createValidator("save", "mdl_vendor", function () { return apl.func.emptyValueCheck(mdl.ac_vendor.input.value); }, "Invalid input"),
                val_type: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.ddl_type.value); }, "Invalid input"),
                val_amount: apl.createValidator("save", "mdl_amount", function () { return apl.func.emptyValueCheck(mdl.tb_amount.value); }, "Invalid input"),
                val_note: apl.createValidator("save", "mdl_note", function () { return apl.func.emptyValueCheck(mdl.tb_note.value); }, "Invalid input"),
                val_bill: apl.createValidator("save", "mdl_bill", function () { return apl.func.emptyValueCheck(mdl.dl_bill.value); }, "Invalid input"),
                val_ppn: apl.createValidator("save", "mdl_ppn", function () { return apl.func.emptyValueCheck(mdl.tb_ppn.value); }, "Invalid input"),
                val_paid: apl.createValidator("save", "mdl_paiddate", function () { return mdl.cb_paid.checked && apl.func.emptyValueCheck(mdl.tb_paiddate.value); }, "Invalid input"),
                val_branch: apl.createValidator("save", "mdl_branch", function () { return apl.func.emptyValueCheck(mdl.dl_branch.value); }, "Invalid input"),
                val_broker: apl.createValidator("save", "mdl_broker", function () { return apl.func.emptyValueCheck(mdl.dl_broker.value); }, "Invalid input"),
                
                kosongkan: function () {                  
                    mdl.transaction_vendor_id = 0;
                    mdl.tb_date.value = "<%= tanggal %>";
                    mdl.tb_no.value = "";
                    mdl.ac_vendor.set_value("", "");
                    mdl.ddl_type.value = "";
                    mdl.tb_amount.value = "0";
                    mdl.tb_note.value = "";
                    mdl.cb_paid.checked = false;
                    mdl.dl_bill.clearItem();
                    mdl.tb_ppn.value = "0";
                    mdl.dl_branch.setValue('<%= branch_id  %>');
                    mdl.dl_broker.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Invoice - Tambah");
                },
                edit: function (id) {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat data...")
                    activities.fin_transaction_vendor_data(id,
                        function (data)
                        {
                            mdl.transaction_vendor_id = id;
                            mdl.tb_date.value = data.transaction_date;
                            mdl.tb_no.value = data.invoice_no;
                            mdl.ac_vendor.set_value(data.vendor_id, data.vendor_name);
                            mdl.ddl_type.value = data.transaction_type_id;
                            mdl.tb_amount.setValue(data.amount);
                            mdl.tb_note.value = data.note;
                            mdl.cb_paid.checked = data.paid_sts;
                            mdl.tb_ppn.setValue(data.ppn);
                            mdl.dl_branch.setValue(data.branch_id);
                            mdl.dl_broker.setValue(data.broker_id);
                            mdl.showEdit("Transaksi Vendor - Edit");
                            mdl.dl_bill.setValue(data.bill_id);
                            apl.func.hideSinkMessage();
                        },
                        apl.func.showError, ""
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
                    activities.fin_transaction_vendor_add(mdl.tb_no.value, mdl.ac_vendor.id, mdl.tb_date.value, mdl.ddl_type.value, mdl.tb_amount.getIntValue(), mdl.tb_note.value, mdl.cb_paid.checked,mdl.dl_bill.value,mdl.tb_ppn.value,mdl.tb_receive_doc.value,mdl.tb_paiddate.value,mdl.dl_branch.value,mdl.dl_broker.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.fin_transaction_vendor_edit(mdl.transaction_vendor_id, mdl.tb_no.value, mdl.ac_vendor.id, mdl.tb_date.value, mdl.ddl_type.value, mdl.tb_amount.getIntValue(), mdl.tb_note.value, mdl.cb_paid.checked, mdl.dl_bill.value, mdl.tb_ppn.value, mdl.tb_receive_doc.value, mdl.tb_paiddate.value,mdl.dl_branch.value,mdl.dl_broker.value, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus Data");
                    activities.fin_transaction_vendor_delete(mdl.transaction_vendor_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
            cari.dl_branch.setValue('<%= branch_id %>');
        });

    </script>
</asp:Content>

