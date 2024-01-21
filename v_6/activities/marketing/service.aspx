<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page" %>

<%@ Register Src="~/activities/marketing/wuc_info_customer.ascx" TagPrefix="uc1" TagName="wuc_info_customer" %>
<%@ Register Src="~/activities/marketing/wuc_location_activity.ascx" TagPrefix="uc1" TagName="wuc_location_activity" %>
<%@ Register Src="~/activities/map/wuc_map.ascx" TagPrefix="uc1" TagName="wuc_map" %>




<script runat="server">
    public _test.App a;
    public string branch_id, disabled_sts;
    public int jam_tutup = 20;
    
    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        disabled_sts= (a.BranchID == "") ? "" : "disabled";

        DateTime now = DateTime.Now;
        /*
        if (now.TimeOfDay.Hours >= jam_tutup)
        {
            Response.Write("<!DOCTYPE html><html xmlns='http://www.w3.org/1999/xhtml'><head><title></title><link href='../../App_Themes/Page/Page.css' type='text/css' rel='stylesheet' /></head><body><h2>Sesi Input Selesai...</h2></body></html>");
            Response.End();    
        } 
         * */
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
            <td><input type="text" id="cari_customer" size="35"/></td>            
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
    
    <iframe class="frameList" id="fr_list"></iframe>   
    
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
                        <!--<div id="mdl_customer" style="float:left;"> </div>
                        &nbsp;<a onclick="info()" style="cursor:pointer;font-weight:bold;float:left;">Info</a>
                            -->
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
                <tr style="display:none;">
                    <th>Map</th>
                    <td>
                        <uc1:wuc_map runat="server" ID="map" />
                    </td>
                </tr>
                <tr>
                    <th>Catatan</th>
                    <td><textarea id="mdl_note" style="max-width:100%;width:615px;height:200px;font-family:'Courier New';"></textarea></td>
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
            </table>                    

            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add" />
                <input type="button" value="Save"/>
                <input type="button" value="Delete" />
                <input type="button" value="Cancel"/>
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
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var d = new Date();
        var jam_tutup = 0<%= jam_tutup %>;

        function check_jam_tutup(func)
        {
            return (d.getHours() >= jam_tutup);
        }

        function check_closehour(func)
        {
            activities.get_closehour_sts(
                function (status) {
                    if (status == true) alert("Sesi input telah selesai..."); else func();
                }, apl.func.showError, ""
            );
        }
        

        var cari = {
            tb_customer: apl.func.get("cari_customer"),
            ddl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            fl: apl.func.get("fr_list"),
            tb_customer: apl.func.get("cari_customer"),
            load:function()
            {
                var customer = cari.tb_customer.value;
                var branch_id = cari.ddl_branch.value;
                var user = "<%= a.cookieUserIDValue %>";
                
                cari.fl.src = "service_list.aspx?customer=" + escape(customer) + "&user=" + escape(user) + "&branchid=" + escape(branch_id);
            },
            fl_refresh:function()
            {
                //cari.fl.contentWindow.location.reload(true);
                cari.fl.contentWindow.document.refresh();                
            }
        }

        var mdl = apl.createModal("mdl",
            {
                service_id: 0,
                group_customer_id: 0,
                pickup_address_location_id: 0,
                tb_branch:apl.func.get("mdl_branch"),
                lb_date: apl.func.get("mdl_date"),
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
                ac_customer:apl.create_auto_complete_text("mdl_customer",activities.ac_customer,undefined,600,
                    function (data)
                    {
                        mdl.dl_an.clearItem();
                        mdl.dl_contact.clearItem();
                        mdl.group_customer_id = data.other_value;                        
                        /*
                        activities.act_customer_data(data.value,
                            function (data) {
                                mdl.group_customer_id = data.group_customer_id;                                
                            }, apl.func.showError, ""
                        );
                        */
                    },
                    function () { return "branch_id like '<%= branch_id %>'"; }
                ),
                dl_an: apl.createDropdownWS("mdl_an", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id( mdl.ac_customer.id); }),
                dl_contact: apl.createDropdownWS("mdl_contact", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                //tb_pickup_address: apl.func.get("mdl_pickup_address"),
                tb_pickup_address: apl.create_auto_complete_text("mdl_pickup_address", activities.ac_location_list, function () { mdl_addlocation.tambah();},600),

                tb_pickup_address2: apl.func.get("mdl_pickup_address2"),
                tb_note: apl.func.get("mdl_note"),
                tb_pickup_date: apl.createCalender("mdl_pickup_date"),
                tb_fee: apl.createNumeric("mdl_fee", true),
                dl_backup: apl.createDropdownWS("mdl_backup", activities.dl_backup_status_list),
                //val_customer: apl.createValidator("save", "mdl_customer", function () { return (mdl.ac_customer.getValue() == "") ? true : false; }, "Salah input"),
                val_customer: apl.createValidator("save", "mdl_customer", function () { return apl.func.emptyValueCheck(mdl.ac_customer.id); }, "Salah input"),

                val_an: apl.createValidator("save", "mdl_an", function () { return apl.func.emptyValueCheck(mdl.dl_an.value); }, "Salah input"),
                val_contact: apl.createValidator("save", "mdl_contact", function () { return apl.func.emptyValueCheck(mdl.dl_contact.value); }, "Salah input"),                

                val_pickup_address: apl.createValidator("save", "mdl_pickup_address", function () { return apl.func.emptyValueCheck(mdl.tb_pickup_address.id); }, "Salah input"),

                val_delivery_date: apl.createValidator("save", "mdl_pickup_date", function () { return (mdl.tb_pickup_date.value == "") ? true : false; }, "Salah input"),
                val_fee: apl.createValidator("save", "mdl_fee", function () { return (mdl.tb_fee.value == "") ? true : false; }, "Salah input"),
                val_backup: apl.createValidator("save", "mdl_backup", function () { return (mdl.dl_backup.value == "") ? true : false; }, "Salah input"),
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
                kosongkan: function ()
                {
                    mdl.service_id = 0;
                    pickup_address_location_id = 0;
                    mdl.tb_branch.value = "";
                    mdl.lb_date.innerHTML = "<%= a.cookieApplicationDateValue %>";
                    //mdl.ac_customer.setValue("", "");
                    mdl.ac_customer.set_value("", "");
                    mdl.dl_an.value = "";
                    mdl.dl_contact.value = "";
                    //mdl.tb_pickup_address.value = "";
                    
                    mdl.tb_pickup_address.set_value("", "");
                    
                    mdl.tb_pickup_address2.value = "";
                    mdl.tb_note.value = "";
                    mdl.tb_pickup_date.value = "<%= a.cookieApplicationDateValue %>";
                    mdl.tb_fee.value = "0";
                    mdl.dl_backup.value = "";                    
                    apl.func.validatorClear("save");
                },                
                refresh_modal:function()
                {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                add_pickup_address:function()
                {
                    document.mdl_location.open(2);
                },
                open_location:function()
                {
                    //if (mdl.ac_customer.getValue() != "") document.mdl_location.open(1,mdl.group_customer_id);
                    if (mdl.ac_customer.id != "") document.mdl_location.open(1, mdl.group_customer_id);
                },
                add_location: function () {                    
                    //if (mdl.ac_customer.getValue() != "") document.mdl_location.open(2);
                    if (mdl.ac_customer.id != "") document.mdl_location.open(2);
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Servis - Tambah");
                    document.map.latitude = "";
                    document.map.longitude= "";                    
                    //document.map.open("", "");
                },
                edit: function (id) {                    
                    mdl.kosongkan();
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
                            mdl.tb_branch.value = data.branch_customer;

                            mdl.showEdit("Servis - Edit");

                            document.map.latitude = data.latitude;
                            document.map.longitude = data.longitude;
                            //document.map.open(data.latitude, data.longitude);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                location_selected:function(location_id, location_address, customer_address, latitude, longitude)
                {
                    mdl.pickup_address_location_id = location_id;
                    //mdl.tb_pickup_address.value = location_address;
                    mdl.tb_pickup_address.set_value(location_id, location_address);
                    mdl.tb_pickup_address2.value = customer_address;
                    document.map.latitude = latitude;
                    document.map.longitude = longitude;                    
                    //document.map.open(latitude, longitude);
                }
            },
            function () {
                check_closehour(
                    function () {
                        if (apl.func.validatorCheck("save")) {
                            apl.func.showSinkMessage("Simpan");
                            activities.act_service_add(mdl.ac_customer.id, mdl.dl_an.value, mdl.dl_contact.value, mdl.tb_pickup_address2.value, mdl.tb_note.value, mdl.tb_pickup_address.id, mdl.tb_pickup_date.value, mdl.tb_fee.getIntValue(), mdl.dl_backup.value, document.map.latitude, document.map.longitude, mdl.tb_branch.value, mdl.refresh_modal, apl.func.showError, "");
                        }
                    }
                )
            },
            function () {
                check_closehour(
                    function () {                        
                        if (apl.func.validatorCheck("save")) {
                            apl.func.showSinkMessage("Simpan");
                            activities.act_service_edit(mdl.service_id, mdl.ac_customer.id, mdl.dl_an.value, mdl.dl_contact.value, mdl.tb_pickup_address2.value, mdl.tb_note.value, mdl.tb_pickup_address.id, mdl.tb_pickup_date.value, mdl.tb_fee.getIntValue(), mdl.dl_backup.value, document.map.latitude, document.map.longitude, mdl.tb_branch.value, mdl.refresh_modal, apl.func.showError, "");
                        }
                    }
                )
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Hapus");
                    activities.act_service_delete(mdl.service_id, mdl.refresh_modal, apl.func.showError, "");
                }
            }, "frm_page", "cover_content", ""
        );

        document.list_add = mdl.tambah;
        document.list_edit = mdl.edit;

        info = function ()
        {
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
            cari.ddl_branch.setValue("<%= branch_id %>");
            cari.load();
        });

        

        //apl.createTableWS.column('df', undefined, {apl.})
        //apl.func.createAttribute("class","select")

    </script>
</asp:Content>

