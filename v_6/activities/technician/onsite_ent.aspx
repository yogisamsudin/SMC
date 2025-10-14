<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

<script runat="server">
    public string strAppDate, ListID;
    
    void Page_Load()
    {
        _test.App a = new _test.App(Request, Response);

        strAppDate =  a.ApplicationDate;

        ListID = "35";
        if (Request.QueryString["ListID"] != null)
        {
            ListID = Request.QueryString["ListID"].ToString();
        }
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
            <th>Customer</th>
            <td><input type="text" id="cari_customer" size="50" value="%"/></td>
        </tr>
        <tr>
            <th>No</th>
            <td><input type="text" id="cari_no" size="50" value="%"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fl"></iframe> 

    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Tgl.Aju</th>
                    <td><label id="mdl_reqdate"></label></td>
                </tr>
                <tr>
                    <th style="width:200px">No</th>
                    <td><label id="mdl_no"></label></td>
                </tr>
                <tr>
                    <th>Pengaju</th>
                    <td><label id="mdl_requester"></label></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_custname"></label></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><label id="mdl_an"></label></td>
                </tr>
                <tr>
                    <th>Alamat</th>
                    <td><textarea id="mdl_custaddress" disabled></textarea></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdl_note"></textarea></td>
                </tr>
                <tr>
                    <th>Garansi</th>
                    <td><select id="mdl_guarantee" disabled="disabled"></select></td>
                </tr>
                <tr>
                    <th style="width:200px">Tgl.Onsite</th>
                    <td><input type="text" id="mdl_onsitedate" size="10" disabled="disabled"/> sampai <input type="text" id="mdl_onsitedate2" size="10" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Teknisi</th>
                    <td><input type="text" id="mdl_technician" size="50" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">Work Order</th>
                    <td><table class="gridView" id="mdl_tbl">
                            <tr>
                                <th style="width:25px;"><div class="tambah" onclick="mdlodr.tambah()"></div></th>
                                <th>Unit</th>
                                <th>SN</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="display:none;">
                    <th>Selesai</th>
                    <td><input type="checkbox" id="mdl_donests"/></td>
                </tr>
                
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Cancel"/>
                <select id="mdl_cetak_type" style="float:right;">
                    <option value="">PDF</option>
                    <option value="3">Word</option>
                    <option value="2">Excel</option>
                </select>
                <input id="mdl_print" type="button" value="Print" onclick="mdl.print(document.getElementById('mdl_cetak_type').value);" style="float:right;"/>
            </div>
        </fieldset>
    </div>

    <div id="mdlsel" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Customer</th>
                    <td><input type="text" size="20" id="mdlsel_custname"/></td>
                </tr>
                <tr>
                    <th></th>
                    <td><div class="buttonCari" onclick="mdlsel.load();">Cari</div></td>
                </tr>
            </table>
            <iframe class="frameList" id="mdlsel_fl"></iframe>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>

    <div id="mdlodr">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Sts.Device</th>
                    <td><select id="mdlodr_stsdevice"></select></td>
                </tr>
                <tr>
                    <th>Tgl.Segel</th>
                    <td><input type="text" id="mdlodr_tglsegel" size="10"/></td>
                </tr>
                <tr>
                    <th>Tgl.Garansi</th>
                    <td><input type="text" id="mdlodr_tglgaransi" size="10"/></td>
                </tr>
                <tr>
                    <th>Unit</th>
                    <td><input type="text" id="mdlodr_unit"/></td>
                </tr>
                <tr>
                    <th>SN</th>
                    <td><input type="text" id="mdlodr_sn"/></td>
                </tr>
                <tr>
                    <th>Complaint</th>
                    <td><textarea id="mdlodr_complaint"></textarea></td>
                </tr>
                <tr>
                    <th>Note</th>
                    <td><textarea id="mdlodr_note"></textarea></td>
                </tr>
                <tr>
                    <th>Part Replacement</th>
                    <td>
                        <table class="gridView" id="mdlodr_tbl">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdlpart.tambah();"></div></th>
                                <th>Part</th>
                                <th>Total</th>
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

    <div id="mdlpart">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Part</th>
                    <td><input type="text" id="mdlpart_part"/></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td><input type="text" id="mdlpart_total" style="text-align:right;"/></td>
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
            tb_customer: apl.func.get("cari_customer"),
            tb_no: apl.func.get("cari_no"),
            fl: apl.func.get("cari_fl"),
            load: function () {
                var custname = escape(cari.tb_customer.value);
                var no = escape(cari.tb_no.value);
                var status = '3';
                cari.fl.src = "onsite_list.aspx?displayadd=1&custname=" + custname + "&no=" + no + "&status=" + status;

            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                onsite_id: 0,
                customer_id: 0,
                guarantee_sts:false,

                lb_no: apl.func.get("mdl_no"),
                lb_requester: apl.func.get("mdl_requester"),
                lb_custname: apl.func.get("mdl_custname"),
                lb_an: apl.func.get("mdl_an"),
                tb_custaddress:apl.func.get("mdl_custaddress"),
                lb_reqdate: apl.func.get("mdl_reqdate"),
                tb_note: apl.func.get("mdl_note"),
                dl_guarantee: apl.createDropdownWS("mdl_guarantee", activities.dl_onsiteguarantee),
                tb_onsitedate: apl.createCalender("mdl_onsitedate"),
                tb_onsitedate2: apl.createCalender("mdl_onsitedate2"),
                tb_technician: apl.func.get("mdl_technician"),
                cb_done: apl.func.get("mdl_donests"),
                tb_print: apl.func.get("mdl_print"),
                dl_print:apl.func.get("mdl_cetak_type"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) {mdlodr.edit(data.workorder_id);}, undefined, undefined),
                        apl.createTableWS.column("device"),
                        apl.createTableWS.column("sn"),
                    ]
                ),
                tbl_load: function () {
                    activities.tec_onsite_wordorders_list(mdl.onsite_id, function (arr) { mdl.tbl.load(arr); }, apl.func.showError, "");
                },

                val1: apl.createValidator("save", "mdl_onsitedate", function () { return apl.func.emptyValueCheck(mdl.tb_onsitedate.value); }, "Invalid input"),
                val2: apl.createValidator("save", "mdl_technician", function () { return apl.func.emptyValueCheck(mdl.tb_technician.value); }, "Invalid input"),

                init:function()
                {
                    mdl.onsite_id = 0;
                    mdl.customer_id = 0;
                    mdl.guarantee_sts = false;
                    mdl.lb_no.innerHTML = "";
                    mdl.lb_requester.innerHTML = "";
                    mdl.lb_reqdate.innerHTML = "";
                    mdl.lb_custname.innerHTML = "";
                    mdl.tb_custaddress.value = "";
                    mdl.tb_note.vlaue = "";
                    mdl.dl_guarantee.value = "";
                    mdl.tb_onsitedate.value = "<%= strAppDate%>";
                    mdl.tb_onsitedate2.value = "<%= strAppDate%>";
                    mdl.tb_technician.value = "";
                    mdl.cb_done.checked = false;
                    mdl.tb_print.Hide();
                    mdl.dl_print.Hide();
                },
                tambah:function()
                {
                    mdl.init();
                    mdl.showAdd("Tambah Data");
                },
                edit:function(id, addsts)
                {
                    mdl.init();
                    mdl.onsite_id = id;
                    mdl.tbl_load();
                    activities.tec_onsite_data(id,
                        function (data) {
                            mdl.lb_no.innerHTML = data.onsite_no;
                            mdl.lb_requester.innerHTML = data.marketing_id;
                            mdl.lb_reqdate.innerHTML = data.request_date;
                            mdl.lb_custname.innerHTML = data.customer_name;
                            mdl.lb_an.innerHTML = data.contact_name;
                            mdl.tb_custaddress.value = data.customer_address + " " + data.customer_address_location;
                            mdl.tb_note.value = data.note;
                            mdl.dl_guarantee.value = data.guarantee_onsite_id;
                            mdl.guarantee_sts = data.guarantee_sts;
                            
                            mdl.tb_technician.value = data.technician_name;
                            mdl.showEdit("Edit Data");

                            if (addsts) mdl.tbl.Hide();
                            else {
                                mdl.tb_onsitedate.value = data.onsite_date;
                                mdl.tb_onsitedate2.value = data.onsite_date2;
                                mdl.tbl.Show();
                                mdl.tb_print.Show();
                                mdl.dl_print.Show();
                            }
                        },
                        apl.func.showError, ""
                    );
                    
                },
                print: function (file_type) {
                    if (mdl.sales_id != 0) {
                        var fName = mdl.lb_custname.innerHTML + "_" + mdl.lb_no.innerHTML;
                        fName = window.escape(fName.replace(/ /g, "_"));
                        window.location = "../../report/report_generator.ashx?ListID=<%= ListID %>&onsite_id=" + mdl.onsite_id + "&pdfName=" + fName + "&fileType=" + file_type;
                    }
                }
            },
            undefined, 
            function () {
                if(apl.func.validatorCheck("save"))
                {
                    activities.tec_onsite_edit2(mdl.onsite_id, mdl.tb_note.value, mdl.tb_onsitedate.value, mdl.tb_onsitedate.value, mdl.tb_technician.value, mdl.cb_done.checked,
                        function () {
                            mdl.hide();
                            cari.fl_refresh();
                        },
                        apl.func.showError, ""
                    );
                }
            }, undefined,
            "frm_page", "cover_content"
        );

        var mdlsel = apl.createModal("mdlsel",
            {
                tb_custname: apl.func.get("mdlsel_custname"),
                fl: apl.func.get("mdlsel_fl"),

                open:function()
                {
                    mdlsel.fl.src = "";
                    mdlsel.showEdit("Pilih Pengajuan");
                },
                select:function(id)
                {
                    mdlsel.hide();
                    mdl.edit(id, true);
                },
                load:function()
                {
                    var custname = escape(mdlsel.tb_custname.value);
                    mdlsel.fl.src = "../marketing/onsiteaju_list.aspx?displayadd=1&edit=select&status=2&marketing=%&custname=" + custname;
                }
            },
            undefined, undefined, undefined, "frm_page", "cover_content"
        );

        var mdlodr = apl.createModal("mdlodr",
            {
                workorder_id: 0,

                dl_stsdevice: apl.createDropdownWS("mdlodr_stsdevice", activities.dl_onsitedevicests),
                tb_tglsegel: apl.createCalender("mdlodr_tglsegel"),
                tb_tglgaransi: apl.createCalender("mdlodr_tglgaransi"),
                ac_unit: apl.create_auto_complete_text("mdlodr_unit", activities.ac_device_all, undefined, undefined, undefined, function () { return " part_sts = 0 and "; }),
                tb_sn: apl.func.get("mdlodr_sn"),
                tb_complaint: apl.func.get("mdlodr_complaint"),
                tb_note: apl.func.get("mdlodr_note"),
                tbl: apl.createTableWS.init("mdlodr_tbl",
                    [
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdlpart.edit(data.part_id); }, undefined, undefined),
                        apl.createTableWS.column("part"),
                        apl.createTableWS.column("total"),
                    ]
                ),
                tbl_load: function () {
                    activities.tec_onsite_workorders_parts_list(mdlodr.workorder_id, function (arr) { mdlodr.tbl.load(arr);}, apl.func.showError, "");
                },

                val1: apl.createValidator("odrsave", "mdlodr_unit", function () { return apl.func.emptyValueCheck(mdlodr.ac_unit.text); }),
                val2: apl.createValidator("odrsave", "mdlodr_sn", function () { return apl.func.emptyValueCheck(mdlodr.tb_sn.value); }),
                val3: apl.createValidator("odrsave", "mdlodr_complaint", function () { return apl.func.emptyValueCheck(mdlodr.tb_complaint.value); }),
                val4: apl.createValidator("odrsave", "mdlodr_note", function () { return apl.func.emptyValueCheck(mdlodr.tb_note.value); }),
                val5: apl.createValidator("odrsave", "mdlodr_stsdevice", function () { return apl.func.emptyValueCheck(mdlodr.dl_stsdevice.value); }),
                val6: apl.createValidator("odrsave", "mdlodr_tglsegel", function () { return apl.func.emptyValueCheck(mdlodr.tb_tglsegel.value); }),
                val7: apl.createValidator("odrsave", "mdlodr_tglgaransi", function () { return apl.func.emptyValueCheck(mdlodr.tb_tglgaransi.value) && mdl.guarantee_sts; }),

                init:function()
                {
                    mdlodr.workorder_id = 0;
                    mdlodr.ac_unit.set_value("", "");
                    mdlodr.tb_sn.value = "";
                    mdlodr.tb_complaint.value = "";
                    mdlodr.tb_note.value = "";
                    mdlodr.dl_stsdevice.value = "";
                    mdlodr.tb_tglsegel.value = "";
                    mdlodr.tb_tglgaransi.value = "";

                    mdlodr.tbl.Show();
                    if (mdl.guarantee_sts) mdlodr.tb_tglgaransi.Show(); else mdlodr.tb_tglgaransi.Hide();

                    apl.func.validatorClear("odrsave");
                },
                tambah: function () {
                    mdlodr.init();
                    mdlodr.tbl.Hide();
                    mdlodr.showAdd("Tambah Data");
                },
                edit:function(id)
                {
                    mdlodr.init();
                    mdlodr.workorder_id = id;
                    mdlodr.tbl_load();
                    activities.tec_onsite_wordorders_data(id,
                        function (data) {
                            mdlodr.ac_unit.set_value(data.device_id, data.device);
                            mdlodr.tb_sn.value = data.sn;
                            mdlodr.tb_complaint.value = data.complient_note;
                            mdlodr.tb_note.value = data.note;
                            mdlodr.dl_stsdevice.value = data.onsitedevicests_id;
                            mdlodr.tb_tglsegel.value = data.segeldate;
                            mdlodr.tb_tglgaransi.value = data.guarantee_date;
                            mdlodr.showEdit("Edit Data");
                        },
                        apl.func.showError, ""
                    );
                    
                },
                refresh:function()
                {
                    mdlodr.hide();
                    mdl.tbl_load();
                }
            },
            function () {
                if (apl.func.validatorCheck("odrsave"))
                {
                    activities.tec_onsite_workorders_add(mdl.onsite_id, mdlodr.ac_unit.id, mdlodr.tb_sn.value, mdlodr.tb_note.value, mdlodr.tb_complaint.value, mdlodr.dl_stsdevice.value, mdlodr.tb_tglsegel.value, mdlodr.tb_tglgaransi.value, mdlodr.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("odrsave")) {
                    activities.tec_onsite_workorders_edit(mdlodr.workorder_id, mdlodr.ac_unit.id, mdlodr.tb_sn.value, mdlodr.tb_note.value, mdlodr.tb_complaint.value, mdlodr.dl_stsdevice.value, mdlodr.tb_tglsegel.value, mdlodr.tb_tglgaransi.value, mdlodr.refresh, apl.func.showError, "");
                }
            }, 
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    //activities.tec_onsite_workorders_delete(mdlodr.workorder_id,mdlodr.refresh,apl.func.showError, "");
                }
            }, "frm_page", "mdl"
        );

        var mdlpart = apl.createModal("mdlpart",
            {
                ac_part: apl.create_auto_complete_text("mdlpart_part", activities.ac_part),
                tb_total: apl.createNumeric("mdlpart_total"),

                val1: apl.createValidator("partsave", "mdlpart_part", function () { return apl.func.emptyValueCheck(mdlpart.ac_part.text); }, "Invalid input"),
                val2: apl.createValidator("partsave", "mdlpart_total", function () { return apl.func.emptyValueCheck(mdlpart.tb_total.value); }, "Invalid input"),

                init:function()
                {
                    mdlpart.ac_part.set_value("", "");
                    mdlpart.tb_total.value = "";

                    apl.func.validatorClear("partsave");
                },
                tambah:function()
                {
                    mdlpart.init();
                    mdlpart.showAdd("Tambah Data");
                },
                edit:function(id)
                {
                    mdlpart.init();
                    activities.tec_onsite_workorders_parts_data(mdlodr.workorder_id, id,
                        function (data) {
                            mdlpart.ac_part.set_value(data.part_id, data.part);
                            mdlpart.tb_total.setValue(data.total);
                            mdlpart.showEdit("Edit Data");
                        },
                        apl.func.showError, ""
                    );
                    
                },
                refresh: function ()
                {
                    mdlpart.hide();
                    mdlodr.tbl_load();
                }
            },
            function () {
                if(apl.func.validatorCheck("partsave"))
                {
                    activities.tec_onsite_workorders_parts_add(mdlodr.workorder_id, mdlpart.ac_part.id, mdlpart.tb_total.getIntValue(), mdlpart.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("partsave")) {
                    activities.tec_onsite_workorders_parts_edit(mdlodr.workorder_id, mdlpart.ac_part.id, mdlpart.tb_total.getIntValue(), mdlpart.refresh, apl.func.showError, "");
                }
            },
            function () {
                if(confirm("Yakin akan dihapus?"))
                {
                    activities.tec_onsite_workorders_parts_delete(mdlodr.workorder_id, mdlpart.ac_part.id, mdlpart.refresh, apl.func.showError, "");
                }
            },
            "frm_page", "mdlodr"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_edit = mdl.edit;
            document.list_add = mdlsel.open;
            document.select = mdlsel.select;
        });
    </script>
</asp:Content>

