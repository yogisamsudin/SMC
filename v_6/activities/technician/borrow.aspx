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
            <th>Status</th>
            <td><select id="cari_status"></select></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fl"></iframe> 

    <div id="mdl_borrow" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>ID</th>
                    <td><label id="mdl_borrow_id"></label></td>
                </tr>
                <tr>
                    <th>Schedule ID</th>
                    <td><label id="mdl_borrow_scheduleid"></label></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_borrow_service"></label></td>
                </tr>
                <tr>
                    <th>Note Peminjaman</th>
                    <td><textarea id="mdl_borrow_note" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Keperluan</th>
                    <td><label id="mdl_borrow_for"></label></td>
                </tr>
                <tr>
                    <th>Tgl.Berakhir</th>
                    <td><label id="mdl_borrow_enddate" title="dikosongkan artinya tidak ada batasan waktu pengembalian"/></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td>
                        <table class="gridView" id="mdl_borrow_tbl">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl.open();"></div></th>
                                <th>Device</th>
                                <th>SN</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><select id="mdl_borrow_status"></select></td>
                </tr>
                
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>
                <input type="button" value="Save"/>                
                <input type="button" value="Close"/>
                <input type="button" value="Cetak" style="float:right;" onclick="mdl_borrow.cetak()"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>SN</th>
                    <td><input type="text" id="mdl_sn" size="50"/></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><input type="text" id="mdl_device" size="100"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdl.fl_cari();">Cari</div></td>
                </tr>
            </table>
            <iframe class="frameList" id="mdl_fl"></iframe> 
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_id: apl.createNumeric("cari_id",false),
            tb_customer: apl.func.get("cari_customer"),
            tb_sn: apl.func.get("cari_sn"),
            dl_status: apl.createDropdownWS("cari_status", activities.dl_borrow_sts_all_list),
            fl: apl.func.get("cari_fl"),
            load: function () {
                var id= escape(cari.tb_id.value);
                var cust = escape(cari.tb_customer.value);
                var sn = escape(cari.tb_sn.value);                
                cari.fl.src = "borrow_list.aspx?cust=" + cust + "&sn=" + sn + "&sts=" + cari.dl_status.value + "&id=" + id;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl_borrow = apl.createModal("mdl_borrow",
            {
                borrow_id: 0,
                borrowed_for_id: '1',
                lb_id: apl.func.get("mdl_borrow_id"),
                lb_schedule:apl.func.get("mdl_borrow_scheduleid"),
                lb_service: apl.func.get("mdl_borrow_service"),
                lb_enddate: apl.func.get("mdl_borrow_enddate"),
                tb_note: apl.func.get("mdl_borrow_note"),
                lb_for: apl.func.get("mdl_borrow_for"),
                dl_status: apl.createDropdownWS("mdl_borrow_status", activities.dl_borrow_sts_list),
                val_for: apl.createValidator("borrow_save", "mdl_borrow_status", function () { return apl.func.emptyValueCheck(mdl_borrow.dl_status.value); }, "Kesalahan input"),
                tbl: apl.createTableWS.init("mdl_borrow_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "hapus")],
                            function (data) {
                                if (confirm("Yakin akan dihapus")) {
                                    apl.func.showSinkMessage("Menghapus");
                                    activities.exp_schedule_borrow_inventory_device_delete(data.borrow_id, data.inventory_device_id,
                                        function () {
                                            mdl_borrow.tbl_load();
                                            apl.func.hideSinkMessage();
                                        }, apl.func.showError, ""
                                    );
                                }
                            }
                        ),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("sn")                        
                    ]
                ),
                tbl_load: function () {
                    activities.exp_schedule_borrow_inventory_device_list(mdl_borrow.borrow_id,
                        function (arrData) {
                            mdl_borrow.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                kosongkan: function () {
                    mdl_borrow.lb_service.innerHTML = "";
                    mdl_borrow.lb_for.innerHTML = "";
                    mdl_borrow.lb_enddate.innerHTML = "";
                    mdl_borrow.tb_note.value = "";
                    mdl_borrow.dl_status.value = "";
                    apl.func.validatorClear("borrow_save")
                },
                edit: function (id) {
                    mdl_borrow.borrow_id = id;
                    mdl_borrow.kosongkan();
                    apl.func.showSinkMessage("Memuat");
                    mdl_borrow.tbl_load();
                    activities.exp_schedule_borrow_data(id,
                        function (data) {
                            mdl_borrow.lb_id.innerHTML = data.borrow_id;
                            mdl_borrow.lb_schedule.innerHTML = data.schedule_id;
                            mdl_borrow.lb_service.innerHTML = data.customer_name;
                            mdl_borrow.lb_for.innerHTML = data.borrowed_for;
                            mdl_borrow.borrowed_for_id = data.borrowed_for_id;
                            mdl_borrow.lb_enddate.innerHTML = data.borrow_end_date;
                            mdl_borrow.tb_note.value = data.borrow_note;
                            mdl_borrow.dl_status.value = data.borrow_sts_id;                            
                            mdl_borrow.showEdit("Peminjaman - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    cari.fl_refresh();
                    mdl_borrow.hide();
                    apl.func.hideSinkMessage();
                },
                select:function(inventory_device_id)
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_borrow_inventory_device_add(mdl_borrow.borrow_id, inventory_device_id,
                        function ()
                        {
                            mdl_borrow.tbl_load();
                            mdl.hide();
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                cetak:function()
                {
                    fName = "Pinjaman " + mdl_borrow.lb_for.innerHTML +" "+ mdl_borrow.lb_service.innerHTML;
                    fName = window.escape(fName.replace(/ /gi, "_"));
                    window.location = "../../report/report_generator.ashx?ListID=15&borrow_id=" + mdl_borrow.borrow_id + "&pdfName=" + fName;
                }
            },
            undefined,
            function () {
                if (apl.func.validatorCheck("borrow_save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_borrow_edit(mdl_borrow.borrow_id, mdl_borrow.lb_enddate.innerHTML, mdl_borrow.tb_note.value, mdl_borrow.borrowed_for_id, mdl_borrow.dl_status.value, mdl_borrow.refresh, apl.func.showError, "");
                }
            },
            undefined,
            "frm_page", "cover_content"
        );

        var mdl = apl.createModal("mdl",
            {
                tb_sn: apl.func.get("mdl_sn"),
                tb_device: apl.func.get("mdl_device"),
                fl: apl.func.get("mdl_fl"),
                fl_cari:function()
                {
                    var sn = escape(mdl.tb_sn.value);
                    var device = escape(mdl.tb_device.value);
                    mdl.fl.src = "borrow_inventory_list.aspx?sn=" + sn + "&device=" + device+"&edit=select";
                },
                open:function()
                {
                    if (mdl_borrow.dl_status.value != "4")
                    {
                        mdl.tb_sn.value = "";
                        mdl.tb_device.value = "";
                        mdl.fl_cari();
                        mdl.showAdd("Pilih")
                    } else {
                        alert("Barang sudah balik");
                    }
                }
            }, undefined, undefined, undefined, "frm_page", "mdl_borrow"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_edit = mdl_borrow.edit;
            document.select = mdl_borrow.select;
        });
    </script>
</asp:Content>

