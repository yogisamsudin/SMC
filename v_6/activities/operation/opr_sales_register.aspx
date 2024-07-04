<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>
<%@ Register Src="~/activities/operation/wuc_opr_sales_assign.ascx" TagPrefix="uc1" TagName="wuc_opr_sales_assign" %>
<%@ Register Src="~/activities/marketing/wuc_sales_inq_full.ascx" TagPrefix="uc1" TagName="wuc_sales_inq_full" %>

<script runat="server">
    public string application_date, user_id, style_print;
    public string branch_id, disabled_sts;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        application_date = a.cookieApplicationDateValue;
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";
        user_id = a.UserID;

        mdl_sales_assign.branch_id = branch_id;

        style_print = "visibility:hidden;";
        if (a.UserID == "sa" || a.UserID == "yosephine" || a.UserID == "eko")
        {
            style_print = "visibility:visible;";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
    <style>
        .select div {
            transition: all 1s Ease;
            visibility: hidden;
            opacity: 0;
            position: relative;
        }

        .select:hover div {
            opacity: 1;
            visibility: visible;
            z-index: 1000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th>No</th>
            <td><input type="text" id="cari_no" size="20" value=""/></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" size="50" value="%"/></td>
        </tr>
        <tr>
            <th>Cabang</th>
            <td><select id="cari_branch" <%= disabled_sts %>></select></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fr"></iframe> 

    <uc1:wuc_opr_sales_assign runat="server" ID="mdl_sales_assign" parent_id="frm_page" cover_id="mdl" function_select="document.select_sales"/>
    <uc1:wuc_sales_inq_full runat="server" ID="mdl_sales_inq" parent_id="frm_page" cover_id="mdl" />

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>No.Penawaran</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td><input type="text" id="mdl_date" size="10"/></td>
                </tr>
                <tr>
                    <th>Kategori</th>
                    <td><select id="mdl_ctgsales"></select></td>
                </tr>
                <tr>
                    <th>Broker</th>
                    <td><select id="mdl_broker"></select></td>
                </tr>
                <tr>
                    <th>Pajak</th>
                    <td><input type="checkbox" id="mdl_tax"/></td>
                </tr>
                <tr>
                    <th>Discount</th>
                    <td>
                        <select id="mdl_discount_type" style="float:left"></select>
                        <input type="text" id="mdl_discount_value" style="float:left;text-align:right;" size="20"/>
                    </td>
                </tr>
                <tr>
                    <th>Fee</th>
                    <td><input type="text" id="mdl_fee" size="20" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Additional Fee</th>
                    <td><input type="text" id="mdl_additional_fee" size="20" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Note-Internal</th>
                    <td><textarea id="mdl_addfeenote"></textarea></td>
                </tr>
                <tr>
                    <th>Pelanggan</th>
                    <td><a style="cursor:pointer;text-decoration:underline;font-weight:bold;" id="mdl_customer" onclick="mdl.customer_info();"></a></td>
                </tr>
                <tr>
                    <th>NPWP</th>
                    <td><input type="checkbox" disabled="disabled" id="mdl_npwp"/></td>
                </tr>                
                <tr>
                    <th>Marketing Status</th>
                    <td><label id="mdl_marketing_sts"></label>&nbsp(<label id="mdl_reason_marketing"></label>)</td>
                </tr>
                <tr>
                    <th>Note-Eksternal</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Device</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl.tambah_device()"></div></th>
                                <th>Device</th>
                                <th>Modal</th>
                                <th>HPP</th>
                                <th>Hrg.Cust</th>
                                <th>Qty</th>
                                <th>Creator ID</th>
                                <th>Create Date</th>
                                <th>Update ID</th>
                                <th>Update Date</th>
                                <th>Sts.Draft</th>
                                <%--<th>PPH 21</th>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>PPN</th>
                    <td><label id="mdl_ppn"></label> %</td>
                </tr>                
                <tr style="display:none;">
                    <th>PPH 21</th>
                    <td><label id="mdl_pph"></label> %</td>
                </tr>
                <tr style="background-color:gray;">
                    <th colspan="2" style="text-align:center;"><label style="font-weight:bold;"">TOTAL</label></th>
                </tr>
                <tr>
                    <th>Modal</th>
                    <td><input type="text" id="mdl_total_cost" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Net</th>
                    <td><input type="text" id="mdl_total_net" size="15" style="text-align:right;" disabled="disabled" title="harga - modal - discount"/></td>
                </tr>
                <tr>
                    <th>Harga +</th>
                    <td><input type="text" id="mdl_total_price" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>                
                <tr style="display:none;">
                    <th>PPH 21 -</th>
                    <td><input type="text" id="mdl_total_pph" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>PPN +</th>
                    <td><input type="text" id="mdl_total_ppn" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Discount -</th>
                    <td><input type="text" id="mdl_total_discount" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>                
                <tr>
                    <th>Total =</th>
                    <td><input type="text" id="mdl_total_grand" size="15" style="text-align:right;" disabled="disabled" title="harga - pph 21 - discount + ppn"/></td>
                </tr>
                <tr style="background-color:gray;display:none;">
                    <th colspan="2" style="text-align:center"><label style="font-weight:bold;"">FINANCE</label></th>
                </tr>
                <tr style="display:none;">
                    <th>No. Invoice</th>
                    <td><label id="mdl_invoice_no"></label></td>
                </tr>
                <tr style="background-color:gray;">
                    <th colspan="2" style="text-align:center"><label style="font-weight:bold;"">WORKFLOW</label></th>
                </tr>
                <tr>
                    <th>Log</th>
                    <td>
                        <table class="gridView" id="mdl_tbllog" style="width:100%">
                            <tr>
                                <th style="width:150px;">Tanggal</th>
                                <th>Status</th>
                                <th>User</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><select id="mdl_status" ></select><label title="Tanggal update status" id="mdl_updatestatusdt" style="margin-left:10px;font-size:small;font-weight:bold;"></label></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Close"/>
                <select id="mdl_cetak_type" style="float:right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="mdl.print(document.getElementById('mdl_cetak_type').value);" style="float:right;right;<%= style_print %>""/>
            </div>
            <label style="font-size:smaller;font-weight:bold;">NB: simpan sebelum mencetak</label>
        </fieldset>
    </div>

    <div id="mdl_device">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Device</th>
                    <td><input id="mdl_device_name"/></td>
                </tr>
                <tr>
                    <th>Spesifikasi</th>
                    <td><textarea id="mdl_device_description"></textarea></td>
                </tr>
                <tr>
                    <th>Marketing Note</th>
                    <td><textarea id="mdl_device_note" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Modal</th>
                    <td>
                        <input type="text" id="mdl_device_cost" size="15" style="text-align:right;float:left;"/>

                        <span style="font-size:small;" id="mdl_device_info_pcg"></span>

                        <span id="mdl_device_costtax" style="font-size:small;"></span>
                        <div class="select" style="float:left;" onclick="mdl_device.tbl_cost_load();">
                            <br />
                            <div style="height:200px; overflow: scroll; width: 700px;" class="gridView">                                
                                <table  id="mdl_device_tbl_cost" >
                                    <tr>
                                        <th style="width:25px;"></th>
                                        <th>Vendor</th>
                                        <th>Tgl.Penawaran</th>                                        
                                        <th>Harga</th>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>HPP</th>
                    <td>
                        <input type="text" id="mdl_device_principal_price" size="15" style="text-align:right;float:left;" disabled="disabled"/>
                        &nbsp;
                        <a onclick="mdl_device.set_principal_price();" style="font-weight:bold;cursor:pointer;">Set</a>
                    </td>
                </tr>
                <tr>
                    <th>Harga</th>
                    <td>
                        <input type="text" id="mdl_device_price" size="15" style="text-align:right;float:left;"/>
                        <div class="select" style="float:left;" onclick="mdl_device.tbl_load()">
                            <br />
                            <div style="height:200px; overflow: scroll; width: 700px;" class="gridView">                                
                                <table  id="mdl_device_tbl_price" >
                                    <tr>
                                        <th style="width:25px;"><input type="checkbox" id="mdl_device_all_customer" title="Cek semua pelanggan"/></th>
                                        <th>Customer</th>
                                        <th>Tgl.Penawaran</th>
                                        <th>Harga</th>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td><input type="text" id="mdl_device_qty" size="5" style="text-align:right;"/></td>
                </tr>
                <tr style="display:none;">
                    <th>PPH21</th>
                    <td><input type="checkbox" id="mdl_device_pph"/></td>
                </tr>
                <tr>
                    <th>Vendor</th>
                    <td><input id="mdl_device_vendor"/></td>
                </tr>
                <tr>
                    <th>Sts.Garansi</th>
                    <td><select id="mdl_device_guarantee"></select></td>
                </tr>
                <tr>
                    <th>Ketersediaan Brg.</th>
                    <td  style="padding:0;margin:0;border:none;">
                        <table border="0" style="border:none;padding:0;margin:0;">
                            <tr>
                                <td style="padding:0;margin:0;border:none;"><select id="mdl_device_availability"></select></td>
                                <td style="padding:0;margin:0;border:none;"><input type="text" id="mdl_device_inden" size="3" style="text-align:right;"/></td>
                            </tr>
                        </table>
                        

                    </td>
                </tr>
                <tr>
                    <th>Draft</th>
                    <td><input type="checkbox" id="mdl_device_draft" /></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Close"/>                
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var appuser = '<%= user_id %>';
        
        var cari = {
            tb_no: apl.func.get("cari_no"),
            tb_customer: apl.func.get("cari_customer"),
            dl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var no = escape(cari.tb_no.value);
                var cust = escape(cari.tb_customer.value);
                var status = "1";
                var fs = "0";
                var ssm = "%";
                cari.fl.src = "opr_sales_list.aspx?allow=0&no=" + no + "&cust=" + cust + "&status=" + status + "&fs=" + fs + "&branch=" + cari.dl_branch.value + "&ssm=" + ssm + "&nopo=%";
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                sales_id: 0,
                customer_id: 0,
                group_customer_id: 0,

                total_price: 0,
                total_cost: 0,
                total_price_pph21: 0,
                pcg_principal_price: 0,

                lb_no: apl.func.get("mdl_no"),
                tb_date: apl.createCalender("mdl_date"),
                dl_ctgsales: apl.createDropdownWS("mdl_ctgsales", activities.dl_ctgsales_list),
                dl_broker: apl.createDropdownWS("mdl_broker", activities.dl_opr_broker_list),
                cb_tax: apl.func.get("mdl_tax"),
                dl_discount_type: apl.createDropdownWS("mdl_discount_type", activities.dl_discount_type_list),
                tb_discount_value: apl.createNumeric("mdl_discount_value", true),
                tb_fee: apl.createNumeric("mdl_fee", true),
                tb_addfee: apl.createNumeric("mdl_additional_fee", true),
                tb_addfeenote: apl.func.get("mdl_addfeenote"),
                lb_customer: apl.func.get("mdl_customer"),
                lb_marketingsts: apl.func.get("mdl_marketing_sts"),
                lb_reason_marketing: apl.func.get("mdl_reason_marketing"),
                dl_status: apl.createDropdownWS("mdl_status", activities.dl_opr_status_sales_list2, undefined, undefined, undefined, function () { return " type='oprsalessts' and code in ('1')"; }),
                tb_note: apl.func.get("mdl_note"),
                lb_ppn: apl.func.get("mdl_ppn"),
                lb_pph: apl.func.get("mdl_pph"),
                tb_total_price: apl.createNumeric("mdl_total_price", true),
                tb_total_cost: apl.createNumeric("mdl_total_cost", true),
                tb_total_pph: apl.createNumeric("mdl_total_pph", true),
                tb_total_ppn: apl.createNumeric("mdl_total_ppn", true),
                tb_total_discount: apl.createNumeric("mdl_total_discount", true),
                tb_net: apl.createNumeric("mdl_total_net", true),
                tb_grand: apl.createNumeric("mdl_total_grand", true),
                cb_npwp: apl.func.get("mdl_npwp"),
                lb_invoice_no: apl.func.get("mdl_invoice_no"),
                ddl_cetak_type: apl.func.get("mdl_cetak_type"),
                lb_updatestatusdt: apl.func.get("mdl_updatestatusdt"),

                val1: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Salah input"),
                val2: apl.createValidator("save", "mdl_broker", function () { return apl.func.emptyValueCheck(mdl.dl_broker.value); }, "Salah input"),
                val3: apl.createValidator("save", "mdl_discount_type", function () { return apl.func.emptyValueCheck(mdl.dl_discount_type.value); }, "Salah input"),
                val4: apl.createValidator("save", "mdl_discount_value", function () { return apl.func.emptyValueCheck(mdl.tb_discount_value.value) || (mdl.dl_discount_type.value == "1" && parseInt(mdl.tb_discount_value.value) > 100); }, "Salah input"),
                val5: apl.createValidator("save", "mdl_fee", function () { return apl.func.emptyValueCheck(mdl.tb_fee.value); }, "Salah input"),
                val6: apl.createValidator("save", "mdl_additional_fee", function () { return apl.func.emptyValueCheck(mdl.tb_addfee.value); }, "Salah input"),
                val7: apl.createValidator("save", "mdl_status", function () { return apl.func.emptyValueCheck(mdl.dl_status.value); }, "Salah input"),
                val8: apl.createValidator("save", "mdl_ctgsales", function () { return apl.func.emptyValueCheck(mdl.dl_ctgsales.value); }, "Salah input"),

                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_device.edit(data.sales_id, data.device_id); }, undefined, undefined),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("cost", undefined, undefined, undefined, true),
                        apl.createTableWS.column("principal_price", undefined, undefined, undefined, true),
                        apl.createTableWS.column("price_customer", undefined, undefined, undefined, true),
                        apl.createTableWS.column("qty", undefined, undefined, undefined, true),
                        apl.createTableWS.column("creator_id"),
                        apl.createTableWS.column("create_date"),
                        apl.createTableWS.column("update_id"),
                        apl.createTableWS.column("update_date"),
                        apl.createTableWS.column("draft_sts", undefined, [apl.createTableWS.attribute("type", "checkbox"), apl.createTableWS.attribute("disabled", "disabled")], undefined, undefined, "input", "checked"),
                        //,apl.createTableWS.column("pph21_sts", undefined, [apl.createTableWS.attribute("type", "checkbox"), apl.createTableWS.attribute("disabled", "disabled")], undefined, undefined, "input","checked")
                    ]
                ),
                tbl_load: function (refresh_total_sts) {
                    activities.opr_sales_device_list(mdl.sales_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbllog: apl.createTableWS.init("mdl_tbllog",
                    [
                        apl.createTableWS.column("log_date"),
                        apl.createTableWS.column("sales_status_name"),
                        apl.createTableWS.column("user_id")
                    ]
                ),
                tbllog_load: function () {
                    activities.opr_sales_log_list(mdl.sales_id, function (arr) { mdl.tbllog.load(arr); }, apl.func.showError, "");
                },

                tambah_device: function () {
                    mdl_device.tambah(mdl.sales_id);
                },
                customer_info: function () {
                    mdl_sales_inq.edit(mdl.sales_id);
                },
                set_fax: function (nilai) {
                    if (nilai != '') {
                        activities.opr_broker_data(nilai,
                            function (data) {
                                mdl.cb_tax.checked = data.par_tax_sts;
                            }, apl.func.showError, ""
                        );
                    }
                },
                kosongkan: function () {
                    mdl.sales_id = 0;
                    mdl.customer_id = 0;
                    mdl.group_customer_id = 0;
                    mdl.lb_no.innerHTML = "";
                    mdl.tb_date.value = "<%= application_date %>";
                    mdl.dl_broker.value = "";
                    mdl.cb_tax.checked = true;
                    mdl.dl_discount_type.value = "";
                    mdl.tb_discount_value.value = "0";
                    mdl.tb_fee.value = "0";
                    mdl.tb_addfee.value = "0";
                    mdl.tb_addfeenote.value = "";
                    mdl.lb_marketingsts.innerHTML = "";
                    mdl.lb_reason_marketing.innerHTML = "";
                    mdl.lb_customer.innerHTML = "";
                    mdl.dl_status.value = "1";
                    mdl.dl_status.disabled = true;
                    mdl.tbl.Hide();

                    mdl.lb_pph.innerHTML = "";
                    mdl.lb_ppn.innerHTML = "";
                    mdl.tb_total_cost.value = "";
                    mdl.tb_total_price.value = "";
                    mdl.tb_total_pph.value = "";
                    mdl.tb_total_ppn.value = "";
                    mdl.tb_total_discount.value = "";
                    mdl.tb_net.value = "";
                    mdl.tb_grand.value = "";
                    mdl.dl_discount_type.value = "";
                    mdl.lb_invoice_no.innerHTML = "";
                    mdl.lb_updatestatusdt.innerHTML = "";
                    mdl.dl_ctgsales.value = "";

                    mdl.tb_note.value = "";
                    apl.func.validatorClear("save");
                    mdl.ddl_cetak_type.value = "";
                },
                tambah: function () {
                    mdl.kosongkan();
                    document.select_sales = mdl.select;
                    mdl.showAdd("Penjualan - Tambah");
                },
                select: function (id) {
                    activities.opr_sales_add(id, mdl.tb_date.value, mdl.dl_broker.value, mdl.dl_discount_type.value, mdl.tb_discount_value.getIntValue(), mdl.cb_tax.checked, mdl.tb_fee.getIntValue(), mdl.tb_note.value, mdl.dl_status.value, mdl.tb_addfee.getIntValue(), mdl.tb_addfeenote.value, appuser,mdl.dl_ctgsales.value,
                        function () {
                            mdl.edit(id);
                        }, apl.func.showError, ""
                    );
                },
                edit: function (id, show_sts) {


                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat Data");
                    activities.opr_sales_data(id,
                        function (data) {
                            mdl.sales_id = data.sales_id;
                            mdl.group_customer_id = data.group_customer_id;

                            mdl.tbl_load();
                            mdl.tbllog_load();

                            mdl.customer_id = data.customer_id;
                            mdl.lb_no.innerHTML = data.offer_no;
                            mdl.tb_date.value = data.offer_date;
                            mdl.dl_broker.value = data.broker_id;
                            mdl.cb_tax.checked = data.tax_sts;
                            mdl.dl_discount_type.value = data.discount_type_id;
                            mdl.tb_discount_value.value = data.discount_value;
                            mdl.tb_fee.setValue(data.fee);
                            mdl.lb_marketingsts.innerHTML = data.sales_status_marketing;
                            mdl.lb_reason_marketing.innerHTML = data.reason_marketing + " " + data.sales_status_marketing_updatedate;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.dl_status.value = data.sales_status_id;
                            mdl.dl_status.disabled = false;
                            mdl.tb_note.value = data.opr_note;
                            mdl.cb_npwp.checked = data.npwp_sts;

                            mdl.tbl.Show();

                            mdl.lb_pph.innerHTML = data.pph21;
                            mdl.lb_ppn.innerHTML = data.ppn;

                            mdl.tb_total_cost.setValue(data.total_cost);
                            mdl.tb_total_price.setValue(data.total_price);
                            mdl.tb_total_pph.setValue(data.total_pph21);
                            mdl.tb_total_ppn.setValue(data.total_ppn);
                            mdl.tb_total_discount.setValue(data.total_discount);
                            mdl.tb_net.setValue(data.net);
                            mdl.tb_grand.setValue(data.grand_price);

                            mdl.lb_invoice_no.innerHTML = data.invoice_no;
                            mdl.pcg_principal_price = data.pcg_principal_price;
                            mdl.lb_updatestatusdt.innerHTML = data.update_status_date;

                            mdl.tb_addfee.setValue(data.additional_fee);
                            mdl.tb_addfeenote.value = data.additional_fee_note;

                            mdl.dl_ctgsales.value = data.ctgsales_id;

                            if (show_sts == undefined || show_sts) mdl.showEdit("Penjualan - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                print: function (file_type) {
                    if (mdl.sales_id != 0) {
                        var fName = mdl.lb_customer.innerHTML + "_" + mdl.lb_no.innerHTML;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=5&sales_id=" + mdl.sales_id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    document["mdl_sales_assign"].open();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan Data");
                    activities.opr_sales_edit(mdl.sales_id, mdl.tb_date.value, mdl.dl_broker.value, mdl.dl_discount_type.value, mdl.tb_discount_value.getIntValue(), mdl.cb_tax.checked, mdl.tb_fee.getIntValue(), mdl.tb_note.value, mdl.dl_status.value, mdl.tb_addfee.getIntValue(), mdl.tb_addfeenote.value, appuser,mdl.dl_ctgsales.value,
                        function () {
                            //mdl.edit(mdl.sales_id, false);
                            if(mdl.dl_status.value=='2') mdl.hide();
                            cari.fl_refresh();
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    activities.opr_sales_delete(mdl.sales_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );
        
        var mdl_device = apl.createModal("mdl_device",
            {
                sales_id: 0,
                ac_device: apl.create_auto_complete_text("mdl_device_name", activities.ac_device_all),
                //tb_cost: apl.createNumeric("mdl_device_cost", true),
                tb_cost: (function () {
                    var _o = apl.createNumeric("mdl_device_cost", true);
                    _o.addEventListener("focusout", function () {
                        //mdl_device.lb_costtax.innerHTML = apl.func.formatNumeric(mdl_device.f_tambakan_pajak());
                        mdl_device.set_principal_price();
                    });
                    return _o;
                })(),
                //lb_costtax: apl.func.get("mdl_device_costtax"),                
                tb_price: apl.createNumeric("mdl_device_price", true),
                tb_qty: apl.createNumeric("mdl_device_qty", true),
                cb_pph: apl.func.get("mdl_device_pph"),
                tb_description: apl.func.get("mdl_device_description"),
                tb_note: apl.func.get("mdl_device_note"),
                ac_vendor: apl.create_auto_complete_text("mdl_device_vendor", activities.ac_vendor),
                cb_all: apl.func.get("mdl_device_all_customer"),
                //lb_info_pcg : apl.func.get("mdl_device_info_pcg"),
                tb_principal_price: apl.createNumeric("mdl_device_principal_price"),

                dl_guarantee: apl.createDropdownWS("mdl_device_guarantee", activities.dl_guaranteedevsts),
                dl_availability: apl.createDropdownWS("mdl_device_availability", activities.dl_availalibity),
                tb_inden: apl.createNumeric("mdl_device_inden"),

                cb_draft: apl.func.get("mdl_device_draft"),

                val01: apl.createValidator("device_save", "mdl_device_name", function () { return apl.func.emptyValueCheck(mdl_device.ac_device.id); }, "Salah input"),
                //val_device: apl.createValidator("device_save", "mdl_device_name", function () { return true; }, "Salah input"),
                val02: apl.createValidator("device_save", "mdl_device_cost", function () { return apl.func.emptyValueCheck(mdl_device.tb_cost.value); }, "Salah input"),
                val03: apl.createValidator("device_save", "mdl_device_principal_price", function () { return apl.func.emptyValueCheck(mdl_device.tb_principal_price.value); }, "Salah input"),
                val04: apl.createValidator("device_save", "mdl_device_price", function () { return apl.func.emptyValueCheck(mdl_device.tb_price.value); }, "Salah input"),
                val05: apl.createValidator("device_save", "mdl_device_qty", function () { return apl.func.emptyValueCheck(mdl_device.tb_qty.value); }, "Salah input"),
                val06: apl.createValidator("device_save", "mdl_device_guarantee", function () { return apl.func.emptyValueCheck(mdl_device.dl_guarantee.value); }, "Salah input"),
                val07: apl.createValidator("device_save", "mdl_device_availability", function () { return apl.func.emptyValueCheck(mdl_device.dl_availability.value); }, "Salah input"),
                val08: apl.createValidator("device_save", "mdl_device_inden", function () { return apl.func.emptyValueCheck(mdl_device.tb_inden.value); }, "Salah input"),

                tbl: apl.createTableWS.init("mdl_device_tbl_price", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "select")], function (data) { mdl_device.tb_price.setValue(data.price); }, undefined, undefined),
                    apl.createTableWS.column("customer_name"),
                    apl.createTableWS.column("offer_date"),
                    apl.createTableWS.column("price", undefined, undefined, undefined, true)
                ]),
                tbl_load: function () {
                    apl.func.showSinkMessage("Memuat data");
                    //alert(mdl_device.ac_device.getValue() + ":" + mdl.customer_id + ":" + mdl_device.cb_all.checked)
                    activities.xml_opr_sales_device_price_history(mdl_device.ac_device.id, mdl.group_customer_id, mdl_device.cb_all.checked, mdl.sales_id,
                        function (arrData) {
                            mdl_device.tbl.load(arrData);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                tbl_cost: apl.createTableWS.init("mdl_device_tbl_cost", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "select")], function (data) { mdl_device.tb_cost.setValue(data.price); }, undefined, undefined),
                    apl.createTableWS.column("customer_name"),
                    apl.createTableWS.column("offer_date"),
                    apl.createTableWS.column("price", undefined, undefined, undefined, true)
                ]),
                tbl_cost_load: function () {
                    if (mdl_device.ac_device.id != "") {
                        apl.func.showSinkMessage("Memuat data");
                        activities.opr_sales_cost_history(mdl_device.ac_device.id,
                            function (arrData) {
                                mdl_device.tbl_cost.load(arrData);
                                apl.func.hideSinkMessage();
                            }, apl.func.showError, ""
                        );
                    }
                },
                set_principal_price: function () {
                    activities.get_principal_price_value(mdl_device.tb_cost.getIntValue(),
                        function (value) {
                            mdl_device.tb_principal_price.setValue(value);
                        }, apl.func.showError, ""
                    );
                },
                o_availchange:function()
                {
                    if (mdl_device.dl_availability.value == "2") mdl_device.tb_inden.Show();else mdl_device.tb_inden.Hide();
                    mdl_device.tb_inden.value = "0";
                },
                kosongkan: function () {
                    apl.func.validatorClear("device_save");
                    mdl_device.ac_device.set_value("", "");
                    mdl_device.tb_cost.value = "";
                    mdl_device.tb_principal_price.value = "";
                    //mdl_device.lb_costtax.innerHTML = "";
                    mdl_device.tb_price.value = "";
                    mdl_device.tb_qty.value = "";
                    mdl_device.tb_description.value = "";
                    mdl_device.tb_note.value = "";
                    mdl_device.cb_pph.checked = false;
                    mdl_device.ac_vendor.set_value("", "");
                    mdl_device.cb_draft.checked = false;
                    mdl_device.tbl.clearAllRow();
                    //mdl_device.lb_info_pcg.innerHTML = "Pokok jual "+ mdl.pcg_principal_price+"% dari modal: ";
                    mdl_device.tbl_cost.clearAllRow();

                    mdl_device.dl_guarantee.value = "";
                    mdl_device.dl_availability.value = "";
                    mdl_device.o_availchange();
                },
                tambah: function (id) {
                    mdl_device.kosongkan();
                    mdl_device.sales_id = id;
                    mdl_device.showAdd("Device - Tambah");

                    if (appuser != 'sa' && mdl.lb_invoice_no.innerHTML != "") mdl_device.btnAdd.hide();
                },
                /*
                f_tambakan_pajak:function()
                {
                    return parseFloat(mdl_device.tb_cost.getIntValue()) * parseFloat(0.01 + 1);
                },
                */
                edit: function (sales_id, device_id) {
                    apl.func.showSinkMessage("Memuat Data");
                    activities.opr_sales_device_data(sales_id, device_id,
                        function (data) {
                            mdl_device.kosongkan();
                            mdl_device.sales_id = sales_id;
                            mdl_device.ac_device.set_value(data.device_id, data.device);
                            mdl_device.tb_cost.setValue(data.cost);

                            mdl_device.tb_principal_price.setValue(data.principal_price);
                            //mdl_device.lb_costtax.innerHTML = apl.func.formatNumeric(mdl_device.f_tambakan_pajak());

                            mdl_device.tb_price.setValue(data.price);
                            mdl_device.tb_qty.setValue(data.qty);
                            mdl_device.cb_pph.checked = data.pph21_sts;
                            mdl_device.tb_description.value = data.description;
                            mdl_device.tb_note.value = data.marketing_note;
                            mdl_device.ac_vendor.set_value(data.vendor_id, data.vendor_name);
                            mdl_device.cb_draft.checked = data.draft_sts;

                            mdl_device.dl_guarantee.value = data.guarantee_id;
                            mdl_device.dl_availability.value = data.availability_id;
                            mdl_device.o_availchange();
                            mdl_device.tb_inden.setValue(data.inden);
                                    

                            mdl_device.showEdit("Device - Edit");
                            apl.func.hideSinkMessage();

                            if (appuser != 'sa' && mdl.lb_invoice_no.innerHTML != "") //yogi
                            {
                                mdl_device.btnAdd.hide();
                                mdl_device.btnSave.hide();
                                mdl_device.btnDelete.hide();
                            }

                        }, apl.func.showError, ""
                );
                        },
                        simpan: function () {
                            if (apl.func.validatorCheck("device_save")) {
                                var vendor_id = (mdl_device.ac_vendor.id == "") ? 0 : mdl_device.ac_vendor.id;
                                activities.opr_sales_device_save(mdl_device.sales_id, mdl_device.ac_device.id, mdl_device.tb_cost.getIntValue(), mdl_device.tb_price.getIntValue(), mdl_device.tb_qty.getIntValue(), mdl_device.cb_pph.checked, mdl_device.tb_description.value, vendor_id, mdl_device.tb_principal_price.getIntValue(), mdl_device.tb_note.value, appuser, mdl_device.cb_draft.checked, mdl_device.dl_guarantee.value, mdl_device.dl_availability.value, mdl_device.tb_inden.getIntValue(),
                                    function (message) {
                                        //mdl.tbl_load();
                                        if (message == "") {
                                            mdl.edit(mdl.sales_id);
                                            mdl_device.hide();
                                        } else alert(message);
                                        
                                    }, apl.func.showError, ""
                                );
                            }
                        }
                    },
        function () {
            mdl_device.simpan();
        },
        function () {
            mdl_device.simpan();
        },

        function () {
            if (confirm("Yakin akan dihapus")) {
                activities.opr_sales_device_delete(mdl_device.sales_id, mdl_device.ac_device.id,
                    function () {
                        mdl.tbl_load();
                        mdl_device.hide();
                    }, apl.func.showError, ""
                );
            }
        }, "frm_page", "mdl"
    );

        window.addEventListener("load", function () {
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;

            mdl.dl_broker.addEventListener("change", function () { mdl.set_fax(this.value); });
            cari.dl_branch.setValue("<%= branch_id %>");

            mdl_device.dl_availability.addEventListener("change", mdl_device.o_availchange);
        });
    </script>
</asp:Content>

