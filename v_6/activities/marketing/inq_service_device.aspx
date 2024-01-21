<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

<%@ Register Src="~/activities/marketing/wuc_service_inq.ascx" TagPrefix="uc1" TagName="wuc_service_inq" %>


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
            <th>SN</th>
            <td><input type="text" id="cari_sn" size="50" maxlength="50"/></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td><input type="text" size="50" maxlength="50" id="cari_customer"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe> 

    <uc1:wuc_service_inq runat="server" ID="mdl_service_inq" parent_id="frm_page" cover_id="mdl"/>    

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th colspan="2" style="background-color:gray;color:white;text-align:center;">Info Ekspedisi</th>                    
                </tr>
                <tr>
                    <th>Jadwal</th>
                    <td>
                        <table class="gridView" id="mdl_tbl_schedule" style="width:100%">
                            <tr>
                                <th style="width:25px"></th>
                                <th>ID</th>
                                <th>Tanggal</th>
                                <th>Tipe</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color:gray;color:white;text-align:center;">Info Penawaran</th>                    
                </tr>
                <tr>
                    <th>No.Penawaran</th>
                    <td><label id="mdl_offer_no"></label></td>
                </tr>
                <tr>
                    <th>Status Penawaran</th>
                    <td><label id="mdl_service_status"></label></td>
                </tr>
                <tr>
                    <th>Status Konfirmasi</th>
                    <td><label id="mdl_service_status_marketing"></label></td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color:gray;color:white;text-align:center;">Info Invoice</th>                    
                </tr>
                <tr>
                    <th>No.Invoice</th>
                    <td><label id="mdl_invoice_no"></label></td>
                </tr>
                <tr>
                    <th>Status Penawaran</th>
                    <td><label id="mdl_invoice_date"></label></td>
                </tr>
                <tr>
                    <th colspan="2" style="background-color:gray;color:white;text-align:center;">Data Teknisi</th>                    
                </tr>
                <tr>
                    <th>Info Marketing</th>
                    <td><div class="info" onclick="mdl.marketing_info();"></div></td>
                </tr>
                
                <tr>
                    <th>Tanggal Masuk</th>
                    <td><label id="mdl_datein"></label></td>
                </tr>
                <tr>
                    <th>SN</th>
                    <td><label id="mdl_sn"></label></td>
                </tr>
                <tr>
                    <th>Device</th>
                    <td><label id="mdl_device"></label></td>
                </tr>
                <tr>
                    <th>Catatan Customer</th>
                    <td><textarea id="mdl_customer_note" disabled="disabled"></textarea></td>
                </tr>     
                <tr>
                    <th>Nama User</th>
                    <td><label id="mdl_user" ></label></td>
                </tr>           
                <tr>
                    <th>Garansi</th>
                    <td><input type="checkbox" id="mdl_guarantee"/></td>
                </tr>
                <tr>
                    <th>Catatan Teknisi</th>
                    <td><textarea id="mdl_note" disabled="disabled"></textarea></td>
                </tr> 
                <tr>
                <th>Kelengkapan</th>
                <td>
                    <table class="gridView" id="mdl_tbl">
                        <tr>
                            <th style="width:25px;"></th>
                            <th>Kelengkapan</th>
                        </tr>
                    </table>
                </td>
                <tr>
                    <th>Tanggal Selesai</th>
                    <td><input type="text" id="mdl_date_done" size="10" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><select id="mdl_status" disabled="disabled"></select></td>
                </tr>
            </table>

            <div style="padding-top:5px;" class="button_panel">                
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>
    <div id="mdl_schedule">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Tanggal</th>
                    <td><label id="mdl_schedule_date"></label></td>
                </tr>
                <tr>
                    <th>Type</th>
                    <td><label id="mdl_schedule_type"></label></td>
                </tr>
                <tr>
                    <th>Kurir</th>
                    <td><label id="mdl_schedule_messanger"></label></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><label id="mdl_schedule_contact"></label></td>
                </tr>
                <tr>
                    <th>Selesai</th>
                    <td><input type="checkbox" id="mdl_schedule_done" disabled="disabled"/></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>

    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            lb_sn: apl.func.get("cari_sn"),
            tb_customer: apl.func.get("cari_customer"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var sn = escape(cari.lb_sn.value);
                var name = escape(cari.tb_customer.value);
                cari.fl.src = "inq_service_device_list.aspx?sn=" + sn+"&name="+name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                service_device_id: 0,
                service_id: 0,
                device_register_id: 0,
                device_type_id: 0,
                lb_datein: apl.func.get("mdl_datein"),

                lb_sn: apl.func.get("mdl_sn"),
                lb_device: apl.func.get("mdl_device"),

                tb_customer_note: apl.func.get("mdl_customer_note"),
                cb_guarantee: apl.func.get("mdl_guarantee"),
                dl_status: apl.createDropdownWS("mdl_status", activities.dl_service_device_sts),
                tb_note: apl.func.get("mdl_note"),

                //dl_technician: apl.createDropdownWS("mdl_technician", activities.dl_tec_technician_list, undefined, undefined, false),

                tb_date_done: apl.createCalender("mdl_date_done"),
                lb_user: apl.func.get("mdl_user"),
                lb_offer_no: apl.func.get("mdl_offer_no"),
                lb_service_status: apl.func.get("mdl_service_status"),
                lb_service_status_marketing: apl.func.get("mdl_service_status_marketing"),
                lb_invoice_no: apl.func.get("mdl_invoice_no"),
                lb_invoice_date: apl.func.get("mdl_invoice_date"),

                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("status", undefined,
                            [apl.createTableWS.attribute("type", "checkbox"), apl.createTableWS.attribute("disabled", "disabled")],
                            function (data) { mdl.trimming_edit(data.device_type_trimming_id, this.checked);},
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
                
                tbl_schedule: apl.createTableWS.init("mdl_tbl_schedule",
                    [
                        //apl.createTableWS.column("schedule_id", undefined, [apl.createTableWS.attribute("style", "font-weight:bold;cursor:pointer;")], function (data) {  mdl_schedule.edit(data.schedule_id); },undefined,"a"),
                        apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "info")], function (data) { mdl_schedule.edit(data.schedule_id, data.expedition_type); }),
                        apl.createTableWS.column("schedule_id"),
                        apl.createTableWS.column("schedule_date"),
                        apl.createTableWS.column("expedition_type")
                    ]
                ),
                tbl_schedule_load: function () {
                    activities.xml_tec_service_device_schedule(mdl.service_device_id,
                        function (arrData) {
                            mdl.tbl_schedule.load(arrData);
                        }, apl.func.showError, ""
                    );
                },
                marketing_info:function()
                {
                    document.mdl_service_inq.edit(mdl.service_id);
                },
                kosongkan_device_register:function()
                {
                    mdl.device_register_id = 0;
                    mdl.lb_sn.value = "";
                    mdl.lb_device.setValue("", "");
                    mdl.lb_user.value = "";
                },
                kosongkan: function () {
                    mdl.service_id = 0;
                    mdl.service_device_id = 0;
                    mdl.device_register_id = 0;
                    //mdl.dl_technician.load();
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
                            mdl.lb_sn.innerHTML = data.sn;
                            mdl.lb_device.innerHTML = data.device;
                            mdl.tb_customer_note.value = data.customer_note;
                            mdl.cb_guarantee.checked = data.guarantee_sts;
                            mdl.cb_guarantee.disabled = true;

                            mdl.dl_status.value = data.service_device_sts_id;
                            mdl.tb_note.value = data.technician_note;
                            //mdl.dl_technician.value = data.technician_id;
                            mdl.tb_date_done.value = data.date_done;
                            mdl.lb_user.innerHTML = data.user_name;
                            mdl.lb_offer_no.innerHTML = data.offer_no;
                            mdl.lb_service_status.innerHTML = data.service_status;
                            mdl.lb_service_status_marketing.innerHTML = data.service_status_marketing;
                            mdl.lb_invoice_no.innerHTML = data.invoice_no;
                            mdl.lb_invoice_date.innerHTML = data.invoice_date;                            

                            mdl.tbl_load();
                            //mdl.tbl_vendor_load();
                            //mdl.tbl_component_load();
                            mdl.tbl_schedule_load();

                            mdl.showEdit("Service Barang - Edit (#"+data.service_device_id+')');
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                    
                }
                
            },
            undefined,
            undefined,
            undefined, "frm_page", "cover_content"
        );

        var mdl_schedule = apl.createModal("mdl_schedule",
            {
                lb_date: apl.func.get("mdl_schedule_date"),
                lb_type: apl.func.get("mdl_schedule_type"),
                lb_messanger: apl.func.get("mdl_schedule_messanger"),
                lb_contact: apl.func.get("mdl_schedule_contact"),
                cb_done: apl.func.get("mdl_schedule_done"),
                edit:function(id,type)
                {
                    apl.func.showSinkMessage("Memuat");
                    activities.act_schedule_data(id,
                        function (data) {
                            mdl_schedule.lb_date.innerHTML = data.schedule_date;
                            mdl_schedule.lb_type.innerHTML = type;
                            mdl_schedule.lb_messanger.innerHTML = data.messanger_name;
                            mdl_schedule.lb_contact.innerHTML = data.contact_name;
                            mdl_schedule.cb_done.checked = data.done_sts;
                            mdl_schedule.showAdd("Schedule - Info");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                }
            }, undefined, undefined, undefined, "frm_page", "mdl");
        

        window.addEventListener("load", function () {
            cari.load();
            document.list_edit = mdl.edit;
            document.get_device_register=function(id)
            {
                activities.tec_device_register_data(id,
                    function (data) {
                        mdl.device_register_id = id;
                        mdl.lb_sn.value = data.sn;
                        mdl.lb_device.setValue(data.device_id, data.device);
                    }, apl.func.showError, ""
                );
            }
        });
    </script>
</asp:Content>

