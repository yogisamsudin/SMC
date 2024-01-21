<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/marketing/wuc_service_inq.ascx" TagPrefix="uc1" TagName="wuc_service_inq" %>
<%@ Register Src="~/activities/technician/wuc_device_register_select.ascx" TagPrefix="uc1" TagName="wuc_device_register_select" %>



<script runat="server">    
    public string branch_id, disabled_sts;

    void Page_Load(object o, EventArgs e)
    {
        _test.App a = new _test.App(Request, Response);
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";

        //Response.Write("url:" +HttpContext.Current.Request.Url.Port+HttpContext.Current.Request.ApplicationPath);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
    <script type="text/javascript" src="../../js/gridjs.development.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
            <asp:ServiceReference Path="~/gridslist.asmx" />
        </Services>
    </asp:ScriptManager>

    <table class="formview">
        <tr>
            <th>SN</th>
            <td>
                <input type="text" id="cari_sn" size="50" maxlength="50" /></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td>
                <input type="text" size="50" maxlength="50" id="cari_customer" /></td>
        </tr>
        <tr>
            <th>Status</th>
            <td>
                <select id="cari_status"></select></td>
        </tr>
        <tr>
            <th>Status Opr.</th>
            <td>
                <select id="cari_operation_status"></select></td>
        </tr>
        <tr>
            <th>Status Pengiriman</th>
            <td>
                <select id="cari_schedule_status">
                    <option value="%">--ALL--</option>
                    <option value="0">Belum</option>
                    <option value="1">Terkirim</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>Status Inventory</th>
            <td>
                <select id="cari_inventory">
                    <option value="%">--ALL--</option>
                    <option value="0">Bukan</option>
                    <option value="1">Ya</option>
                </select>
            </td>
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

    <iframe class="frameList" id="cari_fr" style="display: none;"></iframe>

    <uc1:wuc_service_inq runat="server" ID="mdl_service_inq" parent_id="frm_page" cover_id="mdl" />
    <uc1:wuc_device_register_select runat="server" ID="mdl_device_register_select" function_select="document.get_device_register" parent_id="frm_page" cover_id="mdl" />

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th colspan="2" style="background-color: gray; color: white; text-align: center;">Info Ekspedisi</th>
                </tr>
                <tr>
                    <th>Jadwal</th>
                    <td>
                        <div style="width: 500px; height: 100px; overflow: hidden">
                            <table class="gridView" id="mdl_tbl_schedule" style="width: 100%">
                                <tr>
                                    <th>ID</th>
                                    <th>Tanggal</th>
                                    <th>Tipe</th>
                                    <th>Kurir</th>
                                    <th>Kontak</th>
                                </tr>
                            </table>
                        </div>

                    </td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color: gray; color: white; text-align: center;">Info Penawaran</th>
                </tr>
                <tr>
                    <th>No.Penawaran</th>
                    <td>
                        <label id="mdl_offer_no"></label>
                    </td>
                </tr>
                <tr>
                    <th>Status Penawaran</th>
                    <td>
                        <label id="mdl_service_status"></label>
                    </td>
                </tr>
                <tr>
                    <th>Status Konfirmasi</th>
                    <td>
                        <label id="mdl_service_status_marketing"></label>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color: gray; color: white; text-align: center;">Info Invoice</th>
                </tr>
                <tr>
                    <th>No.Invoice</th>
                    <td>
                        <label id="mdl_invoice_no"></label>
                    </td>
                </tr>
                <tr>
                    <th>Status Penawaran</th>
                    <td>
                        <label id="mdl_invoice_date"></label>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color: gray; color: white; text-align: center;">Data Teknisi</th>
                </tr>
                <tr>
                    <th>Info Marketing</th>
                    <td>
                        <div class="info" onclick="mdl.marketing_info();"></div>
                    </td>
                </tr>

                <tr>
                    <th>Tanggal Masuk</th>
                    <td>
                        <label id="mdl_datein"></label>
                    </td>
                </tr>
                <tr>
                    <th>SN</th>
                    <td>
                        <input type="text" id="mdl_sn" size="50" maxlength="50" style="float: left;" />
                        <div class="select" style="float: left" onclick="mdl.select_device_register();" title="pilih dari sn yang sudah ada"></div>
                        <div class="tambah" style="float: left" onclick="mdl.kosongkan_device_register();" title="Buat sn baru"></div>
                    </td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td>
                        <input type="text" id="mdl_device" /></td>
                </tr>
                <tr>
                    <th>Catatan Customer</th>
                    <td>
                        <textarea id="mdl_customer_note" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Nama User</th>
                    <td>
                        <input type="text" id="mdl_user" size="50" maxlength="50" /></td>
                </tr>
                <tr>
                    <th>Garansi</th>
                    <td>
                        <input type="checkbox" id="mdl_guarantee" /></td>
                </tr>
                <tr>
                    <th>Catatan Teknisi</th>
                    <td>
                        <textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th>Kelengkapan</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width: 25px;"></th>
                                <th>Kelengkapan</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Teknisi</th>
                    <td>
                        <select id="mdl_technician"></select></td>
                </tr>
                <tr>
                    <th>Sub Kontrak</th>
                    <td>
                        <table class="gridView" id="mdl_tbl_vendor">
                            <tr>
                                <th>
                                    <div class="tambah" title="tambah transaksi sub kontrak" onclick="mdl.tambah_subkontrak();"></div>
                                </th>
                                <th>Vendor</th>
                                <th>Tgl.Masuk</th>
                                <th>Tgl.Keluar</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Komponen</th>
                    <td>
                        <table class="gridView" id="mdl_tbl_component">
                            <tr>
                                <th>
                                    <div class="tambah" title="tambah komponen" onclick="mdl.tambah_component()"></div>
                                </th>
                                <th>Komponen</th>
                                <th>Biaya</th>
                                <th>Total</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Tanggal Selesai</th>
                    <td>
                        <input type="text" id="mdl_date_done" size="10" /></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td>
                        <select id="mdl_status"></select></td>
                </tr>
                <tr>
                    <th>Inventory ID</th>
                    <td>
                        <label id="mdl_inventory_id"></label>
                    </td>
                </tr>
                <!--
                <tr>
                    <th colspan="2" style="background-color:gray;color:white;text-align:center;">Info Ekspedisi</th>                    
                </tr>                
                <tr>
                    <th>Tanggal</th>
                    <td><label id="mdl_schedule_date"></label></td>
                </tr>
                <tr>
                    <th>ID</th>
                    <td><label id="mdl_schedule_id"></label></td>
                </tr>
                -->
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>
    <div id="mdl_vendor">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Vendor</th>
                    <td>
                        <input type="text" id="mdl_vendor_name" /></td>
                </tr>
                <tr>
                    <th>Tgl.Masuk</th>
                    <td>
                        <input type="text" id="mdl_vendor_date_in" size="10" maxlength="10" /></td>
                </tr>
                <tr>
                    <th>Tgl.Keluar</th>
                    <td>
                        <input type="text" id="mdl_vendor_date_out" size="10" maxlength="10" /></td>
                </tr>
                <tr>
                    <th>Catatan</th>
                    <td>
                        <textarea id="mdl_vendor_note"></textarea></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td>
                        <select id="mdl_vendor_status"></select></td>
                </tr>
            </table>
            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>

    <div id="mdl_component">
        <fieldset>
            <legend></legend>

            <table class="formview">
                <tr>
                    <th>Device</th>
                    <td>
                        <input type="text" id="mdl_component_device" /></td>
                </tr>
                <tr>
                    <th>Biaya</th>
                    <td>
                        <input type="text" size="15" maxlength="15" style="text-align: right;" id="mdl_component_cost" /></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td>
                        <input type="text" size="3" maxlength="3" style="text-align: right;" id="mdl_component_total" /></td>
                </tr>
            </table>

            <div style="padding-top: 5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save" />
                <input type="button" value="Delete" />
                <input type="button" value="Cancel" />
            </div>

        </fieldset>
    </div>
    <!--<div class="edit" onclick="load_grid()"></div>-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">

    <script type="text/javascript">

        let g = new gridjs.Grid({
            columns: [
                { id: 'service_device_id', name: '#' },
                { id: 'date_in', name: 'Tanggal' },
                { id: 'sn', name: 'Serial Number' },
                { id: 'device', name: 'Device' },
                { id: 'customer_name', name: 'Customer' }
            ],
            sort: true,
            multiColumn: false,
            pagination: {
                enabled: true,
                limit: 10,

            },
            data: []

        }).render(document.getElementById("grid_list"));

        function load_grid() {
            var sn = escape("%" + cari.tb_sn.value);
            var name = escape("%" + cari.tb_customer.value);
            var sts1 = escape(cari.dl_status.value);
            var sts2 = escape(cari.dl_operation_status.value);
            var send = cari.dl_schedule.value;
            var inv = cari.dl_inventory.value;
            var _url = '@gridlist.ashx?kode=service_device&sn=' + sn + '&name=' + name + '&status=' + sts1 + '&status_opr=' + sts2 + '&status_send=' + send + '&inventory=' + inv;
            //alert(_url);

            g.updateConfig({
                server: {
                    url: _url,

                    then: function (data) {
                        //alert(JSON.stringify(data));
                        return data.map(function (d) {
                            return [
                                gridjs.html('<div class="edit" onclick="mdl.edit(' + d.service_device_id + ')"></div>'),
                                d.date_in, d.sn, d.device, d.customer_name]
                        })
                    },

                    total: function (data) { return data.count; }
                }
            }).forceRender();
            //alert("refresh");
        }


        var cari = {
            tb_sn: apl.func.get("cari_sn"),
            tb_customer: apl.func.get("cari_customer"),
            dl_status: apl.createDropdownWS("cari_status", activities.dl_service_device_sts_all),
            dl_operation_status: apl.createDropdownWS("cari_operation_status", activities.dl_opr_status_service_all_list),
            dl_schedule: apl.func.get("cari_schedule_status"),
            dl_inventory: apl.func.get("cari_inventory"),
            dl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            fl: apl.func.get("cari_fr"),
            load: function () {
                /*
                var sn = escape("%" + cari.tb_sn.value);
                var name = escape("%" + cari.tb_customer.value);
                var sts1 = escape(cari.dl_status.value);
                var sts2 = escape(cari.dl_operation_status.value);
                var send = cari.dl_schedule.value;
                var inv = cari.dl_inventory.value;

                cari.fl.src = "service_device_list.aspx?sn=" + sn + "&status=" + sts1 + "&name=" + name + "&status_opr=" + sts2 + "&status_send=" + send + "&inventory=" + inv + "&branch=" + cari.dl_branch.value;
                */
                load_grid();
            },
            fl_refresh: function () {
                //cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                opr_service_id: 0,
                service_device_id: 0,
                service_id: 0,
                device_register_id: 0,
                device_type_id: 0,
                lb_datein: apl.func.get("mdl_datein"),
                tb_sn: apl.createCharFiltering("mdl_sn"),
                ac_device: apl.create_auto_complete_text("mdl_device", activities.ac_device),
                tb_customer_note: apl.func.get("mdl_customer_note"),
                cb_guarantee: apl.func.get("mdl_guarantee"),
                dl_status: apl.createDropdownWS("mdl_status", activities.dl_service_device_sts),
                tb_note: apl.func.get("mdl_note"),
                dl_technician: apl.createDropdownWS("mdl_technician", activities.dl_tec_technician_list, undefined, undefined, false),
                tb_date_done: apl.createCalender("mdl_date_done"),
                tb_user: apl.func.get("mdl_user"),
                lb_offer_no: apl.func.get("mdl_offer_no"),
                lb_service_status: apl.func.get("mdl_service_status"),
                lb_service_status_marketing: apl.func.get("mdl_service_status_marketing"),
                lb_invoice_no: apl.func.get("mdl_invoice_no"),
                lb_invoice_date: apl.func.get("mdl_invoice_date"),
                lb_inventory_id: apl.func.get("mdl_inventory_id"),
                //lb_schedule_id: apl.func.get("mdl_schedule_id"),
                //lb_schedule_date:apl.func.get("mdl_schedule_date"),

                val_sn: apl.createValidator("save", "mdl_sn", function () { return apl.func.emptyValueCheck(mdl.tb_sn.value); }, "Salah input"),
                val_device: apl.createValidator("save", "mdl_device", function () { return apl.func.emptyValueCheck(mdl.ac_device.input.value); }, "Salah input"),

                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("status", undefined,
                            [apl.createTableWS.attribute("type", "checkbox")],
                            function (data) { mdl.trimming_edit(data.device_type_trimming_id, this.checked); },
                            undefined, "input", "checked", function (elm, datum) { }),
                        apl.createTableWS.column("trimming_name")
                    ]
                ),
                tbl_load: function () {
                    activities.xml_tec_service_device_trimming_list(mdl.service_device_id, mdl.device_type_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbl_vendor: apl.createTableWS.init("mdl_tbl_vendor",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl.edit_subkontrak(data.service_device_vendor_id); }, undefined, undefined),
                        apl.createTableWS.column("vendor_name"),
                        apl.createTableWS.column("date_in"),
                        apl.createTableWS.column("date_out")
                    ]
                ),
                tbl_vendor_load: function () {
                    activities.tec_service_device_vendor_list(mdl.service_device_id,
                        function (arrData) {
                            mdl.tbl_vendor.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbl_component: apl.createTableWS.init("mdl_tbl_component",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl.edit_component(data.service_device_id, data.device_id); }, undefined, undefined),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("cost", undefined, undefined, undefined, true),
                        apl.createTableWS.column("total")
                    ]
                ),
                tbl_component_load: function () {
                    activities.tec_service_device_component_list(mdl.service_device_id,
                        function (arrData) {
                            mdl.tbl_component.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbl_schedule: apl.createTableWS.init("mdl_tbl_schedule",
                    [
                        apl.createTableWS.column("schedule_id"),
                        apl.createTableWS.column("schedule_date"),
                        apl.createTableWS.column("expedition_type"),
                        apl.createTableWS.column("messanger_name"),
                        apl.createTableWS.column("exp_contact")
                    ]
                ),
                tbl_schedule_load: function () {
                    activities.xml_tec_service_device_schedule(mdl.service_device_id,
                        function (arrData) {
                            mdl.tbl_schedule.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                trimming_edit: function (trimming_id, cek_sts) {
                    activities.tec_service_device_trimming_add(mdl.service_device_id, trimming_id, cek_sts,
                        function () {
                            mdl.tbl_load();
                        }, apl.func.showError, ""
                    );
                },
                marketing_info: function () {
                    document.mdl_service_inq.edit(mdl.opr_service_id);
                },
                expedition_info: function () {

                },
                operation_info: function () {

                },
                finance_info: function () {

                },
                kosongkan_device_register: function () {
                    mdl.device_register_id = 0;
                    mdl.tb_sn.value = "";
                    mdl.ac_device.set_value("", "");
                    mdl.tb_user.value = "";
                },
                select_device_register: function () {
                    mdl_device_register_select.open();
                },
                kosongkan: function () {
                    mdl.service_id = 0;
                    mdl.service_device_id = 0;
                    mdl.device_register_id = 0;
                    mdl.dl_technician.load();
                    apl.func.validatorClear("save");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    activities.tec_service_device_data(id,
                        function (data) {
                            mdl.service_device_id = id;
                            mdl.service_id = data.service_id;
                            mdl.device_register_id = data.device_register_id;
                            mdl.device_type_id = data.device_type_id;
                            mdl.lb_datein.innerHTML = data.date_in;
                            mdl.tb_sn.value = data.sn;
                            mdl.ac_device.set_value(data.device_id, data.device);
                            mdl.tb_customer_note.value = data.customer_note;
                            mdl.cb_guarantee.checked = data.guarantee_sts;
                            mdl.dl_status.value = data.service_device_sts_id;
                            mdl.tb_note.value = data.technician_note;
                            mdl.dl_technician.value = data.technician_id;
                            mdl.tb_date_done.value = data.date_done;
                            mdl.tb_user.value = data.user_name;
                            mdl.lb_offer_no.innerHTML = data.offer_no;
                            mdl.lb_service_status.innerHTML = data.service_status;
                            mdl.lb_service_status_marketing.innerHTML = data.service_status_marketing;
                            mdl.lb_invoice_no.innerHTML = data.invoice_no;
                            mdl.lb_invoice_date.innerHTML = data.invoice_date;
                            mdl.opr_service_id = data.opr_service_id;
                            mdl.lb_inventory_id.innerHTML = (data.last_inventory_id == 0) ? "" : data.last_inventory_id;
                            //mdl.lb_schedule_id.innerHTML = data.schedule_id;
                            //mdl.lb_schedule_date.innerHTML = data.schedule_date;

                            mdl.tbl_load();
                            mdl.tbl_vendor_load();
                            mdl.tbl_component_load();
                            mdl.tbl_schedule_load();

                            mdl.showEdit("Service Barang - Edit (#" + data.service_device_id + ')');
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );

                },
                refresh: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                tambah_subkontrak: function () {
                    mdl_vendor.tambah(mdl.service_device_id);
                },
                edit_subkontrak: function (id) {
                    mdl_vendor.edit(id);
                },
                tambah_component: function () {
                    mdl_component.tambah(mdl.service_device_id);
                },
                edit_component: function (service_device_id, device_id) {
                    mdl_component.edit(service_device_id, device_id);
                }
            },
            undefined,
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_edit(mdl.service_device_id, mdl.lb_datein.innerHTML, mdl.device_register_id, mdl.tb_sn.value, mdl.ac_device.id, mdl.cb_guarantee.checked, mdl.tb_note.value, mdl.dl_status.value, mdl.dl_technician.value, mdl.tb_date_done.value, mdl.tb_user.value, mdl.refresh, apl.func.showError, "");
                }
            },
            undefined,
            "main_panel",
            //"frm_page",
            "second_panel"
            //"cover_content"
        );

        var mdl_vendor = apl.createModal("mdl_vendor",
            {
                service_device_vendor_id: 0,
                service_device_id: 0,
                ac_vendor: apl.create_auto_complete_text("mdl_vendor_name", activities.ac_vendor),
                tb_datein: apl.createCalender("mdl_vendor_date_in"),
                tb_dateout: apl.createCalender("mdl_vendor_date_out"),
                tb_note: apl.func.get("mdl_vendor_note"),
                dl_status: apl.createDropdownWS("mdl_vendor_status", activities.dl_service_vendor_status_list),
                val_vendor: apl.createValidator("mdl_vendor_save", "mdl_vendor_name", function () { return apl.func.emptyValueCheck(mdl_vendor.ac_vendor.input.value); }, "Salah input"),
                val_datein: apl.createValidator("mdl_vendor_save", "mdl_vendor_date_in", function () { return apl.func.emptyValueCheck(mdl_vendor.tb_datein.value); }, "Salah input"),
                kosongkan: function () {
                    mdl_vendor.service_device_vendor_id = 0;
                    mdl_vendor.service_device_id = 0;
                    mdl_vendor.ac_vendor.set_value("", "");
                    mdl_vendor.tb_datein.value = "";
                    mdl_vendor.tb_dateout.value = "";
                    mdl_vendor.dl_status.value = "1";
                    apl.func.validatorClear("mdl_vendor_save");
                },
                tambah: function (service_device_id) {
                    mdl_vendor.kosongkan();
                    mdl_vendor.service_device_id = service_device_id;
                    mdl_vendor.showAdd("Sub Kontrak - Tambah");
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl_vendor.kosongkan();
                    activities.tec_service_device_vendor_data(id,
                        function (data) {
                            mdl_vendor.service_device_vendor_id = id;
                            mdl_vendor.service_device_id = data.service_device_id;
                            mdl_vendor.ac_vendor.set_value(data.vendor_id, data.vendor_name);
                            mdl_vendor.tb_datein.value = data.date_in;
                            mdl_vendor.tb_dateout.value = data.date_out;
                            mdl_vendor.tb_note.value = data.vendor_note;
                            mdl_vendor.dl_status.value = data.service_vendor_sts_id;
                            mdl_vendor.showEdit("Sub Kontrak - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    mdl_vendor.hide();
                    mdl.tbl_vendor_load();
                    apl.func.hideSinkMessage();
                }
            },
            function () {
                if (apl.func.validatorCheck("mdl_vendor_save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_vendor_tambah(mdl_vendor.service_device_id, mdl_vendor.ac_vendor.id, mdl_vendor.tb_datein.value, mdl_vendor.tb_dateout.value, mdl_vendor.tb_note.value, mdl_vendor.dl_status.value, mdl_vendor.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("mdl_vendor_save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_vendor_edit(mdl_vendor.service_device_vendor_id, mdl_vendor.ac_vendor.id, mdl_vendor.tb_datein.value, mdl_vendor.tb_dateout.value, mdl_vendor.tb_note.value, mdl_vendor.dl_status.value, mdl_vendor.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus")) {
                    activities.tec_service_device_vendor_delete(mdl_vendor.service_device_vendor_id, mdl_vendor.refresh, apl.func.showError, "");
                }
            },
            //"frm_page",
            "main_panel",
            "mdl"
        );

        var mdl_component = apl.createModal("mdl_component",
            {
                service_device_id: 0,
                ac_device: apl.create_auto_complete_text("mdl_component_device", activities.ac_part),
                tb_cost: apl.createNumeric("mdl_component_cost", true),
                tb_total: apl.createNumeric("mdl_component_total"),
                val_device: apl.createValidator("mdl_component_save", "mdl_component_device", function () { return apl.func.emptyValueCheck(mdl_component.ac_device.input.value) }, "Salah input"),
                val_cost: apl.createValidator("mdl_component_save", "mdl_component_cost", function () { return apl.func.emptyValueCheck(mdl_component.tb_cost.value) }, "Salah input"),
                val_total: apl.createValidator("mdl_component_save", "mdl_component_total", function () { return apl.func.emptyValueCheck(mdl_component.tb_total.value) }, "Salah input"),

                kosongkan: function () {
                    mdl_component.service_device_id = 0;
                    mdl_component.ac_device.set_value("", "");
                    mdl_component.tb_cost.value = "";
                    mdl_component.tb_total.value = "";
                    apl.func.validatorClear("mdl_component_save");
                },
                tambah: function (service_device_id) {
                    mdl_component.kosongkan();
                    mdl_component.service_device_id = service_device_id;
                    mdl_component.showAdd("Komponen - Tambah");
                },
                edit: function (service_device_id, device_id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl_component.kosongkan();
                    activities.tec_service_device_component_data(service_device_id, device_id,
                        function (data) {
                            mdl_component.service_device_id = service_device_id;
                            mdl_component.ac_device.set_value(data.device_id, data.device);
                            mdl_component.tb_cost.setValue(data.cost);
                            mdl_component.tb_total.setValue(data.total);
                            mdl_component.showEdit("Komponen - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    mdl_component.hide();
                    apl.func.hideSinkMessage();
                    mdl.tbl_component_load();
                },
                save: function () {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_service_device_component_save(mdl_component.service_device_id, mdl_component.ac_device.id, mdl_component.tb_cost.getIntValue(), mdl_component.tb_total.getIntValue(), mdl_component.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("mdl_component_save")) {
                    mdl_component.save();
                }
            },
            function () {
                if (apl.func.validatorCheck("mdl_component_save")) {
                    mdl_component.save();
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    activities.tec_service_device_component_delete(mdl_component.service_device_id, mdl_component.ac_device.id, mdl_component.refresh, apl.func.showError, "");
                }
            },
            //"frm_page",
            "main_panel",
            "mdl"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_edit = mdl.edit;
            document.get_device_register = function (id) {
                activities.tec_device_register_data(id,
                    function (data) {
                        mdl.device_register_id = id;
                        mdl.tb_sn.value = data.sn;
                        mdl.ac_device.set_value(data.device_id, data.device);
                    }, apl.func.showError, ""
                );
            }
            cari.dl_branch.setValue("<%= branch_id %>");
        });
    </script>
</asp:Content>

