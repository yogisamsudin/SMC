<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

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
            <th>No</th>
            <td><input type="text" id="cari_no"/></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" size="50"/></td>
        </tr>
        <tr>
            <th>SN</th>
            <td><input type="text" id="cari_sn" size="50"/></td>
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

    <uc1:wuc_info_customer runat="server" ID="mdlinq_customer" parent_id="frm_page" cover_id="mdl"/> 
    <uc1:wuc_location_activity runat="server" ID="mdl_location" parent_id="frm_page" cover_id="mdl" selected_function="mdl.location_selected" />

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            
            <table class="formview">
                <tr>
                    <th>Tanggal</th>
                    <td><label id="mdl_date"></label></td>
                </tr>
                <tr>
                    <th>Nama Pelanggan</th>
                    <td>
                        <input type="text" id="mdl_customer" />
                         <div class="info" onclick="info()" style="float:left;"></div>
                        <!--<div id="mdl_customer" style="float:left;"> </div>&nbsp;<a onclick="info()" style="cursor:pointer;font-weight:bold;">Info</a>-->
                    </td>
                </tr>
                <tr>
                    <th>Cabang Pelanggan</th>
                    <td><input type="text" id="mdl_branch" size="50"  maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Atas Nama</th>
                    <td><select id="mdl_an"></select></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><select id="mdl_contact"></select></td>
                </tr>
                <tr>
                    <th>Alamat Kurir #1</th>
                    <td>
                        <input type="text" id="mdl_pickup_address"/>
                        <div style="float:left;" class="select" onclick="mdl.open_location()" title="Pilih alamat yang sudah ada"></div>
                        <!--
                        <textarea id="mdl_pickup_address" style="float:left" disabled="disabled"></textarea>
                        <div style="float:left;" class="select" onclick="mdl.open_location()"></div>
                        <div style="float:left;" class="tambah" onclick="mdl.add_location()"></div>
                        -->
                    </td>
                </tr>
                <tr>
                    <th>Alamat Kurir #2</th>
                    <td><input type="text" id="mdl_pickup_address2" size="100" maxlength="300"/></td>
                </tr>
                <tr>
                    <th>Catatan</th>
                    <td><textarea id="mdl_note" style="max-width:100%;width:600px;height:200px;font-family:'Courier New';"></textarea></td>
                </tr>
                <tr>
                    <th>Tgl.Kurir</th>
                    <td><input type="text" id="mdl_pickup_date" size="10" maxlength="10"/></td>
                </tr>
                <tr>
                    <th>Fee</th>
                    <td><input type="text" id="mdl_fee" style="text-align:right;"/></td>
                </tr>
                <tr>
                    <th>Status Backup</th>
                    <td><select id="mdl_backup"></select></td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color:gray;text-align:center;"><div class="refresh" style="float:left;" onclick="mdl.load_opr_data();"></div>Operation</th>
                </tr>
                <tr>
                    <th>No.Penawaran</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th>Broker</th>
                    <td><label id="mdl_broker"></label></td>
                </tr>
                <tr>
                    <th>Pajak</th>
                    <td><input type="checkbox" id="mdl_tax" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Nilai Invoice</th>
                    <td><input type="text" disabled="disabled" style="text-align:right;" size="20" id="mdl_total"/></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Device</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th style="width:25px"></th>
                                <th>SN</th>
                                <th>Device</th>
                                <th>Total Harga</th>                                
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea disabled="disabled" id="mdl_oprnote"></textarea></td>
                </tr>
                <tr>
                    <th>Respon</th>
                    <td><select id="mdl_marketing_status"></select></td>
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
            </table>                    

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>                
                <input type="button" value="Close"/>
                <span style="font-size:small;">Respon terkunci setelah melewati jam tutup transaksi</span>
                <input type="button" value="Print" style="float:right;" onclick="mdl.print_offer();"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_addlocation">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Lokasi</th>
                    <td><input type="text" id="mdl_addlocation_location" autocomplete="off" size="50"/></td>
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
                    <th>SN</th>
                    <td><label id="mdl_device_sn"></label></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><label id="mdl_device_device"></label></td>
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
                    <th style="vertical-align:top">Komponen</th>
                    <td>
                        <table id="mdl_device_tbl" class="gridView">
                            <tr>
                                <th>Komponent</th>
                                <th>Harga</th>
                                <th>Total #2</th>                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_no: apl.func.get("cari_no"),
            tb_sn: apl.func.get("cari_sn"),
            ddl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list,undefined,undefined),
            fl: apl.func.get("cari_fr"),
            tb_customer: apl.func.get("cari_customer"),
            load: function () {
                var no = escape(cari.tb_no.value);
                var user = "<%= user_id %>";
                var cust = escape(cari.tb_customer.value);
                var sn = escape(cari.tb_sn.value);
                var branch = escape(cari.ddl_branch.value);
                cari.fl.src = "service_confirm_list.aspx?no=" + no + "&user=" + user + "&cust=" + cust + "&sn=" + sn + "&branch=" + branch;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                service_id: 0,
                event_sts: false,
                group_customer_id: 0,
                pickup_address_location_id: 0,
                latitude: "",
                longitude: "",
                lb_date: apl.func.get("mdl_date"),
                dl_backup: apl.createDropdownWS("mdl_backup", activities.dl_backup_status_list),
                tb_branch:apl.func.get("mdl_branch"),
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
                ddl_reason:apl.createDropdownWS("mdl_reason",activities.dl_marketing_reason),

                dl_an: apl.createDropdownWS("mdl_an", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                dl_contact: apl.createDropdownWS("mdl_contact", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                //tb_pickup_address: apl.func.get("mdl_pickup_address"),
                tb_pickup_address: apl.create_auto_complete_text("mdl_pickup_address", activities.ac_location_list, function () { mdl_addlocation.tambah(); }, 600),

                tb_pickup_address2: apl.func.get("mdl_pickup_address2"),
                tb_note: apl.func.get("mdl_note"),
                tb_pickup_date: apl.createCalender("mdl_pickup_date"),
                tb_fee: apl.createNumeric("mdl_fee", true),

                ln_url: apl.func.get("mdl_url"),
                fl_fu: apl.create_selectfile("mdl_fu", function (e) {
                    mdl.event_sts = true;
                    apl.func.showSinkMessage("Simpan...");
                    apl.func.read_file_readAsArrayBuffer(mdl.fl_fu.get_file(),
                        function (filedata) {
                            activities.opr_service_document_save(mdl.service_id, mdl.fl_fu.get_info().name, filedata, mdl.fl_fu.get_info().type, function () { apl.func.hideSinkMessage(); mdl.event_sts = false; }, apl.func.showError, "");
                            mdl.event_sts = false;
                            alert("Save file sukses");
                        }
                    );
                }),
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

                val_customer: apl.createValidator("save", "mdl_customer", function () { return (mdl.ac_customer.id == "") ? true : false; }, "Salah input"),
                val_an: apl.createValidator("save", "mdl_an", function () { return apl.func.emptyValueCheck(mdl.dl_an.value); }, "Salah input"),
                val_contact: apl.createValidator("save", "mdl_contact", function () { return apl.func.emptyValueCheck(mdl.dl_contact.value); }, "Salah input"),                
                val_pickup_address: apl.createValidator("save", "mdl_pickup_address", function () { return apl.func.emptyValueCheck(mdl.tb_pickup_address.id); }, "Salah input"),
                val_delivery_date: apl.createValidator("save", "mdl_pickup_date", function () { return (mdl.tb_pickup_date.value == "") ? true : false; }, "Salah input"),
                val_fee: apl.createValidator("save", "mdl_fee", function () { return (mdl.tb_fee.value == "") ? true : false; }, "Salah input"),
                val_marketing_status: apl.createValidator("save", "mdl_marketing_status", function () { return apl.func.emptyValueCheck(mdl.dl_marketing_status.value); }, "Salah input"),
                val_marketing_reason: apl.createValidator("save", "mdl_reason", function () { return apl.func.emptyValueCheck(mdl.ddl_reason.value); }, "Salah input"),

                lb_no: apl.func.get("mdl_no"),
                lb_broker: apl.func.get("mdl_broker"),
                cb_tax: apl.func.get("mdl_tax"),
                tb_total: apl.createNumeric("mdl_total", true),
                tb_oprnote: apl.func.get("mdl_oprnote"),
                dl_marketing_status: apl.createDropdownWS("mdl_marketing_status", activities.dl_act_marketing_service_status_list),

                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_device.edit(data.service_id, data.service_device_id); }, undefined, undefined),
                        apl.createTableWS.column("sn"),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("total_price", undefined, undefined, undefined, true)                        
                    ]
                ),
                tbl_load: function (refresh_total_sts) {
                    activities.opr_service_device_list(mdl.service_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },

                get_customer_id: function (nilai)
                {
                    if(apl.func.emptyValueCheck(nilai)) 
                    {
                        return "1"
                    }else
                    {
                        return nilai;
                    }
                },
                kosongkan_ac: function ()
                {
                    mdl.dl_an.load("");
                    mdl.dl_contact.load("");
                },
                load_opr_data:function()
                {
                    activities.opr_service_data(mdl.service_id,
                        function (data) {
                            mdl.lb_no.innerHTML = data.offer_no;
                            mdl.lb_broker.innerHTML = data.broker_name;
                            mdl.cb_tax.checked = data.tax_sts;
                            mdl.tb_total.setValue(data.grand_price);
                            mdl.tb_oprnote.value = data.opr_note;
                            mdl.dl_marketing_status.value = data.service_status_marketing_id;
                            mdl.ddl_reason.value = data.reason_marketing_id;                            
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );

                    mdl.tbl_load();
                },
                edit:function(id)
                {
                    apl.func.validatorClear("save");
                    apl.func.showSinkMessage("Memuat Data");
                    activities.act_service_data(id,
                        function (data) {
                            mdl.group_customer_id = data.group_customer_id;
                            mdl.service_id = data.service_id;
                            mdl.pickup_address_location_id = data.pickup_address_location_id;
                            mdl.lb_date.innerHTML = data.service_call_date;
                            //mdl.ac_customer.setValue(data.customer_id, data.customer_name);
                            mdl.ac_customer.set_value(data.customer_id, data.customer_name);
                            mdl.dl_an.load(data.an_id);
                            mdl.dl_contact.load(data.contact_id);
                            //mdl.tb_pickup_address.value = data.pickup_address_location;
                            mdl.tb_pickup_address.set_value(data.pickup_address_location_id, data.pickup_address_location);
                            mdl.tb_pickup_address2.value = data.pickup_address;
                            mdl.tb_note.value = data.note;
                            mdl.tb_pickup_date.value = data.pickup_date;
                            mdl.tb_fee.setValue(data.fee);
                            mdl.dl_backup.value = data.backup_sts_id;
                            mdl.latitude = mdl.latitude;
                            mdl.longitude = mdl.longitude;
                            mdl.tb_branch.value = data.branch_customer;

                            mdl.load_opr_data();                            
                            mdl.showEdit("Servis - Edit");                            
                        }, apl.func.showError, ""
                    );

                    
                },
                refresh_modal:function()
                {
                    //mdl.hide();
                    apl.func.hideSinkMessage();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                add_pickup_address:function()
                {
                    document.mdl_location.open(2);
                },
                open_location:function()
                {
                    if (mdl.ac_customer.id != "") document.mdl_location.open(1,mdl.group_customer_id);
                },
                add_location: function () {                    
                    if (mdl.ac_customer.id != "") document.mdl_location.open(2);
                },
                location_selected:function(location_id, location_address, customer_address)
                {
                    mdl.pickup_address_location_id = location_id;
                    //mdl.tb_pickup_address.value = location_address;
                    mdl.tb_pickup_address.set_value(location_id, location_address);
                    mdl.tb_pickup_address2.value = customer_address;
                },
                print_offer: function () {
                    var fName = mdl.ac_customer.text+ "_" + mdl.lb_no.innerHTML;
                    fName = window.escape(fName.replace(/ /g, "_"));
                    window.location = "../../report/report_generator.ashx?ListID=2&service_id=" + mdl.service_id + "&pdfName=" + fName;
                }
            }, undefined, 
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.opr_service_edit_marketing(mdl.service_id, mdl.dl_marketing_status.value,mdl.ddl_reason.value, undefined, apl.func.showError, "");
                    activities.act_service_edit(mdl.service_id, mdl.ac_customer.id, mdl.dl_an.value, mdl.dl_contact.value, mdl.tb_pickup_address2.value, mdl.tb_note.value, mdl.tb_pickup_address.id, mdl.tb_pickup_date.value, mdl.tb_fee.getIntValue(), mdl.dl_backup.value,mdl.latitude,mdl.longitude,mdl.tb_branch.value, mdl.refresh_modal, apl.func.showError, "");
                }
            }, undefined, "frm_page", "cover_content"
        );

        var mdl_device = apl.createModal("mdl_device",
            {
                service_id: 0,
                service_device_id: 0,
                lb_sn: apl.func.get("mdl_device_sn"),
                lb_device: apl.func.get("mdl_device_device"),
                tb_customer_note: apl.func.get("mdl_device_customer_note"),
                tb_technician_note: apl.func.get("mdl_device_technician_note"),
                lb_user: apl.func.get("mdl_device_user"),
                tbl: apl.createTableWS.init("mdl_device_tbl",
                    [
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("price", undefined, undefined, undefined, true),
                        apl.createTableWS.column("total", undefined, undefined, undefined, true)
                    ]
                ),
                tbl_load: function () {
                    activities.xml_opr_service_device_component_list(mdl_device.service_id, mdl_device.service_device_id,
                        function (arrData) {
                            mdl_device.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                edit: function (service_id, service_device_id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl_device.service_id = service_id;
                    mdl_device.service_device_id = service_device_id;
                    mdl_device.tbl_load();
                    activities.opr_service_device_data(service_id, service_device_id,
                        function (data) {
                            mdl_device.lb_device.innerHTML = data.device;
                            mdl_device.lb_sn.innerHTML = data.sn;
                            mdl_device.lb_user.innerHTML = data.user_name;
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
                }
            }, undefined,
            undefined,
            undefined, "frm_page", "mdl"
        );

        info = function () {
            var id = mdl.ac_customer.id;
            if (id > 0) document.mdlinq_customer.info(id);
        }

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

        window.addEventListener("load", function ()
        {
            document.list_edit = mdl.edit;
            cari.load();
            cari.ddl_branch.setValue("<%= branch_id %>");
        });
    </script>
</asp:Content>

