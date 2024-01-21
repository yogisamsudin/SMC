<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/marketing/wuc_info_customer.ascx" TagPrefix="uc1" TagName="wuc_info_customer" %>
<%@ Register Src="~/activities/marketing/wuc_location_activity.ascx" TagPrefix="uc1" TagName="wuc_location_activity" %>
<%@ Register Src="~/activities/map/wuc_map.ascx" TagPrefix="uc1" TagName="wuc_map" %>


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
                        <input type="text" id="mdl_delivery_address" />
                        <div style="float:left;" class="select" onclick="mdl.open_location()"></div>
                        <!--
                        <textarea id="mdl_delivery_address" style="float:left" disabled="disabled"></textarea>
                        <div style="float:left;" class="select" onclick="mdl.open_location()"></div>
                        <div style="float:left;" class="tambah" onclick="mdl.add_location()"></div>
                        -->
                    </td>
                </tr>
                <tr>
                    <th>Alamat Kurir #2</th>
                    <td><input type="text" id="mdl_delivery_address2" size="100" maxlength="300"/></td>
                </tr>
                <tr style="display:none;">
                    <th>Map</th>
                    <td>
                        <uc1:wuc_map runat="server" ID="map" />
                    </td>
                </tr>
                <tr>
                    <th>Catatan</th>
                    <td><textarea id="mdl_note" style="max-width:100%;width:600px;height:200px;font-family:'Courier New';"></textarea></td>
                </tr>
                <tr>
                    <th>Fee</th>
                    <td><input type="text" id="mdl_fee" style="text-align:right;"/></td>
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
        var cari = {
            tb_customer: apl.func.get("cari_customer"),
            ddl_branch: apl.createDropdownWS("cari_branch", activities.dl_par_branch_list),
            fl: apl.func.get("fr_list"),            
            load: function () {
                var customer = cari.tb_customer.value;
                var branch_id = cari.ddl_branch.value;
                var user = "<%= a.cookieUserIDValue %>";
                cari.fl.src = "sales_list.aspx?customer=" + escape(customer) + "&user=" + escape(user) + "&branchid=" + escape(branch_id);
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();                
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                delivery_address_location_id: 0,
                sales_id: 0,
                group_customer_id: 0,
                lb_date: apl.func.get("mdl_date"),
                tb_branch: apl.func.get("mdl_branch"),
                /*
                ac_customer: apl.createAutoComplete("mdl_customer", activities.ac_customer, 400,
                    function (value, text)
                    {
                        mdl.dl_an.value = "";
                        mdl.dl_contact.value = "";
                        activities.act_customer_data(value,
                            function (data) {
                                mdl.group_customer_id = data.group_customer_id;                                
                            }, apl.func.showError, ""
                        );
                    }, undefined,
                    function () {
                        mdl.dl_an.setValue("");
                        mdl.dl_contact.setValue("");
                        mdl.dl_an.load("");
                        mdl.dl_contact.load("");
                    }
                ),
                */
                ac_customer: apl.create_auto_complete_text("mdl_customer", activities.ac_customer, undefined, 600,
                    function (data) {
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
                dl_an: apl.createDropdownWS("mdl_an", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                dl_contact: apl.createDropdownWS("mdl_contact", activities.dl_contact_an_by_customer_id, undefined, undefined, true, function () { return " customer_id=" + mdl.get_customer_id(mdl.ac_customer.id); }),
                //dl_status: apl.createDropdownWS("mdl_status", activities.dl_lvlmktsts),
                //tb_delivery_address: apl.func.get("mdl_delivery_address"),
                tb_delivery_address: apl.create_auto_complete_text("mdl_delivery_address", activities.ac_location_list, function () { mdl_addlocation.tambah(); },600),

                tb_delivery_address2: apl.func.get("mdl_delivery_address2"),
                tb_note: apl.func.get("mdl_note"),
                //tb_sent_date: apl.createCalender("mdl_sent_date"),
                tb_fee: apl.createNumeric("mdl_fee",true),
                //val_customer: apl.createValidator("save", "mdl_customer", function () { return (mdl.ac_customer.getValue() == "") ? true : false; }, "Salah input"),
                val_customer: apl.createValidator("save", "mdl_customer", function () { return apl.func.emptyValueCheck(mdl.ac_customer.id); }, "Salah input"),

                val_delivery_address: apl.createValidator("save", "mdl_delivery_address", function () { return apl.func.emptyValueCheck(mdl.tb_delivery_address.id); }, "Salah input"),
                val_an: apl.createValidator("save", "mdl_an", function () { return apl.func.emptyValueCheck(mdl.dl_an.value); }, "Salah input"),
                val_contact: apl.createValidator("save", "mdl_contact", function () { return apl.func.emptyValueCheck(mdl.dl_contact.value); }, "Salah input"),
                //val_status: apl.createValidator("save", "mdl_status", function () { return apl.func.emptyValueCheck(mdl.dl_status.value); }, "Salah input"),
                val_note: apl.createValidator("save", "mdl_note", function () { return (mdl.tb_note.value == "") ? true : false; }, "Salah input"),
                //val_delivery_date: apl.createValidator("save", "mdl_sent_date", function () { return (mdl.tb_sent_date.value == "") ? true : false; }, "Salah input"),
                val_fee: apl.createValidator("save", "mdl_fee", function () { return (mdl.tb_fee.value == "") ? true : false; }, "Salah input"),
                
                get_customer_id: function (nilai) {
                    if (apl.func.emptyValueCheck(nilai)) {
                        return "1"
                    } else {
                        return nilai;
                    }
                },
                kosongkan: function () {
                    mdl.sales_id = 0;
                    mdl.lb_date.innerHTML = "<%= a.cookieApplicationDateValue %>";
                    mdl.ac_customer.set_value("", "");
                    mdl.dl_an.value = "";
                    mdl.dl_contact.value = "";
                    //mdl.dl_status.value = "";
                    //mdl.tb_delivery_address.value = "";
                    mdl.tb_delivery_address.set_value("", "");
                    mdl.tb_delivery_address2.value = "";
                    mdl.tb_note.value = "";
                    //mdl.tb_sent_date.value = "";
                    mdl.tb_fee.value = "";
                    mdl.tb_branch.value = "";
                    apl.func.validatorClear("save");
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Sales - Tambah");

                    document.map.latitude = "";
                    document.map.longitude = "";
                    //document.map.open("", "");
                },
                edit: function (id) {
                    mdl.kosongkan();
                    apl.func.showSinkMessage("Memuat Data");
                    activities.act_sales_data(id,
                        function (data) {
                            mdl.sales_id = id;
                            mdl.group_customer_id = data.group_customer_id;
                            mdl.ac_customer.set_value(data.customer_id, data.customer_name);
                            mdl.dl_an.load(data.an_id);                            
                            mdl.dl_contact.load(data.contact_id);
                            //mdl.dl_status.value = data.lvlmktsts_id;
                            mdl.tb_delivery_address2.value = data.delivery_address;
                            mdl.tb_note.value = data.note;
                            //mdl.tb_sent_date.value = data.sent_date;
                            //mdl.tb_delivery_address.value = data.delivery_address_location;
                            mdl.tb_delivery_address.set_value(data.delivery_address_location_id, data.delivery_address_location);

                            mdl.delivery_address_location_id = data.delivery_address_location_id;
                            mdl.tb_fee.setValue(data.fee);
                            mdl.tb_branch.value = data.branch_customer;

                            mdl.showEdit("Sales - Edit")

                            document.map.latitude = data.latitude;
                            document.map.longitude = data.longitude;
                            //document.map.open(data.latitude, data.longitude);
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh_modal: function () {
                    mdl.hide();
                    cari.fl_refresh();
                    apl.func.hideSinkMessage();
                },
                open_location: function () {
                    if (mdl.ac_customer.id != "") document.mdl_location.open(1, mdl.group_customer_id);
                },
                add_location: function () {
                    if (mdl.ac_customer.id != "") document.mdl_location.open(2);
                },
                location_selected: function (location_id, location_address, customer_address, lat, lng) {
                    mdl.delivery_address_location_id = location_id;
                    //mdl.tb_delivery_address.value = location_address;
                    mdl.tb_delivery_address2.value = customer_address;

                    mdl.tb_delivery_address.set_value(location_id, location_address);

                    document.map.latitude = lat;
                    document.map.longitude = lng;
                    //document.map.open(lat, lng);
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Simpan");                    
                    activities.act_sales_add(mdl.ac_customer.id, mdl.dl_an.value, mdl.dl_contact.value, mdl.tb_delivery_address2.value, mdl.tb_note.value, mdl.tb_delivery_address.id, mdl.tb_fee.getIntValue(), document.map.latitude, document.map.longitude, mdl.tb_branch.value, mdl.refresh_modal, apl.func.showError, "");
                }
            },
            
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Simpan");
                    activities.act_sales_edit(mdl.sales_id, mdl.ac_customer.id, mdl.dl_an.value, mdl.dl_contact.value, mdl.tb_delivery_address2.value, mdl.tb_note.value, mdl.tb_delivery_address.id,mdl.tb_fee.getIntValue(),"",document.map.latitude,document.map.longitude,mdl.tb_branch.value, mdl.refresh_modal, apl.func.showError, "");
                }
            },            
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Hapus");
                    activities.act_sales_delete(mdl.sales_id, mdl.refresh_modal, apl.func.showError, "");
                }
            }, "frm_page", "cover_content", ""
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

        document.list_tambah = mdl.tambah;
        document.list_edit = mdl.edit;

        info = function () {
            var id = mdl.ac_customer.id;
            if (id > 0) document.mdlinq_customer.info(id);
        }

        window.addEventListener("load", function ()
        {
            cari.ddl_branch.setValue("<%= branch_id %>");
            cari.load();
        });

    </script>
</asp:Content>

