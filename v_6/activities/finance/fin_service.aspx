<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<%@ Register Src="~/activities/marketing/wuc_info_customer.ascx" TagPrefix="uc1" TagName="wuc_info_customer" %>
<%@ Register Src="~/activities/finance/wuc_claim_debt.ascx" TagPrefix="uc1" TagName="wuc_claim_debt" %>



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
            <th>Cabang</th>
            <td><select id="cari_branch" <%= disabled_sts %>></select></td>
            <td style="width:20px;"></td>
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
    <div id="mdl"> 
        <fieldset>
            <legend></legend>
            <table>
                <tr>
                    <th>Invoice No.</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td><input type="text" id="mdl_date" size="10"/></td>
                </tr>
                <tr>
                    <th>Rekening</th>
                    <td><select id="mdl_bill"></select></td>
                </tr>
                <tr>
                    <th>Term Of Payment</th>
                    <td>
                        <select id="mdl_top" style="float:left;"></select>
                        <input type="text" id ="mdl_top_date" size="10" style="float:left;"/>
                        <input type="text" id="mdl_top_day" size="3" maxlength="3" style="float:left;text-align:right;"/>
                    </td>
                </tr>
                <tr>
                    <th>No PO</th>
                    <td><input type="text"  id="mdl_po"  size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>No AFPO</th>
                    <td><input type="text"  id="mdl_afpo"  size="50" maxlength="50"/></td>
                </tr>                
            </table>
            <hr />
            <table class="formview" id="mdl_view1">
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
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
                                <th style="width:25px"><div class="tambah" onclick="mdl.tambah_service();"></div></th>
                                <th>No.Penawaran</th>
                                <th>Total</th>
                                <th>Fee</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Nilai</th>
                    <td><input type="text" id="mdl_value" size="20" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Fee</th>
                    <td><input type="text" id="mdl_fee" size="20" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Kirim</th>
                    <td>
                        <input type="checkbox" id="mdl_send_sts" style="display:none;"/>
                        <a style="text-decoration:underline;cursor:pointer;font-weight:bold;" onclick="mdl.cetak_surat_jalan();" id="mdl_surat_jalan">Cetak Surat Jalan</a>
                    </td>
                </tr>
                <tr>
                    <th><span title="Daftar item yang terkena pph 21" style="text-decoration:underline;cursor:pointer" onclick="mdl_item.load()">PPH</span></th>
                    <td><input type="checkbox" id="mdl_pph_sts" /></td>
                </tr>
                <tr>
                    <th>Invoice</th>
                    <td><input type="checkbox" id="mdl_invoice_sts" /></td>
                </tr>
                <tr>
                    <th>Sts.Batal</th>
                    <td><input type="checkbox" id="mdl_cancel_sts" /></td>
                </tr>
                <tr>
                    <th>Sts.Dokumen Balik</th>
                    <td><input type="checkbox" id="mdl_document_return_sts" style="float:left;"/></td>
                </tr>
                <tr>
                    <th>Tgl.Dok.Balik</th>
                    <td><input type="text" id="mdl_document_return_date" size="10" style="float:left;"/> Tgl.di Expedisi: <span id="mdl_document_return_data_exp" onclick="mdl.tb_document_return_date.value=mdl.lb_document_return_date_exp.innerHTML;" style="cursor:pointer;font-weight:bold;"></span></td>
                </tr>
                <tr>
                    <th>Penagihan</th>
                    <td>
                        <div class="tambah" title="Input penagihan" style="float:left;" onclick="document.mdl_claim_debt.open(mdl.invoice_service_id)"></div>
                        <a style="font-weight:bold;cursor:pointer;text-decoration:underline;" onclick="document.mdl_claim_debt_list.open(mdl.invoice_service_id)">Riwayat Penagihan</a>
                    </td>
                </tr>                
                <tr>
                    <th>Sts.Bayar</th>
                    <td><input type="checkbox" id="mdl_paid"/></td>
                </tr>
                <tr>
                    <th>Tanggal Bayar</th>
                    <td><input type="text" id="mdl_paid_date" size="10"/></td>
                </tr>
                <tr>
                    <th>Potongan</th>
                    <td><input type="text" id="mdl_amount_cut" size="20" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Pembayaran Fee</th>
                    <td><input type="text" id="mdl_fee_payment" size="20" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Tgl.Bayar Fee</th>
                    <td><input type="text" id="mdl_fee_date" size="10"/></td>
                </tr>
            </table>

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Close"/>
                <input type="button" value="Print" style="float:right;" onclick="mdl.print();"/>
            </div>
            <label style="font-size:smaller;font-weight:bold;">NB: simpan sebelum dan sesudah mencetak</label>
        </fieldset>
    </div>

    <div id="mdl_service">
        <fieldset>
            <table class="formview">
                <tr>
                    <th>No.Penawaran</th>
                    <td><input type="text" id="mdl_service_no" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdl_service.load();">Cari</div></td>
                </tr>
            </table>

            <iframe class="frameList" id="mdl_service_fr"></iframe>
            
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_item">
        <fieldset>
            <legend></legend>
            <table class="gridView" id="mdl_item_tbl">
                <tr>
                    <th>Item</th>
                    <th style="width:50px;">PPH 23</th>
                </tr>
            </table>

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

    <uc1:wuc_claim_debt runat="server" ID="mdl_claim_debt" parent_id="frm_page" cover_id="mdl" fin_type_id="2"/>

    

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_kode: apl.createNumeric("cari_kode",false),
            tb_no: apl.func.get("cari_no"),
            tb_nooffer: apl.func.get("cari_nooffer"),
            tb_customer: apl.func.get("cari_customer"),
            cb_paid: apl.func.get("cari_paid_sts"),
            fl: apl.func.get("cari_fr"),
            dl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            load: function () {
                var no = escape(cari.tb_no.value);
                var nooffer = escape(cari.tb_nooffer.value);
                var cust = escape(cari.tb_customer.value);
                cari.fl.src = "fin_service_list.aspx?no=" + no + "&kf=" + cari.tb_kode.value + "&cust=" + cust + "&paid=" + cari.cb_paid.checked + "&branch=" + cari.dl_branch.value + "&offer=" + nooffer;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                invoice_service_id: 0,
                customer_id: 0,
                an_id: 0,
                v1:apl.func.get("mdl_view1"),
                lb_no: apl.func.get("mdl_no"),
                tb_date: apl.createCalender("mdl_date"),
                dl_top: apl.createDropdownWS("mdl_top", activities.dl_term_of_payment_list),
                tb_top_date: apl.createCalender("mdl_top_date"),
                tb_top_day: apl.createNumeric("mdl_top_day"),
                tb_po: apl.func.get("mdl_po"),
                tb_afpo: apl.func.get("mdl_afpo"),
                dl_bill:apl.createDropdownWS("mdl_bill",activities.dl_bill_list),
                lb_customer:apl.func.get("mdl_customer"),
                tb_value: apl.createNumeric("mdl_value"),
                tb_fee: apl.createNumeric("mdl_fee"),
                cb_paid: apl.func.get("mdl_paid"),
                cb_send: apl.func.get("mdl_send_sts"),
                cb_pph: apl.func.get("mdl_pph_sts"),
                cb_invoice: apl.func.get("mdl_invoice_sts"),
                tb_paiddate: apl.createCalender("mdl_paid_date"),
                lb_surat_jalan: apl.func.get("mdl_surat_jalan"),
                tb_note: apl.func.get("mdl_note"),
                cb_document_return: (function () {
                    var _o = apl.func.get("mdl_document_return_sts");
                    _o.addEventListener("click", function ()
                    {
                        mdl.tb_document_return_date.value = "";
                        mdl.tb_document_return_date.disabled = !mdl.cb_document_return.checked;
                        mdl.tb_document_return_date.show_popup(mdl.cb_document_return.checked);                        
                    });
                    return _o;
                })(),
                tb_document_return_date: apl.createCalender("mdl_document_return_date"),
                tb_fee_payment: apl.createNumeric("mdl_fee_payment", true),
                tb_fee_date: apl.createCalender("mdl_fee_date"),
                lb_document_return_date_exp: apl.func.get("mdl_document_return_data_exp"),
                tb_amount_cut:apl.createNumeric("mdl_amount_cut"),

                val_bill: apl.createValidator("save", "mdl_bill", function () { return apl.func.emptyValueCheck(mdl.dl_bill.value); }, "Salah input"),
                val_no: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Salah input"),
                val_date: apl.createValidator("save", "mdl_top", function () { return apl.func.emptyValueCheck(mdl.dl_top.value); }, "Salah input"),
                val_top_date: apl.createValidator("save", "mdl_top_date", function () { return mdl.dl_top.value=="1" && apl.func.emptyValueCheck(mdl.tb_top_date.value); }, "Salah input"),
                val_top_day: apl.createValidator("save", "mdl_top_day", function () { return mdl.dl_top.value == "2" && apl.func.emptyValueCheck(mdl.tb_top_day.value); }, "Salah input"),
                val_paiddate: apl.createValidator("save", "mdl_paid_date", function () { return mdl.cb_paid.checked && apl.func.emptyValueCheck(mdl.tb_paiddate.value); }, "Salah input"),
                val_docretdate: apl.createValidator("save", "mdl_document_return_date", function () { return mdl.cb_document_return.checked && apl.func.emptyValueCheck(mdl.tb_document_return_date.value); }, "Salah input"),
                val_feepayment: apl.createValidator("save", "mdl_fee_payment", function () { return apl.func.emptyValueCheck(mdl.tb_fee_payment.value); }, "Salah input"),
                val_fee_date: apl.createValidator("save", "mdl_fee_date", function () { return apl.func.emptyValueCheck(mdl.tb_fee_date.value) && mdl.tb_fee_payment.getIntValue() > 0; }, "Salah input"),
                val_amount_cut: apl.createValidator("save", "mdl_amount_cut", function () { return apl.func.emptyValueCheck(mdl.tb_amount_cut.value); }, "Salah input"),

                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "hapus")],
                        function (data) {
                            if (confirm("Yakin akan dihapus?")) activities.fin_service_opr_delete(mdl.invoice_service_id, data.service_id, function () { mdl.tbl_load(); }, apl.func.showError, "");
                        }, undefined, undefined
                    ),
                    apl.createTableWS.column("offer_no"),
                    apl.createTableWS.column("grand_price",undefined,undefined,undefined,true),
                    apl.createTableWS.column("fee",undefined,undefined,undefined,true)
                ]),
                tbl_load:function()
                {
                    activities.fin_service_opr_list(mdl.invoice_service_id,
                        function (arrData)
                        {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                set_document_return:function(sts,value)
                {
                    mdl.tb_document_return_date.disabled = !mdl.cb_document_return.checked;
                    mdl.tb_document_return_date.value = value;
                    mdl.tb_document_return_date.show_popup(false);
                },
                kosongkan:function()
                {
                    mdl.v1.Hide();

                    mdl.invoice_service_id = 0;
                    mdl.customer_id = 0;
                    mdl.an_id = 0;

                    mdl.lb_no.innerHTML = "";
                    mdl.tb_date.value = "<%= apl_date %>";
                    mdl.dl_top.value = "";
                    mdl.tb_po.value = "";
                    mdl.tb_afpo.value = "";
                    
                    mdl.lb_customer.innerHTML = "";
                    mdl.tb_value.value = "";
                    mdl.tb_fee.value = "";
                    mdl.dl_bill.value = "";
                    mdl.cb_paid.checked = false;
                    mdl.cb_pph.checked = false;
                    mdl.cb_invoice.checked = false;
                    mdl.tb_note.value = "";

                    mdl.cb_paid.checked = false;
                    mdl.tb_paiddate.value = "";
                    mdl.lb_surat_jalan.innerHTML = "";

                    mdl.cb_document_return.checked = false;
                    mdl.set_document_return(false, "");
                    mdl.tb_fee_payment.setValue(0);
                    mdl.tb_fee_date.value = "";
                    mdl.lb_document_return_date_exp.innerHTML = "";
                    mdl.tb_amount_cut.value = "0";

                    apl.func.hideSinkMessage();
                    apl.func.validatorClear("save");
                    mdl.top_change();
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Service - Tambah");
                },
                edit:function(id, show_sts)
                {
                    mdl.kosongkan()
                    apl.func.showSinkMessage("Memuat data");

                    mdl.invoice_service_id = id;
                    mdl.tbl_load();
                    activities.fin_service_data(id,
                        function (data)
                        {
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
                            mdl.cb_send.checked = data.send_sts;
                            mdl.cb_pph.checked = data.pph_sts;
                            mdl.cb_invoice.checked = data.invoice_sts;
                            mdl.tb_note.value = data.invoice_note;
                            mdl.cb_document_return.checked = data.document_return_sts;
                            mdl.set_document_return(data.document_return_sts, data.document_return_date);

                            var str_surat = (data.surat_jalan_id == 0) ? "" : "(" + data.surat_jalan_id + ")";
                            mdl.lb_surat_jalan.innerHTML = "Cetak Surat Jalan "+str_surat;

                            mdl.cb_paid.checked = data.paid_sts;
                            mdl.tb_paiddate.value = data.paid_date;

                            mdl.tb_fee_payment.setValue(data.fee_payment);
                            mdl.tb_fee_date.value = data.fee_date;

                            mdl.lb_document_return_date_exp.innerHTML = data.document_return_date_exp;
                            mdl.tb_amount_cut.setValue(data.amount_cut);

                            if (show_sts == undefined || show_sts == true) mdl.showEdit("Service - Edit ");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );                    
                },
                get_term_of_payment_value: function () {
                    var nilai;
                    switch (mdl.dl_top.value)
                    {
                        case '1':
                            nilai = mdl.tb_top_date.value;
                            break;
                        case '2':
                            nilai = mdl.tb_top_day.value;
                            break;
                        default:
                            nilai = '';
                            break;
                    }
                    return nilai;
                },
                select:function(id)
                {
                    mdl_service.hide();
                    activities.fin_service_add(mdl.invoice_service_id,id, mdl.tb_date.value, mdl.dl_top.value, mdl.tb_po.value, mdl.tb_afpo.value,mdl.get_term_of_payment_value(),mdl.dl_bill.value,
                        function (id)
                        {
                            mdl.edit(id);
                        }, apl.func.showError, ""
                    );
                },
                top_change:function()
                {
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
                tambah_service:function()
                {
                    if (apl.func.validatorCheck("save")) mdl_service.open(mdl.customer_id, mdl.an_id);
                },
                print:function()
                {
                    var fname = apl.func.formatFileName(mdl.lb_customer.innerHTML + "_" + mdl.lb_no.innerHTML);                    
                    window.location = "../../report/report_generator.ashx?ListID=4&invoice_service_id=" + mdl.invoice_service_id + "&pdfName=" + fname;
                },
                cetak_surat_jalan:function()
                {
                    activities.fin_service_generate_schedule_print(mdl.invoice_service_id,
                        function ()
                        {
                            fName = "surat_serah_service_" + mdl.lb_customer.innerHTML;
                            fName = window.escape(fName.replace(/ /gi, "_"));
                            window.location = "../../report/report_generator.ashx?ListID=3&invoice_service_id=" + mdl.invoice_service_id + "&pdfName=" + fName;
                        }, apl.func.showError, ""
);
                }
            }, 
            function ()
            {
                mdl.tambah_service();
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    activities.fin_service_edit(mdl.invoice_service_id, mdl.tb_date.value, mdl.dl_top.value, mdl.tb_po.value, mdl.tb_afpo.value,mdl.get_term_of_payment_value(),mdl.dl_bill.value,mdl.cb_paid.checked,mdl.tb_paiddate.value,mdl.cb_send.checked,mdl.cb_invoice.checked,mdl.tb_note.value,mdl.cb_pph.checked,mdl.cb_document_return.checked,mdl.tb_document_return_date.value,mdl.tb_fee_payment.getIntValue(),mdl.tb_fee_date.value,mdl.tb_amount_cut.getIntValue(),
                        function()
                        {
                            cari.fl_refresh();
                            mdl.edit(mdl.invoice_service_id, false);                            
                        }, apl.func.showError, ""
                    );
                }
            }, 
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.fin_service_delete(mdl.invoice_service_id, function () { mdl.hide(); cari.fl_refresh();}, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        var mdl_service = apl.createModal("mdl_service",
            {
                type: 1,
                customer_id: 0,
                an_id: 0,
                tb_no: apl.func.get("mdl_service_no"),
                fr: apl.func.get("mdl_service_fr"),
                open:function(customer_id, an_id)
                {
                    mdl_service.customer_id = customer_id;
                    mdl_service.an_id = an_id;
                    mdl_service.tb_no.value = "";
                    mdl_service.fr.src = "";
                    mdl_service.showAdd("Pilih Penawaran");
                },
                load:function()
                {
                    var no = window.escape(mdl_service.tb_no.value);
                    mdl_service.fr.src = "fin_service_opr_apporved_list.aspx?no=" + no + "&custid=" + mdl_service.customer_id + "&anid=" + mdl_service.an_id+"&branch=<%= branch_id %>";
                }
            }, undefined, undefined, undefined, "frm_page", "mdl"
        );

        var mdl_item = apl.createModal("mdl_item",
            {
                load: function () {                    
                    mdl_item.showAdd("Daftar Item selain service Fee");
                    mdl_item.tbl_load();                    
                },
                tbl: apl.createTableWS.init("mdl_item_tbl", [
                    apl.createTableWS.column("device"),
                    apl.createTableWS.column("pph21", undefined, [apl.createTableWS.attribute("type", "checkbox")],
                        function (data)
                        {
                            //alert(data.service_id + ":" + data.service_device_id + ":" + data.device_id + ":" + this.checked);
                            mdl_item.simpan(data.service_id, data.service_device_id, data.device_id,this.checked);
                        }, undefined, "input", "checked")
                ]),
                tbl_load: function () {
                    activities.fin_service_device_component_list(mdl.invoice_service_id,
                        function (arrData) {
                            mdl_item.tbl.load(arrData);
                            
                        }, apl.func.showError, ""
                    );
                },
                simpan:function(service_id, service_device_id, device_id, sts)
                {
                    activities.fin_opr_service_device_component_update_pph_sts(service_id, service_device_id, device_id, sts,undefined, apl.func.showError, ""
                    );
                }
            }, undefined, undefined, undefined, "frm_page", "mdl"
        );       

        window.addEventListener("load", function () {
            mdl.dl_top.addEventListener("change", mdl.top_change);
            document.list_select = mdl.select;
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;

            cari.load();
            cari.dl_branch.setValue("<%= branch_id %>");
        });

        
    </script>
</asp:Content>

