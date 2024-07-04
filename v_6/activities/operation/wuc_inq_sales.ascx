<%@ Control Language="C#" ClassName="wuc_inq_sales" %>
<%@ Register Src="~/activities/marketing/wuc_sales_inq_full.ascx" TagPrefix="uc1" TagName="wuc_sales_inq_full" %>



<script runat="server">
    public string parent_id { set; get; }
    public string cover_id { set; get; }
    public string func_select { set;get;}

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        func_select = (func_select == null) ? "undefined" : func_select;

        mdl_info.parent_id = parent_id;
        mdl_info.cover_id = ClientID + "_mdl_";
    }
</script>



<div id="<%= ClientID %>_mdl_">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>No.Penawaran</th>
                    <td><label id="<%= ClientID %>_mdl__no"></label></td>
                </tr>
                <tr>
                    <th>Tanggal</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__date" size="10" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Kategori</th>
                    <td><select id="<%= ClientID %>_mdl__ctgsales" disabled></select></td>
                </tr>
                <tr>
                    <th>Broker</th>
                    <td><select id="<%= ClientID %>_mdl__broker" disabled="disabled"></select></td>
                </tr>
                <tr>
                    <th>Pajak</th>
                    <td><input type="checkbox" id="<%= ClientID %>_mdl__tax" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Discount</th>
                    <td>
                        <select id="<%= ClientID %>_mdl__discount_type" style="float:left;" disabled="disabled"></select>
                        <input type="text" id="<%= ClientID %>_mdl__discount_value" style="float:left;text-align:right;" size="20" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <th>Fee</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__fee" size="20" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Additional Fee</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__additional_fee" size="20" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Note-Internal</th>
                    <td><textarea id="<%= ClientID %>_mdl__addfeenote" disabled="disabled"></textarea></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><select id="<%= ClientID %>_mdl__status" disabled="disabled"></select><label title="Tanggal update status" id="<%= ClientID %>_mdl__updatestatusdt" style="margin-left:10px;font-size:small;font-weight:bold;"></label></td>
                </tr>
                <tr>
                    <th>Pelanggan</th>
                    <td><a style="cursor:pointer;text-decoration:underline;font-weight:bold;" id="<%= ClientID %>_mdl__customer" onclick="<%= ClientID %>_mdl_.customer_info();"></a></td>
                </tr>
                <tr>
                    <th>NPWP</th>
                    <td><input type="checkbox" disabled="disabled" id="<%= ClientID %>_mdl__npwp"/></td>
                </tr>                
                <tr>
                    <th>Marketing Status</th>
                    <td><label id="<%= ClientID %>_mdl__marketing_sts"></label>&nbsp(<label id="<%= ClientID %>_mdl__reason_marketing"></label>)</td>
                </tr>
                <tr>
                    <th>Note-Eksternal</th>
                    <td><textarea id="<%= ClientID %>_mdl__note" disabled="disabled"></textarea></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Device</th>
                    <td>
                        <table id="<%= ClientID %>_mdl__tbl" class="gridView">
                            <tr>
                                <th style="width:25px">
                                </th>
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
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Addi.Cost List</th>
                    <td>
                        <table id="<%= ClientID %>_mdl__tbladdicost" class="gridView" style="min-width:600px;">
                            <tr>
                                <th>Keterangan</th>
                                <th>Nilai</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>PPN</th>
                    <td><label id="<%= ClientID %>_mdl__ppn"></label> %</td>
                </tr>    
                <tr>
                    <th>File PO</th>
                    <td>
                        | <label style="font-weight:bold;cursor:pointer;" onclick="<%= ClientID %>_mdl_.open_document()" for="<%= ClientID %>_mdl__url">Open</label>
                        <a id="<%= ClientID %>_mdl__url" target="_self" style="display:none;">Click</a>
                    </td>
                </tr>            
                <tr style="display:none;">
                    <th>PPH 21</th>
                    <td><label id="<%= ClientID %>_mdl__pph"></label> %</td>
                </tr>

                <tr style="background-color:gray;">
                    <th colspan="2" style="text-align:center;"><label style="font-weight:bold;"">TOTAL</label></th>
                </tr>
                <tr>
                    <th>Modal</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__total_cost" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Additional Cost -</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__addicost" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>  
                <tr>
                    <th>Net</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__total_net" size="15" style="text-align:right;" disabled="disabled" title="harga - modal - discount"/></td>
                </tr>
                <tr>
                    <th  style="border-top:2px solid gray;margin-top:5px;">Harga +</th>
                    <td style="border-top:2px solid gray;"><input type="text" id="<%= ClientID %>_mdl__total_price" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>                
                <tr style="display:none;">
                    <th>PPH 21 -</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__total_pph" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>PPN +</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__total_ppn" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Discount -</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__total_discount" size="15" style="text-align:right;" disabled="disabled"/></td>
                </tr>   
                            
                <tr>
                    <th>Total =</th>
                    <td><input type="text" id="<%= ClientID %>_mdl__total_grand" size="15" style="text-align:right;" disabled="disabled" title="harga - pph 21 - discount + ppn"/></td>
                </tr>
                <tr style="background-color:gray;">
                    <th colspan="2" style="text-align:center"><label style="font-weight:bold;"">FINANCE</label></th>
                </tr>
                <tr>
                    <th>No. Invoice</th>
                    <td><label id="<%= ClientID %>_mdl__invoice_no"></label></td>
                </tr>
                <tr>
                    <th>No.PO</th>
                    <td><label id="<%= ClientID %>_mdl__invoice_nopo"></label></td>
                </tr>
                <tr style="background-color:gray;">
                    <th colspan="2" style="text-align:center"><label style="font-weight:bold;"">WORKFLOW</label></th>
                </tr>
                <tr>
                    <th>Log</th>
                    <td>
                        <table class="gridView" id="<%= ClientID %>_mdl__tbllog" style="width:100%">
                            <tr>
                                <th style="width:150px;">Tanggal</th>
                                <th>Status</th>
                                <th>User</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>

                <select id="<%= ClientID %>_mdl__cetak_type" style="float:right;display:none;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input type="button" value="Print" onclick="<%= ClientID %>_mdl_.print(document.getElementById('mdl_cetak_type').value);" style="display:none;float:right;right;"/>

            </div>
        </fieldset>
    </div>

    <div id="<%= ClientID %>_mdl__device">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Device</th>
                    <td><input id="<%= ClientID %>_mdl__device_name" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Keterangan</th>
                    <td><textarea id="<%= ClientID %>_mdl__device_description" disabled="disabled"></textarea></td>
                </tr>
                <tr>
                    <th>Marketing Note</th>
                    <td><textarea id="<%= ClientID %>_mdl__device_note" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Modal</th>
                    <td>
                        <input type="text" id="<%= ClientID %>_mdl__device_cost" size="15" style="text-align:right;float:left;" disabled="disabled"/>

                        <span style="font-size:small;" id="<%= ClientID %>_mdl__device_info_pcg"></span>

                        <span id="<%= ClientID %>_mdl__device_costtax" style="font-size:small;"></span>
                        <div class="select" style="float:left;display:none;" onclick="<%= ClientID %>_mdl__device.tbl_cost_load();">
                            <br />
                            <div style="height:200px; overflow: scroll; width: 700px;" class="gridView">                                
                                <table  id="<%= ClientID %>_mdl__device_tbl_cost" >
                                    <tr>
                                        <th style="width:25px;"></th>
                                        <th>Tgl.Penawaran</th>
                                        <th>Vendor</th>                                        
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
                        <input type="text" id="<%= ClientID %>_mdl__device_principal_price" size="15" style="text-align:right;float:left;" disabled="disabled"/>
                        &nbsp;
                        <a onclick="<%= ClientID %>_mdl__device.set_principal_price();" style="font-weight:bold;cursor:pointer;display:none;">Set</a>
                    </td>
                </tr>
                <tr>
                    <th>Harga</th>
                    <td>
                        <input type="text" id="<%= ClientID %>_mdl__device_price" size="15" style="text-align:right;float:left;" disabled="disabled"/>
                        <div class="select" style="float:left;display:none;" onclick="<%= ClientID %>_mdl__device.tbl_load()">
                            <br />
                            <div style="height:200px; overflow: scroll; width: 700px;" class="gridView">                                
                                <table  id="<%= ClientID %>_mdl__device_tbl_price" >
                                    <tr>
                                        <th style="width:25px;"><input type="checkbox" id="<%= ClientID %>_mdl__device_all_customer" title="Cek semua pelanggan"/></th>
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
                    <td><input type="text" id="<%= ClientID %>_mdl__device_qty" size="5" style="text-align:right;" disabled="disabled"/></td>
                </tr>
                <tr style="display:none;">
                    <th>PPH21</th>
                    <td><input type="checkbox" id="<%= ClientID %>_mdl__device_pph"/></td>
                </tr>
                <tr>
                    <th>Vendor</th>
                    <td><input id="<%= ClientID %>_mdl__device_vendor" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Draft</th>
                    <td><input type="checkbox" id="<%= ClientID %>_mdl__device_draft" disabled="disabled" /></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>                
            </div>
        </fieldset>
    </div>



