<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">

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
            <th>Tipe Transaksi</th>
            <td><select id="cari_type"></select></td>
        </tr>
        <tr>
            <th>Vendor</th>
            <td><input type="text" id="cari_vendor"/></td>
        </tr>
        <tr>
            <th>SN</th>
            <td><input type="text" id="cari_sn"/></td>
        </tr>
        <tr>
            <th>Status</th>
            <td><input type="checkbox" id="cari_done"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe> 

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>#</th>
                    <td><label id="mdl_id"></label></td>
                </tr>
                <tr>
                    <th>Vendor</th>
                    <td><input type="text" id="mdl_vendor"/></td>
                </tr>
                <tr>
                    <th>Tipe Transaksi</th>
                    <td><select id="mdl_type"></select></td>
                </tr>
                <tr>
                    <th>Tgl.Masuk</th>
                    <td><input type="text" size="10" id="mdl_datein"/></td>
                </tr>
                <tr>
                    <th>Tgl.Keluar</th>
                    <td><input type="text" size="10" id="mdl_dateout"/><span style="font-size:smaller">Kosongkan jika tidak mempunya masa kadaluarsa</span></td>
                </tr>
                <tr>
                    <th>Invoice No</th>
                    <td><input type="text" id="mdl_invoice" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><input type="checkbox" id="mdl_inventory_sts" /></td>
                </tr>
                <tr>
                    <th>Barang</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px"><div class="tambah" title="Tambahkan barang" onclick="mdl.add_device();"></div></th>
                                <th>SN</th>
                                <th>Device</th>
                            </tr>
                        </table>
                    </td>
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

    <div class="modal" id="mdl_device">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>SN</th>
                    <td><input type="text" id="mdl_device_sn"/></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><input type="text" id="mdl_device_device"/></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>                
                <input type="button" value="Delete"/>
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_service_device">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>SN</th>
                    <td><input type="text" id="mdl_service_device_sn"/></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><input type="text" id="mdl_service_device_device"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdl_service_device.load();">Cari</div></td>
                </tr>
            </table>
            <iframe class="frameList" id="mdl_service_device_iflist"></iframe>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            dl_type: apl.createDropdownWS("cari_type", activities.dl_inventory_type_list_all),
            tb_vendor: apl.func.get("cari_vendor"),
            tb_sn: apl.func.get("cari_sn"),
            cb_inventory_sts: apl.func.get("cari_done"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var type = escape(cari.dl_type.value);
                var name = escape(cari.tb_vendor.value);
                var sn= escape(cari.tb_sn.value);
                var done = cari.cb_inventory_sts.checked;
                cari.fl.src = "inventory_list.aspx?name=" + name + "&done=" + done + "&sn=" + sn+"&type="+type;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                inventory_id: 0,
                access_service_data_sts: false,
                lb_id: apl.func.get("mdl_id"),
                ac_vendor: apl.create_auto_complete_text("mdl_vendor", activities.ac_vendor, undefined, undefined,
                    function (d)
                    {
                        activities.opr_vendor_data(d.value,
                            function (data)
                            {
                                mdl.access_service_data_sts = data.access_service_data_sts;
                            },
                            apl.func.showError, ""
                        );
                    }
                ),
                dl_type: apl.createDropdownWS("mdl_type", activities.dl_inventory_type_list),
                tb_datein: apl.createCalender("mdl_datein"),
                tb_dateout: apl.createCalender("mdl_dateout"),
                tb_invoice: apl.func.get("mdl_invoice"),
                cb_inventory_sts:apl.func.get("mdl_inventory_sts"),
                val_vendor: apl.createValidator("save", "mdl_vendor", function () { return apl.func.emptyValueCheck(mdl.ac_vendor.input.value); }, "Salah input"),
                val_type: apl.createValidator("save", "mdl_type", function () { return apl.func.emptyValueCheck(mdl.dl_type.value); }, "Salah input"),
                val_datein: apl.createValidator("save", "mdl_datein", function () { return apl.func.emptyValueCheck(mdl.tb_datein.value); }, "Salah input"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_device.edit(data.inventory_device_id);}),
                        apl.createTableWS.column("sn"),
                        apl.createTableWS.column("device")
                    ]
                ),
                tbl_load: function () {
                    activities.tec_inventory_device_list(mdl.inventory_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                kosongkan:function()
                {
                    mdl.inventory_id = 0;
                    mdl.lb_id.innerHTML = "";
                    mdl.ac_vendor.set_value("", "");
                    //mdl.ac_vendor.disabled = false;
                    mdl.tb_datein.value = "";
                    mdl.tb_dateout.value = "";
                    mdl.dl_type.value = "";
                    mdl.tb_invoice.value = "";
                    mdl.cb_inventory_sts.checked = true;
                    mdl.access_service_data_sts = false;
                    mdl.tbl.clearAllRow();
                    apl.func.validatorClear("save");                    
                },
                tambah:function()
                {
                    mdl.kosongkan();                    
                    mdl.showAdd("Inventory - Tambah");
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    mdl.inventory_id = id;
                    mdl.lb_id.innerHTML = id;
                    mdl.tbl_load();
                    activities.tec_inventory_data(id,
                        function (data) {
                            mdl.ac_vendor.set_value(data.vendor_id, data.vendor_name);
                            mdl.dl_type.value = data.inventory_type_id;
                            mdl.tb_datein.value = data.inventory_in;
                            mdl.tb_dateout.value = data.inventory_out;
                            mdl.tb_invoice.value = data.invoice_no;
                            mdl.cb_inventory_sts.checked = data.inventory_sts;
                            mdl.access_service_data_sts = data.access_service_data_sts;
                            mdl.showEdit("Inventory - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    cari.fl_refresh();
                    mdl.hide();
                    apl.func.hideSinkMessage();
                },
                add_device:function()
                {
                    if (mdl.access_service_data_sts) mdl_service_device.tambah(mdl.inventory_id); else mdl_device.tambah(mdl.inventory_id);
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_inventory_add(mdl.tb_datein.value, mdl.tb_dateout.value, mdl.dl_type.value, mdl.ac_vendor.id, mdl.tb_invoice.value, mdl.cb_inventory_sts.checked,
                        function (id) {
                            cari.fl_refresh();
                            mdl.edit(id);                            
                        }, apl.func.showError, ""
                    );
                }
                    
            },
            function () {
                if (apl.func.validatorCheck("save")) activities.tec_inventory_edit(mdl.inventory_id, mdl.tb_datein.value, mdl.tb_dateout.value, mdl.dl_type.value, mdl.ac_vendor.id, mdl.tb_invoice.value, mdl.cb_inventory_sts.checked, mdl.refresh, apl.func.showError, "");                
            },
            function ()
            {
                if (confirm("Yakin akan dihapus?")) activities.tec_inventory_delete(mdl.inventory_id, mdl.refresh, apl.func.showError, "");                
            }, "frm_page", "cover_content"
        );

        var mdl_device = apl.createModal("mdl_device",
            {
                inventory_device_id: 0,
                inventory_id: 0,                
                tb_sn: (function () {
                    var _o = apl.createCharFiltering("mdl_device_sn");

                    _o.onkeyup = function () {
                        var kata = this.value;
                        this.value = kata.toUpperCase();
                    }
                    _o.onblur=function()
                    {
                        activities.tec_device_register_data_by_sn(_o.value,
                            function (data)
                            {
                                mdl_device.ac_device.set_value(data.device_id, data.device);
                            }, apl.func.showError, ""
                        );
                    }
                    return _o;
                })(),
                ac_device: apl.create_auto_complete_text("mdl_device_device", activities.ac_device_all),
                val_sn: apl.createValidator("device_save", "mdl_device_sn", function () { return apl.func.emptyValueCheck(mdl_device.tb_sn.value); }, "Salah input"),
                val_device: apl.createValidator("device_save", "mdl_device_device", function () { return apl.func.emptyValueCheck(mdl_device.ac_device.input.value); }, "Salah input"),
                kosongkan:function()
                {
                    mdl_device.inventory_device_id = 0;
                    mdl_device.inventory_id = 0;                    
                    mdl_device.tb_sn.value = "";
                    mdl_device.ac_device.set_value("", "");
                    mdl_device.tb_sn.disabled = false;
                    mdl_device.ac_device.input.disabled = false;
                    apl.func.validatorClear("device_save");
                },
                tambah:function(inventory_id)
                {
                    mdl_device.kosongkan();
                    mdl_device.inventory_id = inventory_id;
                    mdl_device.showAdd("Device - Tambah");
                },
                edit: function (inventory_device_id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl_device.kosongkan();
                    mdl_device.inventory_device_id = inventory_device_id;
                    activities.tec_inventory_device_data(inventory_device_id,
                        function (data)
                        {
                            mdl_device.inventory_id = data.inventory_id;
                            mdl_device.tb_sn.value = data.sn;
                            mdl_device.ac_device.set_value(data.device_id, data.device);
                            mdl_device.tb_sn.disabled = true;
                            mdl_device.ac_device.input.disabled = true;
                            mdl_device.showEdit("Device - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    mdl.tbl_load();
                    mdl_device.hide();
                    apl.func.hideSinkMessage();
                }
            }, 
            function ()
            {
                if (apl.func.validatorCheck("device_save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.tec_inventory_device_add(mdl_device.inventory_id, mdl_device.tb_sn.value, mdl_device.ac_device.id, 0, mdl_device.refresh, apl.func.showError, "");
                }
            },
            //function () {
            //    if (apl.func.validatorCheck("device_save")) {
            //        apl.func.showSinkMessage("Menyimpan");                    
            //        activities.tec_inventory_device_edit(mdl_device.inventory_device_id, mdl_device.tb_sn.value, mdl_device.ac_device.getValue(), 0, mdl_device.refresh, apl.func.showError, "");
            //    }
            //},
            undefined,
            function () {
                if (confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus");
                    activities.tec_inventory_device_delete(mdl_device.inventory_device_id,mdl_device.refresh, apl.func.showError, "");
                }
            }, "frm_page", "mdl"
        );

        var mdl_service_device = apl.createModal("mdl_service_device",
            {
                inventory_id: 0,
                tb_sn: apl.func.get("mdl_service_device_sn"),
                tb_device: apl.func.get("mdl_service_device_device"),
                iflist: apl.func.get("mdl_service_device_iflist"),
                tambah:function(inventory_id)
                {
                    mdl_service_device.inventory_id = inventory_id;
                    mdl_service_device.tb_sn.value = "";
                    mdl_service_device.tb_device.value = "";
                    mdl_service_device.iflist.src = "";
                    mdl_service_device.showAdd("Tambah - Device");
                },
                load:function()
                {
                    var sn = window.escape(mdl_service_device.tb_sn.value);
                    var device = window.escape(mdl_service_device.tb_device.value);
                    mdl_service_device.iflist.src = "inventory_service_list.aspx?sn=" + sn + "&device=" + device+"&edit=service_device_select";
                },
                select: function (service_device_id)
                {
                    activities.tec_inventory_device_add(mdl_service_device.inventory_id, "", 0, service_device_id,
                        function ()
                        {
                            mdl.tbl_load();
                            mdl_service_device.hide();
                        }, apl.func.showError, ""
                    );                    
                }
            },
            undefined,undefined,undefined,"frm_page","mdl"
        );

        window.addEventListener("load", function () {
            cari.dl_type.value = '%';
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
            document.service_device_select = mdl_service_device.select;
        });
    </script>
</asp:Content>

