<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    _test.App a;
    void page_load()
    {
        a = new _test.App(Request);
        
        
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
            <th>No.Invoice</th>
            <td><input type="text" id="cari_no" value="%" size="20"/></td>
        </tr>
        <tr>
            <th>Nama Customer</th>
            <td><input type="text" id="cari_nama" value="%" size="50"/></td>
        </tr>
        <tr>
            <th>Status</th>
            <td><select id="cari_status"></select></td>
        </tr>
        <tr>
            <th>Reverse Sts</th>
            <td>
                <select id="cari_reverse">
                    <option value="%">All</option>
                    <option value="1">Reverse</option>
                    <option value="0">Non Reverse</option>
                </select>
            </td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fr"></iframe>

    <div class="modal" id="mdl_sel">
        <fieldset>
            <legend></legend>
            <table class="formview" style="width:100%">
                <tr>
                    <th style="width:200px;">Tipe Transaksi</th>
                    <td>
                        <select id="mdl_sel_select">
                            <option value="">Pilih</option>
                            <option value="sales">Sales</option>
                            <option value="service">Service</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>No.Invoice</th>
                    <td><input type="text" size="25" id="mdl_sel_no" value="%"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdlsel.load();">Cari</div></td>
                </tr>
                <tr>
                    <th colspan="2">
                        <iframe class="frameList" id="mdl_sel_fl"></iframe>
                    </th>
                </tr>
                <tr>
                    <td colspan="2"><input type="button" value="Close" /></td>
                </tr>
            </table>
           
            
        </fieldset>
    </div>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Tgl.Transaksi</th>
                    <td><label id="mdl_transactiondate"></label></td>
                </tr>                                
                <tr>
                    <th>No.Invoice</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_customer"></label></td>
                </tr>
                <tr>
                    <th>Pajak</th>
                    <td><input type="text" id="mdl_ppn" size="15" disabled="disabled" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Nilai Invoice</th>
                    <td><input type="text" id="mdl_amount" size="15" disabled="disabled" style="text-align:right"/></td>
                </tr>
                <tr>
                    <th>Jurnal Detail</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th>Tipe COA</th>
                                <th>COA</th>
                                <th>DB/CR</th>
                                <th>Nilai</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><label id="mdl_status"></label></td>
                </tr>
                <tr>
                    <th><label id="mdl_signlbl">Sts. Reverse</label></th>
                    <td>
                        <input type="checkbox" id="mdl_signreverse" />
                        <label id="mdl_reversedate"></label>
                    </td>
                </tr>
                <tr>
                    <th>Tgl.Bayar</th>
                    <td><label id="mdl_paymentdate"></label></td>
                </tr>
            </table>
            <div class="button_panel">               
                <input type="button" value="Save" /> 
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_no: apl.func.get("cari_no"),
            tb_nama: apl.func.get("cari_nama"),
            dl_status: apl.createDropdownWS("cari_status", activities.dl_comparameter, undefined, undefined, false, function () { return "type='receivablests'"; }),
            dl_reverse: apl.func.get("cari_reverse"),
            fl: apl.func.get("cari_fr"),

            load:function()
            {
                var no = window.escape(cari.tb_no.value);
                var nama = window.escape(cari.tb_nama.value);
                var status = window.escape(cari.dl_status.value);
                var reverse = window.escape(cari.dl_reverse.value);
                cari.fl.src = "fin_receivable_list.aspx?no=" + no + "&reverse=" + reverse+"&status="+status+"&nama="+nama;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdlsel = apl.createModal("mdl_sel",
            {
                dl_select: apl.func.get("mdl_sel_select"),
                tb_no: apl.func.get("mdl_sel_no"),
                fl: apl.func.get("mdl_sel_fl"),
                load:function()
                {
                    var no = mdlsel.tb_no.value;
                    if (mdlsel.dl_select.value == "sales") mdlsel.fl.src = "fin_receivable_sales_list.aspx?edit=list_select&no=" + no; else mdlsel.fl.src = "fin_receivable_service_list.aspx?edit=list_select&no=" + no;
                },
                tambah:function()
                {
                    mdlsel.dl_select.value = "";
                    mdlsel.tb_no.value = "";
                    mdlsel.fl.src = "";
                    mdlsel.showAdd("Pilih transaksi untuk dijadikan piutang");
                },
                list_select:function(invoice_id)
                {
                    if (mdlsel.dl_select.value == 'sales' && confirm("Yakin dijadikan piutang?")) {
                        apl.func.showSinkMessage("Menyimpan data...");
                        activities.fin_receivable_sales_save(invoice_id,
                            function () {
                                apl.func.hideSinkMessage();
                                mdlsel.hide();
                                cari.fl_refresh();
                            }, apl.func.showError, ""
                        );
                    }
                    if (mdlsel.dl_select.value == 'service' && confirm("Yakin dijadikan piutang?")) {
                        apl.func.showSinkMessage("Menyimpan data...");
                        activities.fin_receivable_service_save(invoice_id, function () {
                            apl.func.hideSinkMessage();
                            mdlsel.hide();
                            cari.fl_refresh();
                        }, apl.func.showError, "");
                    }
                }
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        var mdl = apl.createModal("mdl",
            {
                fin_receivable_id: 0,
                journal_transaction_id: 0,
                lb_transactiondate: apl.func.get("mdl_transactiondate"),
                lb_no: apl.func.get("mdl_no"),                
                lb_customer: apl.func.get("mdl_customer"),
                tb_ppn: apl.func.get("mdl_ppn"),
                tb_amount: apl.func.get("mdl_amount"),
                cb_signreverse: apl.func.get("mdl_signreverse"),
                lb_reversedate: apl.func.get("mdl_reversedate"),
                lb_signlbl: apl.func.get("mdl_signlbl"),
                lb_status: apl.func.get("mdl_status"),
                lb_payment_date: apl.func.get("mdl_paymentdate"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("coa_type_name"),
                        apl.createTableWS.column("coa_name"),
                        apl.createTableWS.column("dbcr_id"),
                        apl.createTableWS.column("amount",undefined,undefined,undefined,true)
                    ]
                ),
                tbl_load:function()
                {
                    activities.acc_journal_transaction_detail_list(mdl.journal_transaction_id,function (arrdata) { mdl.tbl.load(arrdata);}, apl.func.showError, "");
                },

                kosong:function()
                {
                    mdl.journal_transaction_id = 0;
                    mdl.fin_receivable_id = 0;
                    mdl.lb_no.innerHTML = "";                    
                    mdl.lb_customer.innerHTML = "";
                    mdl.tb_ppn.value = "";
                    mdl.tb_amount.value = "";
                    mdl.lb_reversedate.Hide();
                    mdl.cb_signreverse.Show();
                    mdl.lb_payment_date.innerHTML = "";
                    mdl.lb_status.innerHTML = "";
                    //mdl.cb_signreverse.checked = false;
                    apl.func.hideSinkMessage();
                },
                edit:function(id)
                {
                    mdl.kosong();                    
                    apl.func.showSinkMessage("Load data...")
                    mdl.fin_receivable_id = id;
                    
                    activities.fin_receivable_data(id,
                        function (data)
                        {
                            mdl.journal_transaction_id = data.journal_transaction_id;
                            mdl.lb_no.innerHTML = data.invoice_no;
                            mdl.lb_transactiondate.innerHTML = data.transaction_date;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.tb_ppn.value = apl.func.formatNumeric(data.pph_amount);
                            mdl.tb_amount.value = apl.func.formatNumeric(data.receivable_amount);                            
                            mdl.cb_signreverse.checked = data.reverse_sign_sts;
                            mdl.lb_reversedate.innerHTML = data.reverse_date;
                            mdl.lb_payment_date.innerHTML = data.payment_date;
                            mdl.lb_status.innerHTML = data.receivable_status;

                            switch(data.receivable_status_id)
                            {
                                case "1":
                                    mdl.cb_signreverse.Show();
                                    mdl.lb_reversedate.Hide();
                                    mdl.lb_signlbl.innerHTML = "Sts. Reverse";
                                    mdl.lb_signlbl.Show();
                                    break;

                                case "2":
                                    mdl.cb_signreverse.Hide();
                                    mdl.lb_reversedate.Show();
                                    mdl.lb_signlbl.innerHTML = "Tgl. Reverse";
                                    mdl.lb_signlbl.Show();
                                    break;

                                case "3":
                                    mdl.cb_signreverse.Hide();
                                    mdl.lb_reversedate.Hide();
                                    mdl.lb_signlbl.Hide();
                                    break;
                            }

                            

                            mdl.tbl_load();
                            
                            mdl.showEdit("Piutang - Edit : "+ id);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );                    
                }

            },
            undefined, 
            function()
            {
                activities.fin_receivable_update(mdl.fin_receivable_id, mdl.cb_signreverse.checked,
                    function ()
                    {
                        mdl.hide();
                        cari.fl_refresh();
                    }, apl.func.showError, ""
                );
            }
            , undefined, "frm_page", "cover_content"
        );

        document.list_edit = mdl.edit;
        document.list_select = mdlsel.list_select;
        document.list_add = mdlsel.tambah;
    </script>
</asp:Content>

