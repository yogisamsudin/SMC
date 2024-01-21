<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page" %>

<%--<%@ Register Src="~/activities/expedition/wuc_exp_service_inq.ascx" TagPrefix="uc1" TagName="wuc_exp_service_inq" %>--%>
<%@ Register Src="~/activities/marketing/wuc_sales_inq.ascx" TagPrefix="uc1" TagName="wuc_sales_inq" %>
<%@ Register Src="~/activities/expedition/wuc_service_device_register.ascx" TagPrefix="uc1" TagName="wuc_service_device_register" %>
<%@ Register Src="~/activities/marketing/wuc_service_inq.ascx" TagPrefix="uc1" TagName="wuc_service_inq" %>



<script runat="server">
    public _test.App a;
    public string branch_id, disabled_sts;
    
    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts = (a.BranchID == "") ? "" : "disabled";
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>    
    <style>
        .info
        {
            display:inline;
            position:absolute;
        }
        
        .info div
        {
            transition: all 1s Ease;
            visibility:hidden;
            opacity:0;
            position:relative;
        }
        .info:hover div
        {
            opacity:1;
            visibility:visible;
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
            <th style="width:100px;">Filter</th>
            <td>
                <select onclick="cari.select(this);" id="cari_select">
                    <option value="1">Tanggal</option>
                    <option value="2">Nomor</option>
                </select>
            </td>
        </tr>    
        <tr id="cari_view0">
            <th>Cabang</th>
            <td><select id="cari_branch" <%= disabled_sts %>></select></td>
        </tr>
        <tr id="cari_view1">
            <th style="width:100px;">Tanggal</th>
            <td>
                <input type="text" id="cari_date_list" size="10" maxlength="10" style="" value="<%= a.cookieApplicationDateValue %>"/>
                <div class="info" title="Jadwal belum terkirim" onclick="cari.tbl_load();">
                    <div style="width:150px;">
                        <br />
                        <table id="cari_tbl" class="gridView" style="width:100%;box-shadow: 0px 3px 3px 0px #7D7D7D;">
                            <tr>
                                <th style="width:25px;"></th>
                                <th>Tanggal</th>
                            </tr>
                        </table>                        
                    </div>
                </div>
            </td> 
        </tr>
        <tr id="cari_view2">
            <th>Selesai</th>
            <td><input type="checkbox" id="cari_done"/></td>
        </tr>
        <tr id="cari_view3">
            <th>Nomor</th>
            <td><input type="text" id="cari_number" value=""/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
        <tr style="visibility:hidden;">
            <th></th>
            <td><div class="tambah" onclick="mdl_unschedule.tambah()"></div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="fr_list"></iframe> 

    <uc1:wuc_service_inq runat="server" ID="mdl_service_inq" cover_id="mdl" parent_id="frm_page" />
    <%--<uc1:wuc_exp_service_inq runat="server" ID="exp_service_inq" parent_id="frm_page" cover_id="mdl" />--%>
    <uc1:wuc_sales_inq runat="server" ID="mdl_sales_inq" parent_id="frm_page" cover_id="mdl"/>
    <uc1:wuc_service_device_register runat="server" ID="mdl_service_device_register" parent_id="frm_page" cover_id="mdl_register" function_parent_refresh="document.tbl_service_load();"/>

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            
            <table class="formview" style="width:100%;">
                <tr>
                    <th>No</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th style="width:100px">Tanggal</th>
                    <td><input id="mdl_date" size="10" /></td>
                </tr>
                <tr>
                    <th>Alamat #1</th>
                    <td><textarea id="mdl_location" disabled="disabled"></textarea></td>
                </tr>
                <tr>
                    <th>Jarak</th>
                    <td><label id="mdl_distance"></label></td>
                </tr>
                <tr>
                    <th>Servis</th>
                    <td>
                        <table id="mdl_tbl_service" class="gridView" >
                            <tr>
                                <th style="width:25px;text-align:center;"><div class="tambah" title="tambah service" onclick="mdl.tambah_service()"></div></th>
                                <th style="width:25px;text-align:center;"></th>
                                <th>Kode Print</th>
                                <th>Tipe</th>
                                <th>Customer</th>
                                <th>Alamat #2</th>
                                <th>Backup</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Penjualan</th>
                    <td>
                        <table id="mdl_tbl_sales" class="gridView">
                            <tr>
                                <th style="width:25px"><div class="tambah" title="tambah sales" onclick="mdl.tambah_sales()"></div></th>
                                <th style="width:25px"></th>
                                <th>Kode Print</th>
                                <th>Customer</th>
                                <th>Alamat #2</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th>Peminjaman</th>
                    <td>
                        <table id="mdl_tbl_borrow" class="gridView">
                            <tr>
                                <th style="width:25px"><div class="tambah" title="tambah service" onclick="mdl.tambah_borrow();"></div></th>
                                <th>Customer</th>
                                <th>Tgl.Kembali</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--<tr>
                    <th>Vendor</th>
                    <td>
                        <table id="mdl_tbl_vendor" class="gridView" style="width:100%;">
                            <tr>
                                <th style="width:25px"><div class="tambah" title="tambah service" onclick="mdl.tambah_vendor()"></div></th>
                                <th>Vendor</th>
                                <th>Alamat #2</th>
                            </tr>
                        </table>
                    </td>
                </tr>--%>
                <%--<tr>
                    <th>Lainnya</th>
                    <td>
                        <table id="mdl_tbl_other" class="gridView" style="width:100%;">
                            <tr>
                                <th style="width:25px"><div class="tambah" title="tambah service" onclick="mdl.tambah_other()"></div></th>                                
                                <th>Keterangan</th>
                                <th>Alamat #2</th>
                            </tr>
                        </table>
                    </td>
                </tr>--%>
                <tr>
                    <th>Kurir</th>
                    <td><select id="mdl_messanger"></select></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><input type="text" id="mdl_contact" size="15" maxlength="15"/></td>
                </tr>
                <tr>
                    <th>Dibatalkan</th>
                    <td><input type="checkbox" id="mdl_canceled"/></td>
                </tr>
                <tr>
                    <th>Dibackup</th>
                    <td><input type="checkbox" id="mdl_backup"/></td>
                </tr>
                <tr>
                    <th>Selesai</th>
                    <td><input type="checkbox" id="mdl_done"/></td>
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

    <div id="mdl_service" class="modal">
        <fieldset>
            <legend></legend>
            <iframe class="frameList" id="mdl_service_fr"></iframe> 

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_sales" class="modal">
        <fieldset>
            <legend></legend>
            <iframe class="frameList" id="mdl_sales_fr"></iframe> 

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_register">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Daftar SN</th>
                    <td>
                        <table id="mdl_tbl_register" class="gridView">
                            <tr>
                                <th style="width:25px;"><div class="tambah" title="Tambah register service" onclick="mdl_register.tambah_sn()"></div></th>
                                <th>SN</th>
                                <th>Device</th>
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

    <div id="mdl_unschedule" class="modal">
        <fieldset>
            <legend></legend>
            <iframe id="mdl_unschedule_if" class="frameList"></iframe>
            <div class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_borrow" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>ID</th>
                    <td><label id="mdl_borrow_id"></label></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><select id="mdl_borrow_service"></select></td>
                </tr>
                <tr>
                    <th>Note Peminjaman</th>
                    <td><textarea id="mdl_borrow_note"></textarea></td>
                </tr>
                <tr>
                    <th>Keperluan</th>
                    <td><select id="mdl_borrow_for"></select></td>
                </tr>
                <tr>
                    <th>Tgl.Berakhir</th>
                    <td><input type="text" id="mdl_borrow_enddate" size="10" title="dikosongkan artinya tidak ada batasan waktu pengembalian"/></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><label id="mdl_borrow_status"></label></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td>
                        <table class="gridView" id="mdl_borrow_tbl">
                            <tr>
                                <th>Device</th>
                                <th>SN</th>
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">       
        
        var cari = {
            //dl_date: apl.createDropdownWS("cari_date_list", activities.dl_schedule_undone_by_date_list, undefined, undefined, false),
            //dl_date: apl.createCalender("cari_date_list"),
            dl_date: apl.create_calender("cari_date_list"),
            ddl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            fl: apl.func.get("fr_list"),
            cb_done: apl.func.get("cari_done"),
            tb_number: apl.createNumeric("cari_number",false),
            dl_select: apl.func.get("cari_select"),
            v0: apl.func.get("cari_view0"),
            v1: apl.func.get("cari_view1"),
            v2: apl.func.get("cari_view2"),
            v3: apl.func.get("cari_view3"),
            select: function (o)
            {
                var nilai="1";
                if (o)
                {
                    nilai = o.value;
                }
                                
                switch(nilai)
                {
                    case "1":
                        cari.v0.Show();
                        cari.v1.Show();
                        cari.v2.Show();
                        cari.v3.Hide();
                        break;
                    case "2":
                        cari.v0.Hide();
                        cari.v1.Hide();
                        cari.v2.Hide();
                        cari.v3.Show();
                        break;
                }

            },
            tbl: apl.createTableWS.init("cari_tbl",
                [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "select")], function (data) { cari.set_date(data.text); }, undefined, undefined),
                    apl.createTableWS.column("text")
                ]
            ),
            tbl_load:function()
            {
                cari.tbl.clearAllRow();
                activities.dl_schedule_undone_by_date_list(cari.ddl_branch.value,
                    function (arrData) {
                        cari.tbl.load(arrData);
                    }, apl.func.showError, ""
                );
            },
            load: function () {
                var tanggal = cari.dl_date.value;
                var done = (cari.cb_done.checked) ? "true" : "false";
                var schedule_id = cari.tb_number.getIntValue();
                cari.fl.src = "scheduling_list.aspx?date=" + escape(tanggal) + "&done=" + done + "&schedule_id=" + schedule_id + "&type=" + cari.dl_select.value + "&branch=" + cari.ddl_branch.value;
            },
            fl_refresh: function () {
                var last_date = cari.dl_date.value;
                //cari.dl_date.load(last_date);
                cari.tbl_load();
                //cari.fl.contentWindow.location.reload(true);
                cari.fl.contentWindow.document.refresh();
            },
            set_date:function(date)
            {
                cari.dl_date.value = date;
                cari.cb_done.checked = false;
                cari.load();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                schedule_id: 0,
                location_id: 0,
                sts_userdevicemandatory : false,
                lb_no: apl.func.get("mdl_no"),
                tb_date: apl.createCalender("mdl_date"),
                tb_location: apl.func.get("mdl_location"),
                lb_distance: apl.func.get("mdl_distance"),
                cb_canceled: apl.func.get("mdl_canceled"),
                cb_backup: apl.func.get("mdl_backup"),
                tb_contact:apl.func.get("mdl_contact"),
                cb_done: apl.func.get("mdl_done"),
                dl_messanger: apl.createDropdownWS("mdl_messanger", activities.dl_messanger, undefined, undefined, true),
                tbl_service: apl.createTableWS.init("mdl_tbl_service",
                    [
                        apl.createTableWS.column("", undefined, [apl.func.createAttribute("class", "info"), apl.func.createAttribute("title", "Marketing Info")],
                            function (data)
                            {
                                //document.exp_service_inq.edit(data.service_id);
                                mdl_service_inq.edit(data.service_id);
                            }
                            //,undefined, undefined, undefined,
                            //function (elm, data)
                            //{
                            //    alert(elm);
                            //    if (data.expedition_type_id=="1") elm.style.visibility = "hidden";
                            //}
                        ),
                        apl.createTableWS.column("", undefined, [apl.func.createAttribute("class", "cetak")],
                            function (data) {
                                var fName;
                                
                                
                                if (data.expedition_type_id == '2')
                                {
                                    fName = "surat_tanda_terima_service_" + data.customer_name;
                                    fName = window.escape(fName.replace(/ /gi, "_"));
                                    window.location = "../../report/report_generator.ashx?ListID=1&service_id=" + data.service_id + "&pdfName=" + fName;
                                }
                                    
                                else
                                {
                                    fName = "surat_serah_service_" + data.customer_name;
                                    fName = window.escape(fName.replace(/ /gi, "_"));
                                    if (data.kode_print == 0) {                                        
                                        window.location = "../../report/report_generator.ashx?ListID=10&service_id=" + data.service_id + "&pdfName=" + fName;
                                    } else {
                                        window.location = "../../report/report_generator.ashx?ListID=3&invoice_service_id=" + data.kode_print + "&pdfName=" + fName;
                                    }
                                    
                                }
                                
                            }
                        ),
                        apl.createTableWS.column("kode_print"),
                        //apl.createTableWS.column("expedition_type"),
                        apl.createTableWS.column("expedition_type", undefined, undefined,//[apl.func.createAttribute("style", "font-weight:bold;cursor:pointer;")],
                            function (data)
                            {
                                if (data.expedition_type_id == "2")
                                {
                                    mdl_register.edit(data.schedule_id, data.service_id, data.schedule_date, data.customer_id);                                    
                                }
                            }, false, "a", "innerHTML",
                            function (e,d)
                            {
                                if (d.expedition_type_id == "2")
                                {
                                    e.title = "Input register servis";
                                    e.style.fontWeight = "bold";
                                    e.style.cursor = "pointer";
                                }                                
                            }
                        ),
                        apl.createTableWS.column("customer_name"),
                        apl.createTableWS.column("pickup_address"),
                        apl.createTableWS.column("backup_sts")
                    ]
                ),
                tbl_service_load: function () {
                    mdl.tbl_service.clearAllRow();                    
                    //activities.exp_schedule_service_list2(mdl.schedule_id,
                    activities.exp_schedule_service_list_group(mdl.schedule_id,
                        function (arrData) {
                            mdl.tbl_service.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbl_sales: apl.createTableWS.init("mdl_tbl_sales",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "info")],
                            function (data) {
                                mdl_sales_inq.edit(data.sales_id);
                            }
                        ),
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "cetak")],
                            function (data) {
                                fName = "surat_tanda_terima_sales_" + data.customer_name;
                                fName = window.escape(fName.replace(/ /gi, "_"));
                                window.location = "../../report/report_generator.ashx?ListID=7&invoice_sales_id=" + data.kode_print + "&pdfName=" + fName;
                            }
                        ),
                        apl.createTableWS.column("kode_print"),
                        apl.createTableWS.column("customer_name"),
                        apl.createTableWS.column("delivery_address")
                    ]
                ),
                tbl_sales_load: function () {
                    mdl.tbl_sales.clearAllRow();
                    activities.tec_schedule_sales_list(mdl.schedule_id,
                        function (arrData) {
                            mdl.tbl_sales.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                tbl_borrow: apl.createTableWS.init("mdl_tbl_borrow",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")],
                            function (data) {
                                mdl_borrow.edit(data.borrow_id);
                            }
                        ),
                        apl.createTableWS.column("customer_name"),
                        apl.createTableWS.column("borrow_end_date")
                    ]
                ),
                tbl_borrow_load: function () {
                    mdl.tbl_borrow.clearAllRow();
                    activities.exp_schedule_borrow_list(mdl.schedule_id,
                        function (arrData) {
                            mdl.tbl_borrow.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                //tbl_vendor: apl.func.get("mdl_tbl_vendor"),
                //tbl_other: apl.func.get("mdl_tbl_other"),
                val_date: apl.createValidator("save", "mdl_date", function () { return apl.func.emptyValueCheck(mdl.tb_date.value); }, "Salah input"),                
                kosongkan:function()
                {
                    mdl.schedule_id = 0;
                    mdl.location_id = 0;
                    mdl.lb_no.innerHTML = "";
                    mdl.lb_distance.innerHTML = "";
                    mdl.tb_date.value = "";
                    mdl.tb_location.value = "";
                    //mdl.dl_messanger.load();
                    mdl.cb_done.checked = false;
                    mdl.tb_contact.value = "";
                    mdl.cb_canceled.checked = false;
                    mdl.cb_backup.checked = false;
                    apl.func.validatorClear("save");
                },
                tambah:function()
                {
                    mdl.kosongkan();
                    mdl.tbl_service.Hide();
                    mdl.tb_location.Hide();
                    mdl.tbl_service.Hide();
                    mdl.tbl_sales.Hide();
                    mdl.tbl_borrow.Hide();
                    //mdl.tbl_vendor.Hide();
                    //mdl.tbl_other.Hide();
                    mdl.cb_done.Hide();
                    mdl.dl_messanger.Hide()
                    mdl.tb_date.value = "<%= a.cookieApplicationDateValue %>";
                    mdl.tb_contact.Hide();
                    mdl.cb_canceled.Hide();
                    mdl.cb_backup.Hide();
                    mdl.tbl_service.clearAllRow();

                    mdl.showAdd("Jadwal - Tambah");
                },
                edit:function(id)
                {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();                    
                    mdl.tbl_service.Show();
                    mdl.tb_location.Show();
                    mdl.tbl_service.Show();
                    mdl.tbl_sales.Show();
                    mdl.tbl_borrow.Show();
                    //mdl.tbl_vendor.Show();
                    //mdl.tbl_other.Show();
                    mdl.cb_done.Show();
                    mdl.dl_messanger.Show()
                    mdl.tb_contact.Show();
                    mdl.cb_canceled.Show();
                    mdl.cb_backup.Show();

                    activities.act_schedule_data(id,
                        function (data) {
                            mdl.lb_no.innerHTML = data.schedule_id;
                            mdl.schedule_id = data.schedule_id;
                            mdl.location_id = data.location_id;
                            mdl.lb_distance.innerHTML = data.distance;
                            mdl.cb_done.checked = data.done_sts;

                            mdl.tb_date.value = data.schedule_date;
                            mdl.tb_location.value = data.location_address;
                            //mdl.dl_messanger.value = data.messanger_id;
                            mdl.dl_messanger.setValue(data.messanger_id);
                            //alert(data.messanger_id);
                            mdl.tb_contact.value = data.contact_name;
                            mdl.cb_canceled.checked = data.canceled_sts;
                            mdl.cb_backup.checked = data.backup_approve_sts;

                            mdl.tbl_service_load();
                            mdl.tbl_sales_load();
                            mdl.tbl_borrow_load();

                            mdl.showEdit("Jadwal - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );                    
                },
                refresh:function()
                {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                tambah_service:function()
                {
                    mdl_service.open(mdl.location_id, mdl.select_service);
                },
                select_service:function(service_id)
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_service_add(mdl.schedule_id, service_id, mdl.location_id,
                        function () {
                            mdl_service.close();
                            apl.func.hideSinkMessage();

                            mdl.edit(mdl.schedule_id);
                        }, apl.func.showError, ""
                    );
                },
                tambah_sales:function()
                {
                    mdl_sales.open(mdl.location_id, mdl.select_sales);
                },
                select_sales:function(sales_id)
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_sales_add(mdl.schedule_id, sales_id, mdl.location_id,
                        function () {
                            mdl_sales.close();
                            apl.func.hideSinkMessage();

                            mdl.edit(mdl.schedule_id);
                        }, apl.func.showError, ""
                    );
                },
                tambah_vendor:function()
                {

                },
                tambah_other:function()
                {

                },
                tambah_borrow:function()
                {
                    mdl_borrow.tambah();
                }
                
            },
            function()
            {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_add(mdl.tb_date.value, mdl.location_id,
                        function (id) {
                            cari.fl_refresh();
                            mdl.edit(id);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            },
            function () {
                if(apl.func.validatorCheck("save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_edit(mdl.schedule_id, mdl.tb_date.value, mdl.cb_done.checked,mdl.dl_messanger.value,mdl.tb_contact.value,mdl.cb_canceled.checked,mdl.cb_backup.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus");
                    activities.exp_schedule_delete(mdl.schedule_id, mdl.refresh, apl.func.showError, "");
                }
            },
            "frm_page","cover_content"
        );

        var mdl_service = apl.createModal("mdl_service",
            {
                fl: apl.func.get("mdl_service_fr"),
                open: function (location_id, list_service_select) {
                    document.list_service_select = list_service_select;
                    mdl_service.fl.src = "exp_service_list.aspx?edit=list_service_select&location_id=" + location_id+"&branch=<%= branch_id %>";
                    mdl_service.showAdd("Daftar Servis");
                },
                close: function () {
                    mdl_service.fl.src = "";
                    mdl_service.hide();
                }
            },
            undefined, undefined, undefined, "frm_page", "mdl"
        );

        var mdl_sales = apl.createModal("mdl_sales",
            {
                fl: apl.func.get("mdl_sales_fr"),
                open: function (location_id, list_sales_select) {
                    document.list_sales_select = list_sales_select;
                    mdl_sales.fl.src = "exp_sales_list.aspx?select=list_sales_select&location_id=" + location_id+"&branch=<%= branch_id %>";
                    mdl_sales.showAdd("Daftar Sales");
                },
                close: function () {
                    mdl_sales.fl.src = "";
                    mdl_sales.hide();
                }
            },
            undefined, undefined, undefined, "frm_page", "mdl"
        );

        var mdl_register = apl.createModal("mdl_register",
            {
                schedule_id: 0,
                service_id: 0,
                schedule_date: "",
                tbl_service: apl.createTableWS.init("mdl_tbl_register",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_register.edit_sn(data.service_device_id); }, undefined, undefined),
                        apl.createTableWS.column("sn"),
                        apl.createTableWS.column("device")
                    ]
                ),
                tbl_service_load: function () {
                    mdl_register.tbl_service.clearAllRow();
                    activities.tec_service_device_list_by_service_id(mdl_register.service_id,
                        function (arrData) {
                            activities.act_customer_data(mdl_register.customer_id,
                                function (d)
                                {
                                    mdl.sts_userdevicemandatory = d.user_device_mandatory;
                                    mdl_register.tbl_service.load(arrData);
                                    //alert(mdl.sts_userdevicemandatory);
                                }, apl.func.showError, ""
                            );
                            
                        }, apl.func.showError, ""
                    );
                },
                edit: function (schedule_id, service_id, schedule_date,customer_id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl_register.schedule_id = schedule_id;
                    mdl_register.service_id = service_id;
                    mdl_register.schedule_date = schedule_date;
                    mdl_register.customer_id = customer_id;
                    
                    mdl_register.tbl_service_load();
                    mdl_register.showEdit("Register Servis - Edit");
                    apl.func.hideSinkMessage();
                },
                tambah_sn: function () {
                    mdl_service_device_register.tambah(mdl_register.service_id, mdl.tb_date.value, mdl.sts_userdevicemandatory);
                },
                edit_sn: function (id) {
                    mdl_service_device_register.edit(id,mdl.sts_userdevicemandatory);
                }
            }, undefined, undefined, undefined, "frm_page", "mdl"
        );

        var mdl_unschedule = apl.createModal("mdl_unschedule",
            {
                if_list: apl.func.get("mdl_unschedule_if"),
                tambah:function()
                {
                    mdl_unschedule.if_list.src = "exp_unschedule_list.aspx";
                    mdl_unschedule.showAdd("Daftar Belum Terjadwalkan- Tambah");
                }
            }, undefined, undefined, undefined, "frm_page", "cover_content"
        );

        var mdl_borrow = apl.createModal("mdl_borrow",
            {
                borrow_id: 0,
                dl_service: apl.createDropdownWS("mdl_borrow_service", activities.dl_schedule_service_list,"value", "text", false, function () { return mdl.schedule_id; }),
                tb_enddate: apl.createCalender("mdl_borrow_enddate"),
                tb_note: apl.func.get("mdl_borrow_note"),
                dl_for: apl.createDropdownWS("mdl_borrow_for", activities.dl_borrowed_for_list, "value", "text"),
                lb_status: apl.func.get("mdl_borrow_status"),
                lb_id: apl.func.get("mdl_borrow_id"),
                val_service: apl.createValidator("borrow_save", "mdl_borrow_service", function () { return apl.func.emptyValueCheck(mdl_borrow.dl_service.value); }, "Kesalahan input"),
                val_for: apl.createValidator("borrow_save", "mdl_borrow_for", function () { return apl.func.emptyValueCheck(mdl_borrow.dl_for.value); }, "Kesalahan input"),
                tbl: apl.createTableWS.init("mdl_borrow_tbl",
                    [
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("sn")
                    ]
                ),
                tbl_load: function () {
                    mdl_borrow.tbl.clearAllRow()
                    activities.exp_schedule_borrow_inventory_device_list(mdl_borrow.borrow_id,
                        function (arrData) {
                            mdl_borrow.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                kosongkan:function()
                {
                    mdl_borrow.dl_service.load("");
                    mdl_borrow.dl_service.disabled = false;
                    mdl_borrow.dl_for.value = "";
                    mdl_borrow.tb_enddate.value = "";
                    mdl_borrow.tb_note.value = "";
                    mdl_borrow.lb_status.innerHTML = "";
                    mdl_borrow.lb_id.innerHTML = "";
                    mdl_borrow.tbl.Hide();
                    apl.func.validatorClear("borrow_save")
                },
                tambah:function()
                {
                    mdl_borrow.kosongkan();
                    mdl_borrow.showAdd("Peminjaman - Tambah");                    
                },
                edit:function(id)
                {
                    mdl_borrow.borrow_id = id;
                    mdl_borrow.kosongkan();
                    apl.func.showSinkMessage("Memuat");
                    mdl_borrow.tbl.Show();
                    mdl_borrow.tbl_load();
                    activities.exp_schedule_borrow_data(id,
                        function (data) {                            
                            mdl_borrow.dl_service.load(data.code);
                            mdl_borrow.dl_service.disabled = true;
                            mdl_borrow.tb_enddate.value = data.borrow_end_date;
                            mdl_borrow.tb_note.value = data.borrow_note;
                            mdl_borrow.dl_for.value = data.borrowed_for_id;
                            mdl_borrow.lb_status.innerHTML = data.borrow_sts;
                            mdl_borrow.lb_id.innerHTML = data.borrow_id;
                            mdl_borrow.showEdit("Peminjaman - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );                    
                },
                refresh:function()
                {
                    mdl.tbl_borrow_load();
                    mdl_borrow.hide();
                    apl.func.hideSinkMessage();
                }
            }, 
            function () {
                if(apl.func.validatorCheck("borrow_save"))
                {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_borrow_add(mdl_borrow.dl_service.value, mdl.schedule_id, mdl_borrow.tb_enddate.value, mdl_borrow.tb_note.value,mdl_borrow.dl_for.value, mdl_borrow.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("borrow_save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.exp_schedule_borrow_edit(mdl_borrow.borrow_id, mdl_borrow.tb_enddate.value, mdl_borrow.tb_note.value, mdl_borrow.dl_for.value,'1', mdl_borrow.refresh, apl.func.showError, "");
                }
            }, 
            function () {
                confirm("Yakin akan dihapus?")
                {
                    apl.func.showSinkMessage("Menghapus");
                    activities.exp_schedule_borrow_delete(mdl_borrow.borrow_id, mdl_borrow.refresh, apl.func.showError, "");
                }
            },
            "frm_page", "mdl"
        );

        window.addEventListener("load",
            function () {
                document.list_add = mdl.tambah;
                document.list_edit = mdl.edit;
                document.tbl_service_load = mdl_register.tbl_service_load;
                //cari.dl_date.load();
                                
                cari.tbl_load();
                //cari.load();
                cari.select(undefined);
                cari.ddl_branch.setValue("<%= branch_id %>");
            }
        );        
    </script>
</asp:Content>