<script type="text/javascript">

    window.addEventListener("load", function () {
    

    var mdl = apl.createModal("<%= ClientID %>_mdl_",
            {
                sales_id: 0,
                customer_id: 0,
                group_customer_id: 0,

                total_price: 0,
                total_cost: 0,
                total_price_pph21: 0,
                pcg_principal_price: 0,

                lb_no: apl.func.get("<%= ClientID %>_mdl__no"),
                tb_date: apl.createCalender("<%= ClientID %>_mdl__date"),
                dl_ctgsales: apl.createDropdownWS("<%= ClientID %>_mdl__ctgsales", activities.dl_ctgsales_list),
                dl_broker: apl.createDropdownWS("<%= ClientID %>_mdl__broker", activities.dl_opr_broker_list),
                cb_tax: apl.func.get("<%= ClientID %>_mdl__tax"),
                dl_discount_type: apl.createDropdownWS("<%= ClientID %>_mdl__discount_type", activities.dl_discount_type_list),
                tb_discount_value: apl.createNumeric("<%= ClientID %>_mdl__discount_value", true),
                tb_fee: apl.createNumeric("<%= ClientID %>_mdl__fee", true),
                tb_addfee: apl.createNumeric("<%= ClientID %>_mdl__additional_fee", true),
                tb_addfeenote: apl.func.get("<%= ClientID %>_mdl__addfeenote"),
                lb_customer: apl.func.get("<%= ClientID %>_mdl__customer"),
                lb_marketingsts: apl.func.get("<%= ClientID %>_mdl__marketing_sts"),
                lb_reason_marketing: apl.func.get("<%= ClientID %>_mdl__reason_marketing"),
                dl_status: apl.createDropdownWS("<%= ClientID %>_mdl__status", activities.dl_opr_status_sales_list),
                tb_note: apl.func.get("<%= ClientID %>_mdl__note"),
                lb_ppn: apl.func.get("<%= ClientID %>_mdl__ppn"),
                lb_pph: apl.func.get("<%= ClientID %>_mdl__pph"),
                tb_total_price: apl.createNumeric("<%= ClientID %>_mdl__total_price", true),
                tb_total_cost: apl.createNumeric("<%= ClientID %>_mdl__total_cost", true),
                tb_total_pph: apl.createNumeric("<%= ClientID %>_mdl__total_pph", true),
                tb_total_ppn: apl.createNumeric("<%= ClientID %>_mdl__total_ppn", true),
                tb_total_discount: apl.createNumeric("<%= ClientID %>_mdl__total_discount", true),
                tb_net: apl.createNumeric("<%= ClientID %>_mdl__total_net", true),
                tb_grand: apl.createNumeric("<%= ClientID %>_mdl__total_grand", true),
                cb_npwp: apl.func.get("<%= ClientID %>_mdl__npwp"),
                lb_invoice_no: apl.func.get("<%= ClientID %>_mdl__invoice_no"),
                lb_invoice_nopo: apl.func.get("<%= ClientID %>_mdl__invoice_nopo"),
                ddl_cetak_type: apl.func.get("<%= ClientID %>_mdl__cetak_type"),
                lb_updatestatusdt: apl.func.get("<%= ClientID %>_mdl__updatestatusdt"),
                ln_url: apl.func.get("<%= ClientID %>_mdl__url"),
                tb_addicost: apl.createNumeric("<%= ClientID %>_mdl__addicost", true),

                tbl: apl.createTableWS.init("<%= ClientID %>_mdl__tbl",
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
                tbllog: apl.createTableWS.init("<%= ClientID %>_mdl__tbllog",
                    [
                        apl.createTableWS.column("log_date"),
                        apl.createTableWS.column("sales_status_name"),
                        apl.createTableWS.column("user_id")
                    ]
                ),
                tbllog_load: function () {
                    activities.opr_sales_log_list(mdl.sales_id, function (arr) { mdl.tbllog.load(arr); }, apl.func.showError, "");
                },
                tbladdicost: apl.createTableWS.init("<%= ClientID %>_mdl__tbladdicost",
                    [
                        apl.createTableWS.column("addicost_name"),
                        apl.createTableWS.column("addicost_value")
                    ]
                ),
                tbladdicost_load: function () {
                    activities.opr_sales_addicost_list(mdl.sales_id, function (arr) { mdl.tbladdicost.load(arr); }, apl.func.showError, "");
                },
                customer_info: function () {
                    mdl_info.edit(mdl.sales_id);
                },
                open_document: function () {
                    activities.opr_sales_document_data(mdl.sales_id,
                        function (data) {
                            if (data.sales_id == 0) alert("Tidak ada file document");
                            else {
                                var u = apl.func.create_object_url_from_arr(data.file_image, data.file_type);
                                //alert(u);
                                mdl.ln_url.href = u;
                                mdl.ln_url.download = data.file_name;
                                mdl.ln_url.click();
                                //alert("seting");
                            }

                        },
                        apl.func.showError, ""
                    );
                },
                kosongkan: function () {
                    mdl.sales_id = 0;
                    mdl.customer_id = 0;
                    mdl.group_customer_id = 0;
                    mdl.lb_no.innerHTML = "";
                    mdl.tb_date.value = "";
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
                    mdl.dl_status.value = "";
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
                    mdl.lb_invoice_nopo.innerHTML = "";
                    mdl.lb_updatestatusdt.innerHTML = "";
                    mdl.tb_addicost.value = "";

                    mdl.tb_note.value = "";
                    mdl.ddl_cetak_type.value = "";
                },
                tambah: function () {
                },
                select: function (id) {
                },
                edit: function (id) {
                    show_sts=true;
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat Data");
                    activities.opr_sales_data(id,
                        function (data) {
                            mdl.sales_id = data.sales_id;
                            mdl.group_customer_id = data.group_customer_id;

                            mdl.tbl_load();

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
                            mdl.lb_invoice_nopo.innerHTML = data.po_no;
                            mdl.pcg_principal_price = data.pcg_principal_price;
                            mdl.lb_updatestatusdt.innerHTML = data.update_status_date;

                            mdl.tb_addfee.setValue(data.additional_fee);
                            mdl.tb_addfeenote.value = data.additional_fee_note;

                            mdl.tb_addicost.value = data.additional_cost;

                            mdl.tbllog_load();
                            mdl.tbladdicost_load();

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
            },
            function () {
            },
            function () {
            }, "<%= parent_id %>", "<%= cover_id %>"
        );

            var mdl_device = apl.createModal("<%= ClientID %>_mdl__device",
                {
                    sales_id: 0,
                    ac_device: apl.create_auto_complete_text("<%= ClientID %>_mdl__device_name", activities.ac_device_all),
                    tb_cost: (function () {
                        var _o = apl.createNumeric("<%= ClientID %>_mdl__device_cost", true);
                        _o.addEventListener("focusout", function () {
                            mdl_device.set_principal_price();
                        });
                        return _o;
                    })(),
                    //lb_costtax: apl.func.get("<%= ClientID %>_mdl__device_costtax"),                
                    tb_price: apl.createNumeric("<%= ClientID %>_mdl__device_price", true),
                    tb_qty: apl.createNumeric("<%= ClientID %>_mdl__device_qty", true),
                    cb_pph: apl.func.get("<%= ClientID %>_mdl__device_pph"),
                    tb_description: apl.func.get("<%= ClientID %>_mdl__device_description"),
                    tb_note: apl.func.get("<%= ClientID %>_mdl__device_note"),
                    ac_vendor: apl.create_auto_complete_text("<%= ClientID %>_mdl__device_vendor", activities.ac_vendor),
                    cb_all: apl.func.get("<%= ClientID %>_mdl__device_all_customer"),
                    //lb_info_pcg : apl.func.get("<%= ClientID %>_mdl__device_info_pcg"),
                    tb_principal_price: apl.createNumeric("<%= ClientID %>_mdl__device_principal_price"),
                    cb_draft: apl.func.get("<%= ClientID %>_mdl__device_draft"),

                    tbl: apl.createTableWS.init("<%= ClientID %>_mdl__device_tbl_price", [
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
                    tbl_cost: apl.createTableWS.init("<%= ClientID %>_mdl__device_tbl_cost", [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "select")], function (data) { mdl_device.tb_cost.setValue(data.price); }, undefined, undefined),
                        apl.createTableWS.column("customer_name"),
                        apl.createTableWS.column("offer_date"),
                        apl.createTableWS.column("price", undefined, undefined, undefined, true)
                    ]),
                    tbl_cost_load: function () {
                        apl.func.showSinkMessage("Memuat data");
                        activities.opr_sales_cost_history(mdl_device.ac_device.id,
                            function (arrData) {
                                mdl_device.tbl_cost.load(arrData);
                                apl.func.hideSinkMessage();
                            }, apl.func.showError, ""
                        );
                    },
                    set_principal_price: function () {
                        activities.get_principal_price_value(mdl_device.tb_cost.getIntValue(),
                            function (value) {
                                mdl_device.tb_principal_price.setValue(value);
                            }, apl.func.showError, ""
                        );
                    },
                    kosongkan: function () {
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
                    },
                    tambah: function (id) {
                    },
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
                                mdl_device.showEdit("Device - Edit");
                                apl.func.hideSinkMessage();


                            }, apl.func.showError, ""
                    );
                    },
                    simpan: function () {
                    }
                },
            function () {
            },
            function () {
            },

            function () {
            }, "<%= parent_id %>", "<%= ClientID %>_mdl_"
        );

        //func_select %> = function(id){alert(id);};
        <%= func_select %> = mdl.edit;

    });
</script>

<uc1:wuc_sales_inq_full runat="server" ID="mdl_info" />