<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/marketing/wuc_info_customer.ascx" TagPrefix="uc1" TagName="wuc_info_customer" %>

<script runat="server">
    public string apl_date, disabled_sts, branch_id, style_print;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        apl_date = a.cookieApplicationDateValue;

        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";
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
            <th>No.Proforma</th>
            <td>
                <input type="text" id="cari_no" value="%" /></td>
        </tr>
        <tr>
            <th>No.Penawaran</th>
            <td>
                <input type="text" id="cari_nooffer" value="%" /></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td>
                <input type="text" id="cari_customer" value="%" size="50" /></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="buttonCari" onclick="cari.load();">Cari</div>
            </td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fr"></iframe>
    <uc1:wuc_info_customer runat="server" ID="mdl_info_customer" parent_id="frm_page" cover_id="mdl" />
    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table>
                <tr>
                    <th>Proforma No.</th>
                    <td>
                        <label id="mdl_no"></label>
                    </td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td>
                        <input type="text" id="mdl_date" size="10" /></td>
                </tr>
                <tr>
                    <th>Rekening</th>
                    <td>
                        <select id="mdl_bill"></select></td>
                </tr>
                <tr>
                    <th>Term Of Payment</th>
                    <td>
                        <select id="mdl_top" style="float: left;"></select>
                        <input type="text" id="mdl_top_date" size="10" style="float: left;" />
                        <input type="text" id="mdl_top_day" size="3" maxlength="3" style="float: left; text-align: right;" />
                    </td>
                </tr>
                <tr>
                    <th>No PO</th>
                    <td>
                        <input type="text" id="mdl_po" size="50" maxlength="50" /></td>
                </tr>
                <tr>
                    <th>No AFPO</th>
                    <td>
                        <input type="text" id="mdl_afpo" size="50" maxlength="50" /></td>
                </tr>
            </table>
            <hr />
            <table class="formview" id="mdl_view1">
                <tr>
                    <th>Customer</th>
                    <td>
                        <label id="mdl_customer" style="text-decoration: underline; cursor: pointer; font-weight: bold;" onclick="mdl_info_customer.info(mdl.customer_id);"></label>
                    </td>
                </tr>
                <tr>
                    <th>Penawaran</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width: 25px">
                                    <div class="tambah" onclick="mdl.tambah_service();"></div>
                                </th>
                                <th>No.Penawaran</th>
                                <th>Total</th>
                                <th>Fee</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td>
                        <input type="text" id="mdl_value" size="20" style="text-align: right;" disabled /></td>
                </tr>
                <tr>
                    <th><span title="Daftar item yang terkena pph 21" style="text-decoration: underline; cursor: pointer" onclick="mdl_item.load()">PPH</span></th>
                    <td>
                        <input type="checkbox" id="mdl_pph_sts" /></td>
                </tr>
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Close" />
                <input type="button" value="Print" style="float: right;" onclick="mdl.print();" />
            </div>
            <label style="font-size: smaller; font-weight: bold;">NB: simpan sebelum dan sesudah mencetak</label>
        </fieldset>
    </div>

    <div id="mdl_sales">
        <fieldset>
            <table class="formview">
                <tr>
                    <th>No.Penawaran</th>
                    <td>
                        <input type="text" id="mdl_sales_no" size="50" maxlength="50" /></td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <div class="buttonCari" onclick="mdl_sales.load();">Cari</div>
                    </td>
                </tr>
            </table>

            <iframe class="frameList" id="mdl_sales_fr"></iframe>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_no: apl.func.get("cari_no"),
            tb_nooffer: apl.func.get("cari_nooffer"),
            tb_customer: apl.func.get("cari_customer"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var no = escape(cari.tb_no.value);
                var nooffer = escape(cari.tb_nooffer.value);
                var cust = escape(cari.tb_customer.value);
                cari.fl.src = "fin_proforma_sales_list.aspx?no=" + no + "&cust=" + cust + "&offer=" + nooffer;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                proforma_sales_id: 0,
                customer_id: 0,
                an_id: 0,
                v1: apl.func.get("mdl_view1"),
                lb_no: apl.func.get("mdl_no"),
                tb_date: apl.createCalender("mdl_date"),
                dl_top: apl.createDropdownWS("mdl_top", activities.dl_term_of_payment_list),
                tb_top_date: apl.createCalender("mdl_top_date"),
                tb_top_day: apl.createNumeric("mdl_top_day"),
                tb_po: apl.func.get("mdl_po"),
                tb_afpo: apl.func.get("mdl_afpo"),
                dl_bill: apl.createDropdownWS("mdl_bill", activities.dl_bill_list),
                lb_customer: apl.func.get("mdl_customer"),
                tb_value: apl.createNumeric("mdl_value"),
                cb_pph: apl.func.get("mdl_pph_sts"),

                val_bill: apl.createValidator("save", "mdl_bill", function () { return apl.func.emptyValueCheck(mdl.dl_bill.value); }, "Salah input"),
                val_no: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Salah input"),
                val_date: apl.createValidator("save", "mdl_top", function () { return apl.func.emptyValueCheck(mdl.dl_top.value); }, "Salah input"),
                val_top_date: apl.createValidator("save", "mdl_top_date", function () { return mdl.dl_top.value == "1" && apl.func.emptyValueCheck(mdl.tb_top_date.value); }, "Salah input"),
                val_top_day: apl.createValidator("save", "mdl_top_day", function () { return mdl.dl_top.value == "2" && apl.func.emptyValueCheck(mdl.tb_top_day.value); }, "Salah input"),

                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "hapus")],
                        function (data) {
                            if (confirm("Yakin akan dihapus?")) activities.fin_proforma_sales_opr_delete(mdl.proforma_sales_id, data.sales_id, function () { mdl.edit(mdl.proforma_sales_id); }, apl.func.showError, "");
                        }, undefined, undefined
                    ),
                    apl.createTableWS.column("offer_no"),
                    apl.createTableWS.column("grand_price", undefined, undefined, undefined, true),
                    apl.createTableWS.column("fee", undefined, undefined, undefined, true)
                ]),
                tbl_load: function () {
                    activities.fin_proforma_sales_opr_list(mdl.proforma_sales_id, function (arr) { mdl.tbl.load(arr); }, apl.func.showError, "");
                },
                kosongkan: function () {
                    mdl.v1.Hide();

                    mdl.proforma_sales_id = 0;
                    mdl.customer_id = 0;
                    mdl.an_id = 0;

                    //mdl.lb_no.innerHTML = "";
                    mdl.tb_date.value = "<%= apl_date %>";
                    mdl.dl_top.value = "";
                    mdl.tb_po.value = "";
                    mdl.tb_afpo.value = "";

                    mdl.lb_customer.innerHTML = "";
                    mdl.tb_value.value = "";
                    //mdl.tb_fee.value = "";
                    mdl.dl_bill.value = "";
                    //mdl.lb_surat_jalan.innerHTML = "";
                    //mdl.tb_note.value = "";

                    //mdl.cb_paid.checked = false;
                    //mdl.tb_paiddate.value = "";
                    //mdl.cb_send.checked = false;
                    mdl.cb_pph.checked = false;
                    //mdl.cb_invoice.checked = false;

                    //mdl.cb_document_return.checked = false;
                    //mdl.set_document_return(false, "");
                    //mdl.tb_fee_payment.setValue(0);
                    //mdl.tb_fee_date.value = "";
                    //mdl.lb_document_return_date_exp.innerHTML = "";
                    //mdl.tb_amount_cut.value = "0";

                    apl.func.hideSinkMessage();
                    apl.func.validatorClear("save");
                    mdl.top_change();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Service - Tambah");
                },
                edit: function (id) {
                    mdl.kosongkan()
                    apl.func.showSinkMessage("Memuat data");
                    mdl.v1.Show();

                    mdl.proforma_sales_id = id;
                    mdl.tbl_load();

                    apl.func.hideSinkMessage();
                    
                    activities.fin_proforma_sales_data(id,
                        function (data) {

                            mdl.tb_date.value = data.proforma_date;
                            mdl.lb_no.innerHTML = data.proforma_no;
                            mdl.dl_top.value = data.term_of_payment_id;
                            mdl.tb_top_date.value = data.str_top_value;
                            mdl.tb_top_day.value = data.str_top_value;
                            mdl.tb_po.value = data.po_no;
                            mdl.tb_afpo.value = data.afpo_no;

                            mdl.top_change();
                            mdl.tb_top_date.value = data.str_top_value;
                            mdl.tb_top_day.value = data.str_top_value;

                            mdl.dl_bill.value = data.bill_id;
                            mdl.customer_id = data.customer_id;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.cb_pph.checked = data.pph_sts;
                            mdl.tb_value.setValue(data.grand_price);

                            //alert("data: "+JSON.stringify(data));
                            mdl.showEdit("Service - Edit")
                        }, apl.func.showError, ""
                    )
                    /*
                    mdl.tbl_load();
                    activities.fin_sales_data(id,
                        function (data) {
                     
                     mdl.v1.Show();
                            mdl.customer_id = data.customer_id;
                            mdl.an_id = data.an_id;

                            mdl.lb_no.innerHTML = data.invoice_no;
                            mdl.tb_date.value = data.invoice_date;
                            mdl.dl_top.value = data.term_of_payment_id;
                            mdl.tb_po.value = data.po_no;
                            mdl.tb_afpo.value = data.afpo_no;

                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.tb_value.setValue(data.grand_price);
                            mdl.tb_fee.setValue(data.fee);

                            mdl.top_change();
                            mdl.tb_top_date.value = data.str_top_value;
                            mdl.tb_top_day.value = data.str_top_value;
                            mdl.dl_bill.value = data.bill_id;
                            var str_surat = (data.surat_jalan_id == 0) ? "" : "(" + data.surat_jalan_id + ")";
                            //mdl.lb_surat_jalan.innerHTML = "Cetak Surat Jalan " + str_surat;
                            //mdl.tb_note.value = data.invoice_note;

                            //mdl.cb_paid.checked = data.paid_sts;
                            //mdl.tb_paiddate.value = data.paid_date;

                            //mdl.cb_send.checked = data.send_sts;
                            mdl.cb_pph.checked = data.pph_sts;
                            mdl.cb_invoice.checked = data.invoice_sts;
                            //mdl.cb_document_return.checked = data.document_return_sts;
                            //mdl.set_document_return(data.document_return_sts, data.document_return_date);

                            //mdl.tb_fee_payment.setValue(data.fee_payment);
                            //mdl.tb_fee_date.value = data.fee_date;
                            //mdl.lb_document_return_date_exp.innerHTML = data.document_return_date_exp;
                            //mdl.tb_amount_cut.setValue(data.amount_cut);

                            mdl.showEdit("Service - Edit")
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                    */
                },
                get_term_of_payment_value: function () {
                    var nilai;
                    switch (mdl.dl_top.value) {
                        case '1':
                            nilai = mdl.tb_top_date.value;
                            break;
                        case '2':
                            nilai = mdl.tb_top_day.value;
                            break;
                        default:
                            nilai = '0';
                            break;
                    }
                    return nilai;
                },
                select: function (sales_id) {
                    mdl_sales.hide();
                    //var data = {
                    //    tanggal: mdl.tb_date.value,
                    //    top: mdl.dl_top.value,
                    //    po: mdl.tb_po.value,
                    //    afpo: mdl.tb_afpo.value,
                    //    topvalue: mdl.get_term_of_payment_value(),
                    //    bill:mdl.dl_bill.value
                    //}
                    //alert(JSON.stringify(data));
                    activities.fin_proforma_sales_add(mdl.proforma_sales_id, mdl.tb_date.value, mdl.dl_top.value, mdl.tb_po.value, mdl.tb_afpo.value, mdl.get_term_of_payment_value(), mdl.dl_bill.value, sales_id,
                        function (id) {
                            mdl.edit(id);
                        },
                        apl.func.showError, ""
                    );
                    //activities.fin_sales_add(mdl.proforma_sales_id, id, mdl.tb_date.value, mdl.dl_top.value, mdl.tb_po.value, mdl.tb_afpo.value, mdl.get_term_of_payment_value(), mdl.dl_bill.value,
                    //    function (id) {
                    //        mdl.edit(id);
                    //    }, apl.func.showError, ""
                    //);
                },
                top_change: function () {
                    mdl.tb_top_date.value = "";
                    mdl.tb_top_day.value = "";

                    switch (mdl.dl_top.value) {
                        case '1': //hari
                            mdl.tb_top_date.Show();
                            mdl.tb_top_day.Hide();
                            break;
                        case '2'://tanggal
                            mdl.tb_top_date.Hide();
                            mdl.tb_top_day.Show();
                            break;
                        default:
                            mdl.tb_top_date.Hide();
                            mdl.tb_top_day.Hide();
                            break;
                    }
                },
                tambah_service: function () {
                    if (apl.func.validatorCheck("save")) mdl_sales.open(mdl.customer_id, mdl.an_id);
                },
                print: function () {
                    var fname = apl.func.formatFileName(mdl.lb_customer.innerHTML + "_" + mdl.lb_no.innerHTML);
                    window.location = "../../report/report_generator.ashx?ListID=34&proforma_sales_id=" + mdl.proforma_sales_id + "&pdfName=" + fname;
                },
                cetak_surat_jalan: function () {
                    activities.fin_sales_generate_schedule_print(mdl.proforma_sales_id,
                        function () {
                            fName = "surat_tanda_terima_sales_" + mdl.lb_customer.innerHTML;
                            fName = window.escape(fName.replace(/ /gi, "_"));
                            window.location = "../../report/report_generator.ashx?ListID=7&proforma_sales_id=" + mdl.proforma_sales_id + "&pdfName=" + fName;
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                mdl.tambah_service();
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    //alert(mdl.get_term_of_payment_value());
                    //alert(mdl.cb_pph.checked);
                    activities.fin_proforma_sales_edit(mdl.proforma_sales_id, mdl.tb_date.value, mdl.dl_top.value, mdl.tb_po.value, mdl.tb_afpo.value, mdl.get_term_of_payment_value(), mdl.dl_bill.value, mdl.cb_pph.checked,
                        function () {
                            mdl.edit(mdl.proforma_sales_id);
                            cari.fl_refresh();
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    //activities.fin_sales_delete(mdl.proforma_sales_id, function () { mdl.hide(); cari.fl_refresh(); }, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

            var mdl_sales = apl.createModal("mdl_sales",
                {
                    type: 1,
                    customer_id: 0,
                    an_id: 0,
                    tb_no: apl.func.get("mdl_sales_no"),
                    fr: apl.func.get("mdl_sales_fr"),
                    open: function (customer_id, an_id) {
                        mdl_sales.customer_id = customer_id;
                        mdl_sales.an_id = an_id;
                        mdl_sales.tb_no.value = "";
                        mdl_sales.fr.src = "";
                        mdl_sales.showAdd("Pilih Penawaran");
                    },
                    load: function () {
                        var no = window.escape(mdl_sales.tb_no.value);
                        mdl_sales.fr.src = "fin_proforma_sales_opr_apporved_list.aspx?no=" + no + "&custid=" + mdl_sales.customer_id + "&anid=" + mdl_sales.an_id + "&branch=<%= branch_id %>";
                    }
                }, undefined, undefined, undefined, "frm_page", "mdl"
        );


                window.addEventListener("load", function () {
                    mdl.dl_top.addEventListener("change", mdl.top_change);
                    document.list_select = mdl.select;
                    document.list_add = mdl.tambah;
                    document.list_edit = mdl.edit;
                });
    </script>
</asp:Content>

