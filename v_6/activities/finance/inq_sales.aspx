<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/marketing/wuc_info_customer.ascx" TagPrefix="uc1" TagName="wuc_info_customer" %>

<script runat="server">
    public string apl_date, disabled_sts, branch_id;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        apl_date = a.cookieApplicationDateValue;

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
            <th>Kode Print</th>
            <td><input type="text" id="cari_kode"/></td>
            <td style="width:20px;"></td>
            <th>No.Invoice</th>
            <td><input type="text" id="cari_no" value="%"/></td>
        </tr>
        <tr>
            <th>Lunas</th>
            <td><input type="checkbox" id="cari_paid_sts"/></td>
            <td style="width:20px;"></td>
            <th>No.Penawaran</th>
            <td><input type="text" id="cari_nooffer" value="%"/></td>            
        </tr>
        <tr>
            <th colspan="3"></th>
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" value="%" size="50"/></td>
        </tr>
        <tr>
            <th></th>
            <td colspan="3"><div class="buttonCari" onclick="cari.load();">Cari</div></td>            
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>
    <uc1:wuc_info_customer runat="server" ID="mdl_info_customer" parent_id="frm_page" cover_id="mdl" />

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Invoice No.</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td><label id="mdl_date"></label></td>
                </tr>
                <tr>
                    <th>Rekening</th>
                    <td><label id="mdl_bill"></label></td>
                </tr>
                <tr>
                    <th>Term Of Payment</th>
                    <td><label id="mdl_top"></label></td>
                </tr>
                <tr>
                    <th>No PO</th>
                    <td><label id="mdl_po"></label></td>
                </tr>
                <tr>
                    <th>No AFPO</th>
                    <td><label id="mdl_afpo"></label></td>
                </tr>
            </table>
            <hr />
            <table class="formview" id="mdl_view1">
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note" readonly="readonly"></textarea></td>
                </tr>                
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_customer" style="text-decoration:underline;cursor:pointer;font-weight:bold;" onclick="mdl_info_customer.info(mdl.customer_id);"></label></td>
                </tr>
                <tr>
                    <th>Penawaran</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>                                
                                <th>No.Penawaran</th>
                                <th style="text-align:right;">Total</th>                                
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td><input type="text" id="mdl_value" size="20" style="text-align:right;" disabled="disabled"/></td>
                </tr>                
                <tr>
                    <th>ID Kirim</th>
                    <td><label id="mdl_schedule"></label></td>
                </tr>
                <tr>
                    <th>Invoice</th>
                    <td><input type="checkbox" id="mdl_invoice_sts" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Tgl.Doc.Kembali</th>
                    <td><label id="mdl_docreturndate"></label></td>
                </tr>
                <tr>
                    <th>Tanggal Bayar</th>
                    <td><label id="mdl_paid_date"></label></td>
                </tr>                
            </table>
            <div class="button_panel">
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_kode: apl.createNumeric("cari_kode", false),
            tb_no: apl.func.get("cari_no"),
            tb_nooffer: apl.func.get("cari_nooffer"),
            tb_customer: apl.func.get("cari_customer"),
            cb_paid: apl.func.get("cari_paid_sts"),
            fl: apl.func.get("cari_fr"),
            
            load: function () {
                var no = escape(cari.tb_no.value);
                var nooffer = escape(cari.tb_nooffer.value);
                var kp = escape(cari.tb_kode.value);
                var cust = escape(cari.tb_customer.value);
                cari.fl.src = "fin_sales_list.aspx?no=" + no + "&kf=" + kp + "&cust=" + cust + "&paid=" + cari.cb_paid.checked + "&branch=%&offer=" + nooffer;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                customer_id: 0,

                lb_no: apl.func.get("mdl_no"),
                lb_date: apl.func.get("mdl_date"),
                lb_bill: apl.func.get("mdl_bill"),
                lb_top: apl.func.get("mdl_top"),
                lb_nopo: apl.func.get("mdl_po"),
                lb_afpo: apl.func.get("mdl_afpo"),

                tb_note: apl.func.get("mdl_note"),
                lb_customer: apl.func.get("mdl_customer"),
                tb_value: apl.createNumeric("mdl_value", true),
                lb_schedule: apl.func.get("mdl_schedule"),
                cb_invoice: apl.func.get("mdl_invoice_sts"),
                lb_paiddate: apl.func.get("mdl_paid_date"),
                lb_docreturndate: apl.func.get("mdl_docreturndate"),

                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("offer_no"),
                    apl.createTableWS.column("grand_price", undefined, undefined, undefined, true)
                ]),
                tbl_load: function (id) {
                    activities.fin_sales_opr_list(id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },

                edit:function(id)
                {
                    activities.fin_sales_data(id,
                        function (data)
                        {
                            mdl.customer_id = data.customer_id;

                            mdl.lb_no.innerHTML = data.invoice_no;
                            mdl.lb_date.innerHTML = data.invoice_date;
                            mdl.lb_bill.innerHTML = data.bill_no + "-" + data.bill_name;
                            mdl.lb_top.innerHTML = data.term_of_payment;
                            mdl.lb_nopo.innerHTML = data.po_no;
                            mdl.lb_afpo.innerHTML = data.afpo_no;

                            mdl.tb_note.value = data.invoice_note;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.tb_value.setValue(data.grand_price);
                            mdl.lb_schedule.innerHTML = data.surat_jalan_id;
                            mdl.cb_invoice.checked = data.invoice_sts;
                            mdl.lb_paiddate.innerHTML = data.paid_date;
                            mdl.lb_docreturndate.innerHTML = data.document_return_date;

                            mdl.tbl_load(id);
                            mdl.showEdit("Inquery Invoice Sales");
                        }, apl.func.showError, ""
                    );
                    
                }
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () { document.list_edit = mdl.edit; });
    </script>
</asp:Content>

