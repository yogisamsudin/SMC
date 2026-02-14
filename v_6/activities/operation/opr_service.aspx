<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

<%@ Register Src="~/activities/operation/wuc_opr_service_assign.ascx" TagPrefix="uc1" TagName="wuc_opr_service_assign" %>
<%@ Register Src="~/activities/marketing/wuc_service_inq_full.ascx" TagPrefix="uc1" TagName="wuc_service_inq_full" %>



<script runat="server">
    public string branch_id, disabled_sts, style_print, ListID, user_id;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";

        mdl_opr_service_assign.str_branch_id = branch_id;

        style_print = "visibility:hidden;";

        user_id = a.UserID;
        if (user_id == "sa" || user_id == "yosephine" || user_id == "eko")
        {
            style_print = "visibility:visible;";
        }

        ListID = "2";
        if (Request.QueryString["ListID"] != null)
        {
            ListID = Request.QueryString["ListID"].ToString();
        }

        //Response.Write("user id: "+user_id);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>    
    <style>
        .select div
        {
            transition: all 1s Ease;
            visibility:hidden;
            opacity:0;
            position:relative;
            
        }
        .select:hover div
        {
            opacity:1;
            visibility:visible;
            z-index:1000;
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
            <th><span class="asal">No</span></th>
            <td><input type="text" id="cari_no" size="20" class="asal" value="%"/></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" size="50" value="%"/></td>
        </tr>
        <tr>
            <th>SN</th>
            <td><input type="text" id="cari_sn" size="50" value="%"/></td>
        </tr>
        <tr>
            <th>Status</th>
            <td><select id="cari_status"></select></td>
        </tr>
        <tr>
            <th>Marketing Sts</th>
            <td><select id="cari_marketing_sts"></select></td>
        </tr>
        <tr>
            <th>Finance Sts</th>
            <td>
                <select id="cari_finance_sts">
                    <option value="%">-All-</option>
                    <option value="1">Ada</option>
                    <option value="0">Belum</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>Technician Sts</th>
            <td><select id="cari_technician_sts"></select></td>
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

    <uc1:wuc_opr_service_assign runat="server" ID="mdl_opr_service_assign" parent_id="frm_page" cover_id="mdl" function_select="document.select_service_device"/>
    <uc1:wuc_service_inq_full runat="server" ID="mdl_service_inq" parent_id="frm_page" cover_id="mdl"/>
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
                    <th>Note</th>
                    <td><textarea id="mdl_addfeenote"></textarea></td>
                </tr>
                <tr>
                    <th>Additonal Fee</th>
                    <td><input type="text" id="mdl_addfee" size="20" style="text-align:right;" /></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><select id="mdl_status"></select><label title="Tanggal update status" id="mdl_updatestatusdt" style="margin-left:10px;font-size:small;font-weight:bold;"></label></td>
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
                    <td><label id="mdl_marketing_sts"></label>&nbsp;(<label id="mdl_reason_marketing"></label>)</td>
                </tr>                
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Device</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl.service_device_tambah();"></div></th>
                                <th>SN</th>
                                <th>Device</th>
                                <th>Modal</th>
                                <th>Harga</th>
                                <th>Hrg.Cust</th>
                                <th>Total PPH 21</th>
                                <th>Status</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Addi.Cost List</th>
                    <td>
                        <table id="mdl_tbladdicost" class="gridView" style="min-width:600px;">
                            <tr>
                                <%--<th style="width:25px;"><div class="tambah" onclick="mdladdicost.tambah();"></div></th>--%>
                                <th>Keterangan</th>
                                <th>Nilai</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>PPN</th>
                    <td><label id="mdl_ppn"></label> %</td>
                </tr>
                <tr>
                    <th>File PO</th>
                    <td>
                        | <label style="font-weight:bold;cursor:pointer;" onclick="mdl.open_document()" for="mdl_url">Open</label>
                        <a id="mdl_url" target="_self" style="display:none;">Click</a>
                    </td>
                </tr>
                <tr style="display:none;">
                    <th>PPH 21</th>
                    <td><label id="mdl_pph"></label> %</td>
                </tr>
                <tr style="background-color:gray;">
                    <th></th>
                    <td><label style="font-weight:bold;"">TOTAL</label></td>
                </tr>
                <tr>
                    <th>Modal</th>
                    <td><input type="text" id="mdl_total_cost" size="15" style="text-align:right;" disabled/></td>
                </tr>
                <tr>
                    <th>Addi.Cost -</th>
                    <td><input type="text" id="mdl_total_addicost" size="15" style="text-align:right;" disabled/></td>
                </tr>
                <tr>
                    <th>Net</th>
                    <td><input type="text" id="mdl_total_net" size="15" style="text-align:right;" disabled title="harga - modal - discount"/></td>
                </tr>
                <tr>
                    <th>Harga +</th>
                    <td><input type="text" id="mdl_total_price" size="15" style="text-align:right;" disabled/></td>
                </tr>                
                <tr style="display:none;">
                    <th>PPH 21 -</th>
                    <td><input type="text" id="mdl_total_pph" size="15" style="text-align:right;" disabled/></td>
                </tr>
                <tr>
                    <th>PPN +</th>
                    <td><input type="text" id="mdl_total_ppn" size="15" style="text-align:right;" disabled/></td>
                </tr>
                <tr>
                    <th>Discount -</th>
                    <td><input type="text" id="mdl_total_discount" size="15" style="text-align:right;" disabled/></td>
                </tr>                
                <tr>
                    <th>Total =</th>
                    <td><input type="text" id="mdl_total_grand" size="15" style="text-align:right;" disabled title="harga - pph 21 - discount + ppn"/></td>
                </tr>
                <tr style="background-color:gray;">
                    <th></th>
                    <td><label style="font-weight:bold;"">FINANCE</label></td>
                </tr>
                <tr>
                    <th>Invoice No</th>
                    <td><label id="mdl_invoice"></label></td>
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
                <input type="button" value="Print" onclick="mdl.print_offer(document.getElementById('mdl_cetak_type').value);" style="float:right;<%= style_print %>"/>
            </div>
            <label style="font-size:smaller;font-weight:bold;">NB: simpan sebelum mencetak</label>
        </fieldset>
    </div>

    <div id="mdl_device">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>SN</th>
                    <td><label id="mdl_device_sn"></label></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><label id="mdl_device_device"></label></td>
                </tr>
                <tr>
                    <th>Garansi</th>
                    <td><input type="checkbox" disabled="disabled" id="mdl_device_guarantee"/></td>
                </tr>
                <tr>
                    <th>Nama User</th>
                    <td><label id="mdl_device_user"></label></td>
                </tr>
                <tr>
                    <th>Catatan Customer</th>
                    <td><textarea id="mdl_device_customer_note" disabled="disabled"></textarea></td>
                </tr>
                <tr>
                    <th>Catatan Teknisi</th>
                    <td><textarea id="mdl_device_technician_note" disabled="disabled"></textarea></td>
                </tr>
                <tr>
                    <th>Biaya Service</th>
                    <td><input type="text" size="20" id="mdl_device_cost" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Biaya Cancel</th>
                    <td><input type="text" size="20" id="mdl_device_cancel" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th style="vertical-align:top">Komponen</th>
                    <td>
                        <table id="mdl_device_tbl" class="gridView">
                            <tr>
                                <th style="width:25px;"><div class="tambah" onclick="mdl_component.tambah(mdl_device.service_id, mdl_device.service_device_id);"></div></th>
                                <th>Komponent</th>
                                <th>Modal</th>
                                <th>Total #1</th>
                                <th>Harga</th>
                                <th>Hrg.Cust</th>
                                <th>Total #2</th>                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_component">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Device</th>
                    <td><input id="mdl_component_device" /></td>
                </tr>
                <tr>
                    <th>Cost</th>
                    <td><input type="text" id="mdl_component_cost" size="15" maxlength="15" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Total#1</th>
                    <td><input type="text" id="mdl_component_total1" size="3" maxlength="3" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Harga</th>
                    <td>
                        <input type="text" id="mdl_component_price" size="15" maxlength="15" style="text-align:right;float:left;"/>
                        <div class="select" style="float:left;" onclick="mdl_component.tbl_load()">
                            <br />
                            <div style="height:200px; overflow: scroll; width: 700px;" class="gridView">                                
                                <table  id="mdl_component_tbl_price" >
                                    <tr>
                                        <th style="width:25px;"><input type="checkbox" id="mdl_component_all_customer" title="Cek semua pelanggan"/></th>
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
                    <th>Total#2</th>
                    <td><input type="text" id="mdl_component_total2" size="3" maxlength="3" style="text-align:right;"/></td>
                </tr>
                <tr style="display:none;">
                    <th>PPH 21</th>
                    <td><input type="checkbox" id="mdl_component_pph21"/></td>
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
            tb_no: apl.func.get("cari_no"),
            tb_customer: apl.func.get("cari_customer"),
            tb_sn: apl.func.get("cari_sn"),
            dl_status: apl.createDropdownWS("cari_status", activities.dl_opr_status_service_list),
            dl_marketing_sts: apl.createDropdownWS("cari_marketing_sts", activities.dl_act_marketing_service_status_all_list),
            dl_finance_sts: apl.func.get("cari_finance_sts"),
            dl_technician_sts: apl.createDropdownWS("cari_technician_sts", activities.dl_service_device_sts_all),
            fl: apl.func.get("cari_fr"),
            dl_branch:apl.createDropdownWS("cari_branch",activities.dl_par_branch_list),
            load: function () {
                var no = window.escape(cari.tb_no.value);
                var cust = window.escape(cari.tb_customer.value);
                var status = window.escape(cari.dl_status.value);
                var finance_sts = window.escape(cari.dl_finance_sts.value);
                var sn = window.escape(cari.tb_sn.value);
                var ts = window.escape(cari.dl_technician_sts.value);
                var branch = window.escape(cari.dl_branch.value);
                var ssm = escape(cari.dl_marketing_sts.value);
                cari.fl.src = "opr_service_list.aspx?no=" + no + "&cust=" + cust + "&status=" + status + "&finance_sts=" + finance_sts + "&sn=" + sn + "&ts=" + ts + "&branch=" + branch+"&ssm="+ssm;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                service_id: 0,
                event_sts: false,

                customer_id: 0,

                total_price : 0, 
                total_cost : 0, 
                total_price_pph21: 0,

                lb_no: apl.func.get("mdl_no"),
                tb_date: apl.createCalender("mdl_date"),
                dl_broker: apl.createDropdownWS("mdl_broker", activities.dl_opr_broker_list),
                cb_tax: apl.func.get("mdl_tax"),
                dl_discount_type: apl.createDropdownWS("mdl_discount_type", activities.dl_discount_type_list),
                tb_discount_value: apl.createNumeric("mdl_discount_value", true),
                tb_fee: apl.createNumeric("mdl_fee", true),
                tb_addfee: apl.createNumeric("mdl_addfee", true),
                tb_addfeenote: apl.func.get("mdl_addfeenote"),
                lb_customer: apl.func.get("mdl_customer"),
                lb_marketingsts: apl.func.get("mdl_marketing_sts"),
                lb_reason_marketing: apl.func.get("mdl_reason_marketing"),
                dl_status: apl.createDropdownWS("mdl_status", activities.dl_opr_status_service_list),

                ln_url: apl.func.get("mdl_url"),

                val_date: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Salah input"),
                val_broker: apl.createValidator("save", "mdl_broker", function () { return apl.func.emptyValueCheck(mdl.dl_broker.value); }, "Salah input"),
                val_disctype: apl.createValidator("save", "mdl_discount_type", function () { return apl.func.emptyValueCheck(mdl.dl_discount_type.value); }, "Salah input"),
                val_discvalue: apl.createValidator("save", "mdl_discount_value", function () { return apl.func.emptyValueCheck(mdl.tb_discount_value.value); }, "Salah input"),
                val_fee: apl.createValidator("save", "mdl_fee", function () { return apl.func.emptyValueCheck(mdl.tb_fee.value); }, "Salah input"),
                val_addfee: apl.createValidator("save", "mdl_addfee", function () { return apl.func.emptyValueCheck(mdl.tb_addfee.value); }, "Salah input"),
                val_status: apl.createValidator("save", "mdl_status", function () { return apl.func.emptyValueCheck(mdl.dl_status.value); }, "Salah input"),

                tb_note: apl.func.get("mdl_note"),
                lb_invoice: apl.func.get("mdl_invoice"),
                cb_npwp: apl.func.get("mdl_npwp"),
                ddl_cetak_type: apl.func.get("mdl_cetak_type"),

                lb_ppn: apl.func.get("mdl_ppn"),
                lb_pph: apl.func.get("mdl_pph"),
                tb_total_price: apl.createNumeric("mdl_total_price",true),
                tb_total_cost: apl.createNumeric("mdl_total_cost", true),
                tb_total_addicost: apl.createNumeric("mdl_total_addicost", true),
                tb_total_pph: apl.createNumeric("mdl_total_pph", true),
                tb_total_ppn: apl.createNumeric("mdl_total_ppn", true),
                tb_total_discount: apl.createNumeric("mdl_total_discount", true),
                tb_net: apl.createNumeric("mdl_total_net", true),
                tb_grand: apl.createNumeric("mdl_total_grand", true),
                lb_updatestatusdt : apl.func.get("mdl_updatestatusdt"),

                menghitung:function()
                {
                    var ppn = mdl.total_price * parseFloat(mdl.lb_ppn.innerHTML) / 100;
                    var pph21 = mdl.total_price_pph21 * parseFloat(mdl.lb_pph.innerHTML) / 100;                    
                    var discount = (mdl.dl_discount_type.value == '1') ? mdl.total_price * mdl.tb_discount_value.getIntValue() / 100 : mdl.tb_discount_value.getIntValue();
                    var total = mdl.total_price - discount - pph21 + ppn;
                    var net = mdl.total_price - mdl.total_cost - discount;

                    mdl.tb_total_cost.setValue(mdl.total_cost);
                    mdl.tb_total_price.setValue(mdl.total_price);
                    mdl.tb_total_pph.setValue(pph21);
                    mdl.tb_total_ppn.setValue(ppn);
                    mdl.tb_total_discount.setValue(discount);
                    mdl.tb_net.setValue(net);
                    mdl.tb_grand.setValue(total);
                },
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_device.edit(data.service_id, data.service_device_id);}, undefined, undefined),
                        apl.createTableWS.column("sn"),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("total_cost",undefined,undefined,undefined,true),
                        apl.createTableWS.column("total_price", undefined, undefined, undefined, true),
                        apl.createTableWS.column("total_price_customer", undefined, undefined, undefined, true),
                        apl.createTableWS.column("total_price_pph21", undefined, undefined, undefined, true),
                        apl.createTableWS.column("service_device_sts"),
                    ]
                ),
                tbl_load:function(refresh_total_sts)
                {
                    activities.opr_service_device_list(mdl.service_id,
                        function (arrData) {
                            mdl.total_price = 0;
                            mdl.total_cost = 0;
                            mdl.total_price_pph21 = 0;

                            for (var dt in arrData)
                            {
                                mdl.total_price += arrData[dt].total_price;
                                mdl.total_cost += arrData[dt].total_cost;
                                mdl.total_price_pph21 += arrData[dt].total_price_pph21;                                
                            }

                            //if (refresh_total_sts) mdl.menghitung();

                            mdl.tbl.load(arrData);                            
                        }, apl.func.showError, ""
                    );
                },
                tbladdicost: apl.createTableWS.init("mdl_tbladdicost",
                    [
                        //apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdladdicost.edit(data.addicost_id); }, undefined, undefined),
                        apl.createTableWS.column("addicost_name"),
                        apl.createTableWS.column("addicost_value", undefined, undefined, undefined, true)
                    ]
                ),
                tbladdicost_load: function () {
                    activities.opr_service_addicost_list(mdl.service_id, function (arr) { mdl.tbladdicost.load(arr); }, apl.func.showError, "");
                },
                set_tax:function(nilai)
                {
                    if (nilai != '') {
                        activities.opr_broker_data(nilai,
                            function (data) {
                                mdl.cb_tax.checked = data.par_tax_sts;
                            }, apl.func.showError, ""
                        );
                    }
                },
                open_document: function () {
                    if (mdl.event_sts == false) {
                        activities.opr_service_document_data(mdl.service_id,
                            function (data) {
                                if (data.service_id == 0) alert("Tidak ada file document");
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
                    }
                },
                kosongkan:function()
                {
                    mdl.service_id = 0;
                    mdl.customer_id = 0;
                    mdl.lb_no.innerHTML = "";
                    mdl.tb_date.value = "";
                    mdl.cb_tax.checked = true;
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
                    mdl.tb_total_addicost.value = "";
                    mdl.tb_total_price.value = "";
                    mdl.tb_total_pph.value = "";
                    mdl.tb_total_ppn.value = "";
                    mdl.tb_total_discount.value = "";
                    mdl.tb_net.value = "";
                    mdl.tb_grand.value = "";
                    mdl.dl_broker.value = "";
                    mdl.dl_discount_type.value = "";
                    mdl.lb_invoice.innerHTML = "";

                    mdl.tb_note.value = "";
                    mdl.set_tax(mdl.dl_broker.value);
                    apl.func.validatorClear("save");
                    mdl.ddl_cetak_type.value = "";
                    mdl.lb_updatestatusdt.innerHTML = "";
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.showAdd("Service - Add");                                        
                },
                edit:function(id,show_sts)
                {
                    mdl.kosongkan();
                    mdl.tbl.Show();
                    apl.func.showSinkMessage("Memuat data");
                    mdl.service_id = id;
                    mdl.tbl_load(false);
                    mdl.tbladdicost_load();
                    activities.opr_service_data(id,
                        function (data)
                        {
                            
                            mdl.customer_id = data.customer_id;
                            mdl.lb_no.innerHTML = data.offer_no;
                            mdl.tb_date.value = data.offer_date;
                            mdl.dl_broker.value = data.broker_id;
                            mdl.cb_tax.checked = data.tax_sts;
                            mdl.dl_discount_type.value = data.discount_type_id;
                            mdl.tb_discount_value.setValue(data.discount_value);
                            mdl.tb_fee.setValue(data.fee);                            
                            mdl.tb_addfee.setValue(data.additional_fee);
                            mdl.tb_addfeenote.value = data.additional_fee_note;
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.dl_status.value = data.service_status_id;
                            mdl.lb_marketingsts.innerHTML = data.service_status_marketing;
                            mdl.lb_reason_marketing.innerHTML = data.reason_marketing + " " + data.service_status_marketing_updatedate;

                            mdl.lb_pph.innerHTML = data.pph21;
                            mdl.lb_ppn.innerHTML = data.ppn;
                            mdl.tb_total_cost.setValue(data.total_cost);
                            mdl.tb_total_addicost.setValue(data.total_addicost);
                            mdl.tb_total_price.setValue(data.total_price);
                            mdl.tb_total_pph.setValue(data.total_pph21);
                            mdl.tb_total_ppn.setValue(data.total_ppn);
                            mdl.tb_total_discount.setValue(data.total_discount);
                            mdl.tb_net.setValue(data.net);
                            mdl.tb_grand.setValue(data.grand_price);
                            mdl.cb_npwp.checked = data.npwp_sts;

                            mdl.tb_note.value = data.opr_note;
                            mdl.lb_invoice.innerHTML = data.invoice_no;
                            mdl.lb_updatestatusdt.innerHTML = data.update_status_date;

                            apl.func.hideSinkMessage();
                            if (show_sts == undefined || show_sts == true) mdl.showEdit("Service - Edit");
                        }, apl.func.showError, ""
                    );
                },
                select_service_device:function(service_device_id)
                {
                    apl.func.showSinkMessage("Menambahkan data");
                    activities.opr_service_add(mdl.tb_date.value, mdl.dl_broker.value, mdl.dl_discount_type.value, mdl.tb_discount_value.getIntValue(), mdl.cb_tax.checked, mdl.tb_fee.getIntValue(), service_device_id, mdl.tb_addfee.getIntValue(),mdl.tb_addfeenote.value,
                        function (id) {
                            mdl.edit(id);
                            cari.fl_refresh();
                        }, apl.func.showError, ""
                    );
                },
                customer_info:function()
                {
                    mdl_service_inq.edit(mdl.service_id);
                },
                refresh:function()
                {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                service_device_tambah:function()
                {
                    mdl_device.tambah(mdl.service_id,mdl.customer_id);
                },
                print_offer:function(file_type)
                {
                    if (mdl.service_id != 0)
                    {
                        var fName = mdl.lb_customer.innerHTML + "_" + mdl.lb_no.innerHTML;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=<%= ListID %>&service_id=" + mdl.service_id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }                    
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    document.select_service_device = mdl.select_service_device;
                    mdl_opr_service_assign.open();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan data");
                    activities.opr_service_edit(mdl.service_id, mdl.tb_date.value, mdl.dl_broker.value, mdl.dl_discount_type.value, mdl.tb_discount_value.getIntValue(), mdl.cb_tax.checked, mdl.tb_fee.getIntValue(), mdl.dl_status.value, mdl.tb_note.value, mdl.tb_addfee.getIntValue(),mdl.tb_addfeenote.value,
                        function(ret)
                        {
                            apl.func.hideSinkMessage();
                            if (ret == "0") {
                                cari.fl_refresh();
                                mdl.edit(mdl.service_id, false);
                            } else {
                                alert("Transaksi belum divalidasi");
                            }                            
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Manghapus data");
                    activities.opr_service_delete(mdl.service_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        var mdl_device = apl.createModal("mdl_device",
            {
                service_id: 0,
                service_device_id: 0,                
                lb_sn: apl.func.get("mdl_device_sn"),
                lb_device: apl.func.get("mdl_device_device"),
                tb_customer_note: apl.func.get("mdl_device_customer_note"),
                tb_technician_note: apl.func.get("mdl_device_technician_note"),
                tb_cost: apl.createNumeric("mdl_device_cost", true),
                tb_cancel: apl.createNumeric("mdl_device_cancel", true),
                lb_user: apl.func.get("mdl_device_user"),
                cb_guarantee: apl.func.get("mdl_device_guarantee"),
                val_cost: apl.createValidator("mdl_device_save", "mdl_device_cost", function () { return apl.func.emptyValueCheck(mdl_device.tb_cost.value); }, "Salah input"),
                val_cancel: apl.createValidator("mdl_device_save", "mdl_device_cancel", function () { return apl.func.emptyValueCheck(mdl_device.tb_cancel.value); }, "Salah input"),
                tambah:function(id,customer_id)
                {
                    mdl_device.service_id = id;                    
                    document.select_service_device = mdl_device.add;
                    mdl_opr_service_assign.open(customer_id);
                },
                tbl:apl.createTableWS.init("mdl_device_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_component.edit(mdl_device.service_id, data.service_device_id, data.device_id); }, undefined, undefined),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("cost", undefined, undefined, undefined, true),
                        apl.createTableWS.column("tec_total", undefined, undefined, undefined, true),
                        apl.createTableWS.column("price", undefined, undefined, undefined, true),
                        apl.createTableWS.column("price_customer", undefined, undefined, undefined, true),
                        apl.createTableWS.column("total", undefined, undefined, undefined, true)
                    ]
                ),
                tbl_load:function()
                {
                    activities.xml_opr_service_device_component_list(mdl_device.service_id, mdl_device.service_device_id,
                        function (arrData)
                        {
                            mdl_device.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                add:function(service_device_id)
                {
                    activities.opr_service_device_add(mdl_device.service_id, service_device_id,function ()
                    {
                        mdl_device.edit(mdl_device.service_id, service_device_id);
                    }, apl.func.showError, "");
                },
                edit: function(service_id, service_device_id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl_device.service_id = service_id;
                    mdl_device.service_device_id = service_device_id;
                    mdl_device.tbl_load();
                    activities.opr_service_device_data(service_id, service_device_id,
                        function (data)
                        {
                            mdl_device.lb_device.innerHTML = data.device;
                            mdl_device.lb_sn.innerHTML = data.sn;
                            mdl_device.tb_cost.setValue(data.service_cost);
                            mdl_device.tb_cancel.setValue(data.service_cancel);
                            mdl_device.lb_user.innerHTML = data.user_name;
                            mdl_device.cb_guarantee.checked = data.guarantee_sts;
                            mdl_device.showEdit("Device - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                    activities.tec_service_device_data(service_device_id,
                        function (data) {
                            mdl_device.tb_customer_note.value = data.customer_note;
                            mdl_device.tb_technician_note.value = data.technician_note;
                        }, apl.func.showError, ""
                    );
                },
                refresh: function ()
                {
                    mdl.tbl_load(true);
                    mdl_device.hide();
                    apl.func.hideSinkMessage();
                }
            }, undefined, 
            function ()
            {
                if (apl.func.validatorCheck("mdl_device_save"))
                {
                    apl.func.showSinkMessage("Menyimpan data");
                    activities.opr_service_device_edit(mdl_device.service_id, mdl_device.service_device_id, mdl_device.tb_cost.getIntValue(), mdl_device.tb_cancel.getIntValue(), mdl_device.refresh, apl.func.showError, "");
                }                
            }, 
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Manghapus data");
                    activities.opr_service_device_delete(mdl_device.service_id, mdl_device.service_device_id, mdl_device.refresh, apl.func.showError, "");
                }
            }, "frm_page", "mdl"
        );

        var mdl_component = apl.createModal("mdl_component",
            {
                service_id: 0,
                service_device_id: 0,                
                //ac_device: apl.createAutoComplete("mdl_component_device", activities.ac_part, 500),
                ac_device: apl.create_auto_complete_text("mdl_component_device", activities.ac_part),
                //yogi

                tb_cost: apl.createNumeric("mdl_component_cost", true),
                tb_total1: apl.createNumeric("mdl_component_total1", true),
                tb_price: apl.createNumeric("mdl_component_price", true),
                tb_total2: apl.createNumeric("mdl_component_total2", true),
                cb_pph21: apl.func.get("mdl_component_pph21"),
                cb_all: apl.func.get("mdl_component_all_customer"),
                val_price: apl.createValidator("mdl_component_save", "mdl_component_price", function () { return apl.func.emptyValueCheck(mdl_component.tb_price.value); }, "Salah input"),
                val_total: apl.createValidator("mdl_component_save", "mdl_component_total2", function () { return apl.func.emptyValueCheck(mdl_component.tb_total2.value); }, "Salah input"),
                tbl: apl.createTableWS.init("mdl_component_tbl_price", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "select")], function (data) {mdl_component.tb_price.setValue(data.price); }, undefined, undefined),
                    apl.createTableWS.column("customer_name"),
                    apl.createTableWS.column("offer_date"),
                    apl.createTableWS.column("price", undefined, undefined, undefined, true)                    
                ]),                
                tbl_load:function()
                {
                    apl.func.showSinkMessage("Memuat data");
                    activities.xml_opr_service_device_component_price_history(mdl_component.service_device_id,mdl_component.ac_device.id, mdl.customer_id,mdl_component.cb_all.checked,
                        function (arrData) {
                            mdl_component.tbl.load(arrData);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },                
                kosongkan:function()
                {
                    mdl_component.ac_device.set_value("", "");
                    //mdl_component.ac_device.input.disabled = false;
                    //alert(mdl_component.ac_device.input);
                    mdl_component.tb_cost.value = "";
                    mdl_component.tb_cost.disabled = true;
                    mdl_component.tb_total1.value = "";
                    mdl_component.tb_total1.disabled = true;
                    mdl_component.tb_price.value = "";
                    mdl_component.tb_total2.value = "";
                    mdl_component.cb_pph21.checked = false;
                    mdl_component.cb_all.checked = false;
                    mdl_component.tbl.clearAllRow();
                },
                tambah: function (service_id, service_device_id)
                {
                    mdl_component.service_id = service_id;
                    mdl_component.service_device_id = service_device_id;
                    mdl_component.kosongkan();
                    mdl_component.showAdd("Kompenen - Add")
                },
                edit: function (service_id, service_device_id, device_id)
                {
                    apl.func.showSinkMessage("Memuat data");
                    mdl_component.kosongkan();
                    mdl_component.service_id = service_id;
                    mdl_component.service_device_id = service_device_id;                    
                    activities.xml_opr_service_device_component_data(service_id, service_device_id, device_id,
                        function (data)
                        {
                            //mdl_component.ac_device.input.disabled = data.real_data_sts;                            
                            mdl_component.ac_device.set_value(device_id, data.device);
                            mdl_component.tb_cost.setValue(data.cost);
                            mdl_component.tb_total1.setValue(data.tec_total);
                            mdl_component.tb_price.setValue(data.price);
                            mdl_component.tb_total2.setValue(data.total);
                            mdl_component.cb_pph21.checked = data.pph21;
                            mdl_component.showEdit("Komponen - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    mdl_device.tbl_load();
                    mdl_component.hide();
                    apl.func.hideSinkMessage();
                },
                save: function ()
                {
                    if (apl.func.validatorCheck("mdl_component_save")) {
                        apl.func.showSinkMessage("Menyimpan data");
                        activities.opr_service_device_component_save(mdl_component.service_id, mdl_component.service_device_id, mdl_component.ac_device.id, mdl_component.tb_price.getIntValue(), mdl_component.tb_total2.getIntValue(), mdl_component.cb_pph21.checked,"<%= user_id %>", mdl_component.refresh, apl.func.showError, "");
                    }
                }
            },
            function () {
                mdl_component.save();
            },
            function () {
                mdl_component.save();
            }, 
            function () {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.opr_service_device_component_delete(mdl_component.service_id, mdl_component.service_device_id, mdl_component.ac_device.id, mdl_component.refresh, apl.func.showError, "");
                }
            }, "frm_page", "mdl_device"
        );

        window.addEventListener("load", function ()
        {
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;

            mdl.dl_broker.addEventListener("change", function () {
                mdl.set_tax(this.value);
            });

            cari.dl_branch.setValue("<%= branch_id %>");
        });
    </script>
</asp:Content>

