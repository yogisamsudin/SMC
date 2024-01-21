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
            <th>ID</th>
            <td><input type="text" id="cari_id" size="50"/></td>
        </tr>
        <tr>
            <th>Customer</th>
            <td><input type="text" id="cari_customer" size="50"/></td>
        </tr>
        <tr>
            <th>SN</th>
            <td><input type="text" id="cari_sn" size="50"/></td>
        </tr>
        <tr>
            <th>Sts.dipinjam</th>
            <td><input type="checkbox" id="cari_status"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.fl.load();">Cari</div></td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_fl"></iframe> 

    <div class="modal" id="mdl_order">
        <fieldset>
            <legend></legend>
            <iframe class="frameList" id="mdl_order_fl"></iframe> 
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>        
    </div>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>#</th>
                    <td><span id="mdl_id"></span></td>
                </tr>
                <tr>
                    <th>Pelanggan</th>
                    <td><span id="mdl_customer"></span></td>
                </tr>
                <tr>
                    <th>Marketing</th>
                    <td><span id="mdl_marketing"></span></td>
                </tr>
                <tr>
                    <th>Marketing Note</th>
                    <td><textarea id="mdl_marketing_note" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Tgl.Pinjam</th>
                    <td><input type="text" id="mdl_date" size="10"/></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th>Tgl.Kembali</th>
                    <td><input type="text" id="mdl_returndate" size="10"/></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><input type="text" id="mdl_receiver"/></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Device</th>
                    <td>
                        <table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px;"><div class="tambah" onclick="mdl_inventory.open()"></div></th>
                                <th>SN</th>
                                <th>Device</th>                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
                <input type="button" value="Print" style="float:right;" onclick="mdl.cetak()"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_inventory">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Device</th>
                    <td><input type="text" id="mdl_inventory_device" size="50"/></td>
                </tr>
                <tr>
                    <th>SN</th>
                    <td><input type="text" id="mdl_inventory_sn" size="50"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdl_inventory.fl.load();">Cari</div></td>
                </tr>
            </table>
            <iframe class="frameList" id="mdl_inventory_fl"></iframe> 
            <div style="padding-top:5px;" class="button_panel">
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
                    <td><span id="mdl_device_sn"></span></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><span id="mdl_device_device"></span></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Kelengkapan</th>
                    <td>
                        <table class="gridView" id="mdl_device_tbl">
                            <tr>
                                <th style="width:25px;"></th>
                                <th>Kelengkapan</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Delete"/>
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_id: apl.createNumeric("cari_id", false),
            tb_customer: apl.func.get("cari_customer"),
            tb_sn: apl.func.get("cari_sn"),
            cb_status: apl.func.get("cari_status"),
            fl: (function () {
                var _o = apl.func.get("cari_fl");
                _o.load = function ()
                {
                    var id = cari.tb_id.getIntValue();
                    var cust = escape(cari.tb_customer.value);
                    var sn = escape(cari.tb_sn.value);
                    var sts = escape(cari.cb_status.checked);
                    this.src = "borrow_service_list.aspx?id=" + id + "&cust=" + cust + "&sn=" + sn + "&sts=" + sts;
                }
                _o.refresh = function ()
                {
                    this.contentWindow.document.refresh();
                }
                return _o;
            })()
        }

        var mdl_order = apl.createModal("mdl_order",
            {
                fl: (function () {
                    var _o = apl.func.get("mdl_order_fl");
                    _o.load = function ()
                    {
                        var id = cari.tb_id.getIntValue();
                        var cust = escape(cari.tb_customer.value);
                        var sn = escape(cari.tb_sn.value);
                        var sts = escape(cari.cb_status.checked);
                        this.src = "borrow_service_order_list.aspx?edit=service_order_select";
                    }
                    _o.refresh = function ()
                    {
                        this.contentWindow.document.refresh();
                    }
                    return _o;
                })(),
                tambah:function()
                {
                    mdl_order.showAdd("Pilih Customer");
                    mdl_order.fl.load();
                },
                select:function(id,date)
                {
                    activities.tec_borrow_service_add(date, id, function (id) {
                        mdl_order.hide();
                        mdl.edit(id);                        
                    }, apl.func.showError, "");                    
                }
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        var mdl = apl.createModal("mdl",
            {
                lb_id: apl.func.get("mdl_id"),
                lb_marketing: apl.func.get("mdl_marketing"),
                lb_customer: apl.func.get("mdl_customer"),
                tb_marketing_note: apl.func.get("mdl_marketing_note"),
                tb_date: apl.createCalender("mdl_date"),
                tb_retdate: apl.createCalender("mdl_returndate"),
                tb_note: apl.func.get("mdl_note"),
                tb_receiver: apl.func.get("mdl_receiver"),

                val_date: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Kesalahan input"),

                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_device.edit(data.inventory_device_id);},undefined,undefined),
                        apl.createTableWS.column("sn"),
                        apl.createTableWS.column("device")
                    ]
                ),
                tbl_load:function()
                {
                    activities.tec_borrow_service_device_list(mdl.lb_id.innerHTML, function (arr_data) { mdl.tbl.load(arr_data);}, apl.func.showError, "");
                },
                edit: function (id)
                {
                    apl.func.validatorClear("save");
                    activities.tec_borrow_service_data(id, function (data)
                    {
                        mdl.lb_id.innerHTML = data.borrow_service_id;
                        mdl.lb_marketing.innerHTML = data.marketing_id;
                        mdl.lb_customer.innerHTML = data.customer_name;
                        mdl.tb_marketing_note.value = data.marketing_note;
                        mdl.tb_date.value = data.borrow_date;
                        mdl.tb_retdate.value = data.return_date;
                        mdl.tb_note.value = data.note;
                        mdl.tb_receiver.value = data.receiver;
                        mdl.tbl_load();
                        mdl.showEdit("Peminjaman (Service) - Edit");
                        }, apl.func.showError, ""
                    );                    
                },
                refresh:function()
                {
                    apl.func.hideSinkMessage();
                    mdl.hide();
                    cari.fl.refresh();
                },
                cetak:function()
                {
                    var fName = mdl.lb_customer.innerHTML;
                    fName = window.escape(fName.replace(/ /g, "_"));
                    window.location = "../../report/report_generator.ashx?ListID=20&borrow_service_id=" + mdl.lb_id.innerHTML+ "&pdfName=" + fName;
                }

            }, undefined, 
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.tec_borrow_service_edit(mdl.lb_id.innerHTML, mdl.tb_date.value, mdl.tb_note.value, mdl.tb_retdate.value, mdl.tb_receiver.value, mdl.refresh, apl.func.showError,"");
                }
            }, 
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus...");
                    activities.tec_borrow_service_delete(mdl.lb_id.innerHTML, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        var mdl_inventory = apl.createModal("mdl_inventory",
            {
                tb_device: apl.func.get("mdl_inventory_device"),
                tb_sn: apl.func.get("mdl_inventory_sn"),
                fl: (function () {
                    var _o = apl.func.get("mdl_inventory_fl");
                    _o.load = function ()
                    {
                        var device = escape(mdl_inventory.tb_device.value);
                        var sn = escape(mdl_inventory.tb_sn.value);
                        this.src = "borrow_service_device_inventory_list.aspx?device=" + device + "&sn=" + sn + "&edit=select_device_inventory";
                    }
                    return _o;
                })(),
                open:function()
                {
                    mdl_inventory.tb_device.value = "";
                    mdl_inventory.tb_sn.value = "";
                    mdl_inventory.showAdd("Pilih Inventory");
                    mdl_inventory.fl.load();
                },
                closed:function()
                {
                    mdl_inventory.hide();
                    mdl.tbl_load();
                    apl.func.hideSinkMessage();
                },
                select:function(id)
                {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.tec_borrow_service_device_add(mdl.lb_id.innerHTML, id, mdl_inventory.closed, apl.func.showError, "");
                    mdl_inventory.hide();                    
                }                
            }, undefined, undefined, undefined, "frm_page", "mdl"
        );

        var mdl_device = apl.createModal("mdl_device",
            {
                inventory_device_id: 0,
                device_type_id:0,
                lb_device: apl.func.get("mdl_device_device"),
                lb_sn: apl.func.get("mdl_device_sn"),
                tbl: apl.createTableWS.init("mdl_device_tbl",
                    [
                        apl.createTableWS.column("status", undefined, [apl.createTableWS.attribute("type", "checkbox")], function (data) { mdl_device.save(data.trimming_id,this.checked); },undefined,"input","checked"),
                        apl.createTableWS.column("trimming_name")
                    ]
                ),
                tbl_load:function()
                {
                    activities.tec_borrow_service_device_trimming_list(mdl.lb_id.innerHTML, mdl_device.inventory_device_id, mdl_device.device_type_id,
                        function (arr_data) { mdl_device.tbl.load(arr_data);}, apl.func.showError, ""
                    );
                },
                edit:function(id)
                {
                    mdl_device.inventory_device_id = id;                    
                    activities.tec_borrow_service_device_data(mdl.lb_id.innerHTML,id,
                        function (data)
                        {
                            mdl_device.lb_device.innerHTML = data.device;
                            mdl_device.lb_sn.innerHTML = data.sn;
                            mdl_device.device_type_id = data.device_type_id;
                            mdl_device.showEdit("Edit Device");
                            mdl_device.tbl_load();
                        }, apl.func.showError, ""
                    );
                    
                },
                save:function(trimming_id, check)
                {
                    //alert(check);
                    activities.tec_borrow_service_device_trimming_save(mdl.lb_id.innerHTML, mdl_device.inventory_device_id, trimming_id, check, undefined, apl.func.showError, "");
                },
                refresh:function()
                {
                    apl.func.hideSinkMessage();
                    mdl_device.hide();
                    mdl.tbl_load();
                }
            },undefined, undefined, 
            function () {
                if (confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus...");
                    activities.tec_borrow_service_device_delete(mdl.lb_id.innerHTML, mdl_device.inventory_device_id, mdl_device.refresh, apl.func.showError, "");
                }
            }, "frm_page", "mdl"
        );

        window.addEventListener("load", function () {
            cari.fl.load();
            document.list_add = mdl_order.tambah;
            document.service_order_select = mdl_order.select;
            document.list_edit = mdl.edit;
            document.select_device_inventory = mdl_inventory.select;
        });
    </script>
</asp:Content>

