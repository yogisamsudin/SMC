<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/marketing/wuc_info_customer.ascx" TagPrefix="uc1" TagName="wuc_info_customer" %>
<%@ Register Src="~/activities/marketing/wuc_location_activity.ascx" TagPrefix="uc1" TagName="wuc_location_activity" %>

<script runat="server">
    public string user_id;
    public string branch_id, disabled_sts;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        user_id = a.cookieUserIDValue;
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>

    <table class="formview">
        <tr>
            <th>No</th>
            <td>
                <input type="text" id="cari_no" value="" /></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td>
                <input type="text" id="cari_customer" size="50" value="%" /></td>
        </tr>
        <tr>
            <th>Cabang</th>
            <td>
                <select id="cari_branch" <%= disabled_sts %>></select></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="buttonCari" onclick="cari.load();">Cari</div>
            </td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fr"></iframe>

    <uc1:wuc_info_customer runat="server" ID="mdlinq_customer" parent_id="frm_page" cover_id="mdl" />
    <uc1:wuc_location_activity runat="server" ID="mdl_location" parent_id="frm_page" cover_id="mdl" selected_function="mdl.location_selected" />

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>

            <table class="formview">
                <tr>
                    <th>Tanggal</th>
                    <td>
                        <label id="mdl_date"></label>
                    </td>
                </tr>
                <tr>
                    <th>Nama Pelanggan </th>
                    <td>
                        <input type="text" id="mdl_customer" />
                        <div class="info" onclick="info()" style="float: left;"></div>
                        <!--<div id="mdl_customer" style="float:left;"> </div>&nbsp;<a onclick="info()" style="cursor:pointer;font-weight:bold;">Info</a>-->
                    </td>
                </tr>
                <tr>
                    <th>Cabang Pelanggan</th>
                    <td>
                        <input type="text" id="mdl_branch" size="50" maxlength="50" /></td>
                </tr>
                <tr>
                    <th>Atas Nama</th>
                    <td>
                        <select id="mdl_an"></select></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td>
                        <select id="mdl_contact"></select></td>
                </tr>
                <tr>
                    <th>Alamat Kurir #1</th>
                    <td>
                        <input type="text" id="mdl_pickup_address" />
                        <div style="float: left;" class="select" onclick="mdl.open_location()"></div>
                        <!--
                        <textarea id="mdl_pickup_address" style="float:left" disabled="disabled"></textarea>
                        <div style="float:left;" class="select" onclick="mdl.open_location()"></div>
                        <div style="float:left;" class="tambah" onclick="mdl.add_location()"></div>
                        -->
                    </td>
                </tr>
                <tr>
                    <th>Alamat Kurir #2</th>
                    <td>
                        <input type="text" id="mdl_pickup_address2" size="100" maxlength="300" /></td>
                </tr>
                <tr>
                    <th>Catatan</th>
                    <td>
                        <textarea id="mdl_note" style="max-width: 100%; width: 600px; height: 200px; font-family: 'Courier New';"></textarea></td>
                </tr>
                <tr>
                    <th>Tgl.Kurir</th>
                    <td>
                        <input type="text" id="mdl_pickup_date" size="10" maxlength="10" /></td>
                </tr>
                <tr>
                    <th>Fee</th>
                    <td>
                        <input type="text" id="mdl_fee" style="text-align: right;" /></td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color: gray; text-align: center;">
                        <div class="refresh" style="float: left;" onclick="mdl.load_opr_data();"></div>
                        Operation
                    </th>
                </tr>
                <tr>
                    <th>No.Penawaran</th>
                    <td>
                        <label id="mdl_no"></label>
                    </td>
                </tr>
                <tr>
                    <th>Broker</th>
                    <td>
                        <label id="mdl_broker"></label>
                    </td>
                </tr>
                <tr>
                    <th>Pajak</th>
                    <td>
                        <input type="checkbox" id="mdl_tax" disabled /></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th style="width: 25px"></th>
                                <th>Device</th>
                                <th>HPP</th>
                                <th>Harga Jual</th>
                                <th>Qty</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Total Modal</th>
                    <td>
                        <input type="text" disabled="disabled" style="text-align: right;" size="20" id="mdl_principal" /></td>
                </tr>
                <tr>
                    <th>Total Pofit</th>
                    <td>
                        <input type="text" disabled="disabled" style="text-align: right;" size="20" id="mdl_principalnet" /></td>
                </tr>
                <tr>
                    <th>Discount</th>
                    <td>
                        <select id="mdl_discount_type" style="float:left;" ></select>
                        <input type="text" id="mdl_discount_value" style="float:left;text-align:right;" size="20" />
                    </td>
                </tr>
                <tr >
                    <th>Nilai Invoice</th>
                    <td>
                        <input type="text" disabled="disabled" style="text-align: right;" size="20" id="mdl_total" /></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td>
                        <textarea disabled="disabled" id="mdl_oprnote"></textarea></td>
                </tr>
                <tr>
                    <th>Respon</th>
                    <td>
                        <select id="mdl_marketing_status"></select></td>
                </tr>
                <tr>
                    <th>Alasan</th>
                    <td><select id="mdl_reason"></select></td>
                </tr>
                <tr>
                    <th>File PO</th>
                    <td>
                        <label for="mdl_fu" style="font-weight:bold;cursor:pointer;">Upload</label > | <label style="font-weight:bold;cursor:pointer;" onclick="mdl.open_document()" for="mdl_url">Open</label>
                        <a id="mdl_url" target="_self" style="display:none;">Click</a>
                        <input type="file" id="mdl_fu" style="display:none;"/>
                    </td>
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
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Close" />
                <span style="font-size: small;">Respon terkunci setelah melewati jam tutup transaksi</span>
                <input type="button" value="Print" style="float: right;" onclick="mdl.print_offer();" />
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_addlocation">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Lokasi</th>
                    <td>
                        <input type="text" id="mdl_addlocation_location" autocomplete="off" size="50" /></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>

    <div id="mdl_device">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Device</th>
                    <td><span id="mdl_device_name"></span></td>
                </tr>
                <tr>
                    <th>Keterangan</th>
                    <td>
                        <textarea id="mdl_device_description" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Marketing Note</th>
                    <td>
                        <textarea id="mdl_device_note"></textarea></td>
                </tr>
                <tr>
                    <th>HPP</th>
                    <td>
                        <input type="text" id="mdl_device_principal_price" disabled="disabled" style="text-align: right;" size="15" /></td>
                </tr>
                <tr>
                    <th>Harga Jual</th>
                    <td>
                        <input type="text" id="mdl_device_price" size="15" style="text-align: right; float: left;" />
                        <div class="select" style="float: left;" onclick="mdl_device.tbl_load()">
                            <br />
                            <div style="height: 200px; overflow: scroll; width: 700px;" class="gridView">
                                <table id="mdl_device_tbl_price">
                                    <tr>
                                        <th style="width: 25px;">
                                            <input type="checkbox" id="mdl_device_all_customer" title="Cek semua pelanggan" checked="checked" /></th>
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
                    <td>
                        <input type="text" id="mdl_device_qty" size="3" style="text-align: right;" /></td>
                </tr>
            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_no: apl.func.get("cari_no"),
            tb_customer: apl.func.get("cari_customer"),
            ddl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var no = escape(cari.tb_no.value);
                var user = "<%= user_id %>";
                var cust = escape(cari.tb_customer.value);
                var branch_id = cari.ddl_branch.value;
                cari.fl.src = "sales_confirm_list.aspx?no=" + no + "&user=" + user + "&cust=" + cust + "&branchid=" + escape(branch_id);
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }



        var mdl = apl.createModal("mdl",
            {
                sales_id: 0,
                event_sts: false,
                group_customer_id: 0,
                pickup_address_location_id: 0,
                latitude: "",
                longitude: "",
                lb_date: apl.func.get("mdl_date"),
                tb_branch: apl.func.get("mdl_branch"),
                /*
                ac_customer: apl.createAutoComplete("mdl_customer", activities.ac_customer, 400,
                    function (value,text) {
                        mdl.kosongkan_ac();
                        activities.act_customer_data(value,
                            function (data) {
                                mdl.group_customer_id = data.group_customer_id;                                
                            }, apl.func.showError, ""
                        );
                    }, undefined, function () { mdl.kosongkan_ac(); }),
                */
                ac_customer: apl.create_auto_complete_text("mdl_customer", activities.ac_customer, undefined, 600,
                    function (data) {
                        mdl.dl_an.clearItem();
                        mdl.dl_contact.clearItem();

                        activities.act_customer_data(data.value,
                            function (data) {
                                mdl.group_customer_id = data.group_customer_id;
                            }, apl.func.showError, ""
                        );
                    },
                    function () { return "branch_id like '<%= branch_id %>'"; }
                ),
                dl_an: apl.createDropdownWS("mdl_an", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                dl_contact: apl.createDropdownWS("mdl_contact", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                ddl_reason: apl.createDropdownWS("mdl_reason", activities.dl_marketing_reason),

                //tb_pickup_address: apl.func.get("mdl_pickup_address"),
                tb_pickup_address: apl.create_auto_complete_text("mdl_pickup_address", activities.ac_location_list, function () { mdl_addlocation.tambah(); }, 600),

                tb_pickup_address2: apl.func.get("mdl_pickup_address2"),
                tb_note: apl.func.get("mdl_note"),
                tb_pickup_date: apl.createCalender("mdl_pickup_date"),
                tb_fee: apl.createNumeric("mdl_fee", true),
                dl_marketing_status: apl.createDropdownWS("mdl_marketing_status", activities.dl_act_marketing_service_status_list),
                fl_fu: apl.create_selectfile("mdl_fu", function (e) {
                    mdl.event_sts = true;
                    apl.func.showSinkMessage("Simpan...");
                    apl.func.read_file_readAsArrayBuffer(mdl.fl_fu.get_file(),
                        function (filedata) {
                            activities.opr_sales_document_save(mdl.sales_id, mdl.fl_fu.get_info().name, filedata, mdl.fl_fu.get_info().type, function () { apl.func.hideSinkMessage(); mdl.event_sts = false; }, apl.func.showError, "");
                        }
                    );
                }),
                dl_discount_type: apl.createDropdownWS("mdl_discount_type", activities.dl_discount_type_list),
                tb_discount_value: apl.createNumeric("mdl_discount_value", true),

                val_customer: apl.createValidator("save", "mdl_customer", function () { return (mdl.ac_customer.id == "") ? true : false; }, "Salah input"),
                val_an: apl.createValidator("save", "mdl_an", function () { return apl.func.emptyValueCheck(mdl.dl_an.value); }, "Salah input"),
                val_contact: apl.createValidator("save", "mdl_contact", function () { return apl.func.emptyValueCheck(mdl.dl_contact.value); }, "Salah input"),
                val_pickup_address: apl.createValidator("save", "mdl_pickup_address", function () { return apl.func.emptyValueCheck(mdl.tb_pickup_address.value); }, "Salah input"),
                val_delivery_date: apl.createValidator("save", "mdl_pickup_date", function () { return (mdl.tb_pickup_date.value == "") ? true : false; }, "Salah input"),
                val_fee: apl.createValidator("save", "mdl_fee", function () { return (mdl.tb_fee.value == "") ? true : false; }, "Salah input"),
                val_marketing_status: apl.createValidator("save", "mdl_marketing_status", function () { return apl.func.emptyValueCheck(mdl.dl_marketing_status.value); }, "Salah input"),
                val_marketing_reason: apl.createValidator("save", "mdl_reason", function () { return apl.func.emptyValueCheck(mdl.ddl_reason.value); }, "Salah input"),

                lb_no: apl.func.get("mdl_no"),
                lb_broker: apl.func.get("mdl_broker"),
                cb_tax: apl.func.get("mdl_tax"),
                tb_principal: apl.createNumeric("mdl_principal", true),
                tb_principalnet: apl.createNumeric("mdl_principalnet", true),
                tb_total: apl.createNumeric("mdl_total", true),
                tb_oprnote: apl.func.get("mdl_oprnote"),
                ln_url: apl.func.get("mdl_url"),


                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_device.edit(data.sales_id, data.device_id); }, undefined, undefined),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("principal_price", undefined, undefined, undefined, true),
                        apl.createTableWS.column("price", undefined, undefined, undefined, true),
                        apl.createTableWS.column("qty", undefined, undefined, undefined, true)
                        //,apl.createTableWS.column("pph21_sts", undefined, [apl.createTableWS.attribute("type", "checkbox"), apl.createTableWS.attribute("disabled", "disabled")], undefined, undefined, "input","checked")
                    ]
                ),
                tbl_load: function (id) {
                    activities.opr_sales_device_list(id,
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

                get_customer_id: function (nilai) {
                    if (apl.func.emptyValueCheck(nilai)) {
                        return "1"
                    } else {
                        return nilai;
                    }
                },
                kosongkan_ac: function () {
                    mdl.dl_an.load("");
                    mdl.dl_contact.load("");
                },
                load_opr_data: function () {
                    activities.opr_sales_data(mdl.sales_id,
                        function (data) {
                            mdl.lb_no.innerHTML = data.offer_no;
                            mdl.lb_broker.innerHTML = data.broker_name;
                            mdl.cb_tax.checked = data.tax_sts;
                            mdl.tb_principal.setValue(data.total_principal);
                            mdl.tb_principalnet.setValue(data.principal_net);
                            mdl.tb_total.setValue(data.grand_price);
                            mdl.tb_oprnote.value = data.opr_note;
                            mdl.dl_marketing_status.value = data.sales_status_marketing_id;
                            mdl.ddl_reason.value = data.reason_marketing_id;

                            mdl.tbllog_load();
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                edit: function (id) {
                    apl.func.validatorClear("save");
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.tbl_load(id);

                    activities.act_sales_data(id,
                        function (data) {
                            mdl.group_customer_id = data.group_customer_id;
                            mdl.sales_id = data.sales_id;
                            mdl.pickup_address_location_id = data.delivery_address_location_id;
                            mdl.lb_date.innerHTML = data.sales_call_date;
                            //mdl.ac_customer.setValue(data.customer_id, data.customer_name);
                            mdl.ac_customer.set_value(data.customer_id, data.customer_name);
                            mdl.dl_an.load(data.an_id);
                            mdl.dl_contact.load(data.contact_id);
                            //mdl.tb_pickup_address.value = data.delivery_address_location;
                            mdl.tb_pickup_address.set_value(data.delivery_address_location_id, data.delivery_address_location);

                            mdl.tb_pickup_address2.value = data.delivery_address;
                            mdl.tb_note.value = data.note;
                            mdl.tb_pickup_date.value = data.delivery_date;
                            mdl.tb_fee.setValue(data.fee);
                            mdl.latitude = data.latitude;
                            mdl.longitude = data.longitude;
                            mdl.tb_branch.value = data.branch_customer;

                            mdl.load_opr_data();
                            mdl.showEdit("Servis - Edit");
                        }, apl.func.showError, ""
                    );

                    activities.opr_sales_data(id,
                        function (data) {
                            mdl.dl_discount_type.value = data.discount_type_id;
                            mdl.tb_discount_value.setValue(data.discount_value);
                        }, apl.func.showError, ""
                    );


                },
                open_document: function () {
                    if (mdl.event_sts == false) {
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
                    }
                },
                refresh_modal: function () {
                    //mdl.hide();
                    cari.fl_refresh();
                    //apl.func.hideSinkMessage();
                },
                add_pickup_address: function () {
                    document.mdl_location.open(2);
                },
                open_location: function () {
                    if (mdl.ac_customer.id != "") document.mdl_location.open(1, mdl.group_customer_id);
                },
                add_location: function () {
                    if (mdl.ac_customer.id != "") document.mdl_location.open(2);
                },
                location_selected: function (location_id, location_address, customer_address) {
                    mdl.pickup_address_location_id = location_id;
                    mdl.tb_pickup_address.set_value(location_id, location_address);
                    mdl.tb_pickup_address2.value = customer_address;
                },
                print_offer: function () {
                    var fName = mdl.ac_customer.text + "_" + mdl.lb_no.innerHTML;
                    fName = window.escape(fName.replace(/ /g, "_"));
                    window.location = "../../report/report_generator.ashx?ListID=5&sales_id=" + mdl.sales_id + "&pdfName=" + fName;
                }
            }, undefined,
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Simpan...");

                    activities.opr_sales_edit_marketing(mdl.sales_id, mdl.dl_marketing_status.value, mdl.ddl_reason.value, '<%= user_id %>', mdl.dl_discount_type.value, mdl.tb_discount_value.getIntValue(),
                        function (pesan) {
                            apl.func.hideSinkMessage();
                            if (pesan == '') {
                                activities.act_sales_edit(mdl.sales_id, mdl.ac_customer.id, mdl.dl_an.value, mdl.dl_contact.value, mdl.tb_pickup_address2.value, mdl.tb_note.value, mdl.tb_pickup_address.id, mdl.tb_fee.getIntValue(), mdl.tb_pickup_date.value, mdl.latitude, mdl.longitude, mdl.tb_branch.value, mdl.refresh_modal, apl.func.showError, "");
                                if (mdl.dl_marketing_status.value == "2") mdl.hide(); else mdl.edit(mdl.sales_id);
                            } else alert(pesan);

                        }, apl.func.showError, ""
                    );
                    //if (mdl.fl_fu.check_file()) activities.opr_sales_document_save(mdl.sales_id, mdl.fl_fu.get_info().name, mdl.fl_fu.get_array(), mdl.fl_fu.get_info().type, function () { mdl.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, ""); else apl.func.hideSinkMessage();
                    //ddalert(mdl.fl_fu.get_array());
                    //alert(mdl.fl_fu.get_info().name);
                    //activities.opr_sales_document_save(mdl.sales_id, mdl.fl_fu.get_info().name, mdl.fl_fu.get_array(), function () { }, apl.func.showError, "");
                }
            }, undefined, "frm_page", "cover_content"
        );

            var mdl_addlocation = apl.createModal("mdl_addlocation",
                {
                    tb_location: apl.func.get("mdl_addlocation_location"),
                    val_location: apl.createValidator("save_location", "mdl_addlocation_location", function () { return apl.func.emptyValueCheck(mdl_addlocation.tb_location.value); }, "Invalid input"),
                    tambah: function () {
                        apl.func.validatorClear("save_location");
                        mdl_addlocation.tb_location.value = "";
                        mdl_addlocation.showAdd("Lokasi - Tambah");
                    }
                },
                function () {
                    if (apl.func.validatorCheck("save_location")) {
                        apl.func.showSinkMessage("Menyimpan...");
                        activities.exp_location_add(mdl_addlocation.tb_location.value, 0, function () { mdl_addlocation.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                    }
                },
                undefined, undefined, "frm_page", "mdl"
            );

            info = function () {
                var id = mdl.ac_customer.id;
                if (id > 0) document.mdlinq_customer.info(id);
            }

            window.addEventListener("load", function () {
                document.list_edit = mdl.edit;
                cari.load();
                cari.ddl_branch.setValue("<%= branch_id %>");
            });

            var mdl_device = apl.createModal("mdl_device",
                {
                    sales_id: 0,
                    device_id: 0,
                    cost: 0,
                    pph: false,
                    vendor_id: 0,
                    device_id: 0,
                    lb_device: apl.func.get("mdl_device_name"),
                    tb_principal_price: apl.createNumeric("mdl_device_principal_price", true),
                    tb_price: apl.createNumeric("mdl_device_price", true),
                    //lb_qty: apl.func.get("mdl_device_qty"),                
                    lb_qty: apl.createNumeric("mdl_device_qty"),
                    tb_description: apl.func.get("mdl_device_description"),
                    tb_note: apl.func.get("mdl_device_note"),
                    cb_all: apl.func.get("mdl_device_all_customer"),

                    //val_price1: apl.createValidator("device_save", "mdl_device_price", function () { return apl.func.emptyValueCheck(mdl_device.tb_price.value); }, "Salah input"),
                    val_price2: apl.createValidator("device_save", "mdl_device_price", function () { return (mdl_device.tb_price.getIntValue() < mdl_device.tb_principal_price.getIntValue()) }, "Nilai lebih kecil dari harga pokok"),

                    tbl: apl.createTableWS.init("mdl_device_tbl_price", [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "select")], function (data) { mdl_device.tb_price.setValue(data.price); }, undefined, undefined),
                        apl.createTableWS.column("customer_name"),
                        apl.createTableWS.column("offer_date"),
                        apl.createTableWS.column("price", undefined, undefined, undefined, true)
                    ]),
                    tbl_load: function () {
                        apl.func.showSinkMessage("Memuat data");
                        activities.xml_opr_sales_device_price_history(mdl_device.device_id, mdl.group_customer_id, mdl_device.cb_all.checked, mdl_device.sales_id,
                            function (arrData) {
                                mdl_device.tbl.load(arrData);
                                apl.func.hideSinkMessage();
                            }, apl.func.showError, ""
                        );
                    },
                    kosongkan: function () {
                        apl.func.validatorClear("device_save");
                        mdl_device.lb_device.innerHTML = "";
                        mdl_device.tb_principal_price.innerHTML = "";
                        mdl_device.tb_price.value = "";
                        mdl_device.lb_qty.value = "";
                        mdl_device.tb_description.value = "";
                        mdl_device.tbl.clearAllRow();
                        mdl_device.tb_note.value = "";
                    },
                    edit: function (sales_id, device_id) {
                        mdl_device.sales_id = sales_id;
                        mdl_device.device_id = device_id;
                        apl.func.showSinkMessage("Memuat Data");
                        activities.opr_sales_device_data(sales_id, device_id,
                            function (data) {
                                mdl_device.kosongkan();
                                mdl_device.lb_device.innerHTML = data.device;
                                mdl_device.sales_id = sales_id;
                                mdl_device.cost = data.cost;
                                mdl_device.pph = data.pph21_sts;
                                mdl_device.vendor_id = data.vendor_id;
                                mdl_device.tb_principal_price.setValue(data.principal_price);
                                mdl_device.tb_price.setValue(data.price);
                                //mdl_device.lb_qty.innerHTML = data.qty;
                                mdl_device.lb_qty.value = data.qty;
                                mdl_device.tb_description.value = data.description;
                                mdl_device.tb_note.value = data.marketing_note;

                                mdl_device.showEdit("Device - Edit");
                                apl.func.hideSinkMessage();
                            }, apl.func.showError, ""
                        );
                    },
                }, undefined,
                function () {
                    if (apl.func.validatorCheck("device_save")) {
                        apl.func.showSinkMessage("Save...");
                        activities.opr_sales_device_save(mdl_device.sales_id, mdl_device.device_id, mdl_device.cost, mdl_device.tb_price.getIntValue(), parseInt(mdl_device.lb_qty.getIntValue()), mdl_device.pph, mdl_device.tb_description.value, mdl_device.vendor_id, mdl_device.tb_principal_price.getIntValue(), mdl_device.tb_note.value, "<%= user_id %>",
                        function () {
                            mdl.load_opr_data();
                            mdl.tbl_load(mdl_device.sales_id);
                            mdl_device.hide();
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                    }
                }, undefined, "frm_page", "mdl"
        );
    </script>
</asp:Content>

