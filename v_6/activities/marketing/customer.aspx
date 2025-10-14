<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page" %>

<%@ Register Src="~/activities/expedition/wuc_location_select.ascx" TagPrefix="uc1" TagName="wuc_location_select" %>
<%@ Register Src="~/activities/map/wuc_map.ascx" TagPrefix="uc1" TagName="wuc_map" %>




<script runat="server">
    public string g_marketing_id = "", branch_disabled = "", branch_id, html_all_access_disabled = "";    
    public Boolean all_access_sts = false;
    public _test.App a;

    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
        string strSQL = "select marketing_id,all_access from v_act_marketing where user_id='" + a.cookieUserIDValue + "' or assistant_user_id='" + a.cookieUserIDValue + "'";

        _test._DBcon c = new _test._DBcon();
        foreach (System.Data.DataRow row in c.executeTextQ(strSQL))
        {
            g_marketing_id = row["marketing_id"].ToString();
            all_access_sts=Convert.ToBoolean(row["all_access"]);
        }
        g_marketing_id = (g_marketing_id == "") ? "semua" : g_marketing_id;
        branch_disabled = (a.BranchID == "") ? "" : "disabled";
        branch_id = (a.BranchID == "") ? "%" : a.BranchID;
        html_all_access_disabled = (all_access_sts == true) ? "" : "disabled='disabled'";
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
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" size="35"/></td>            
        </tr>
        <tr>
            <th>Marketing</th>
            <td><select id="cari_marketing"></select></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="fl.fl.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="fr_list"></iframe> 
    
    <div id="googleMap" style="width:600px;height:400px;"></div> 

    <uc1:wuc_location_select runat="server" ID="mdl_location" parent_id="frm_page" cover_id="mdl" select_function="list_select"/>

    <div id="mdl" class="modal">
        <fieldset>
            <legend>Pelanggan</legend>
            <table class="formview">
                <tr>
                    <th style="width:100px;">Nama</th>
                    <td><input type="text" id="mdl_name" size="50"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Group</th>
                    <td><input type="text" id="mdl_group_customer" />
                        <!--<div id="mdl_group_customer"></div>-->

                    </td>
                </tr>
                
                <tr>
                    <th style="width:100px;">Alamat #1</th>
                    <td><input type="text" id="mdl_address" size="100" maxlength="300"/>
                        
                        <!--
                        <textarea id="mdl_address" style="float:left;" maxlength="300"></textarea>
                        <div class="select" style="float:left;" onclick="mdl.open_location()"></div>
                        <div class="tambah" style="float:left;" onclick="mdl.tambah_location()"></div>
                        -->
                    </td>
                </tr>
                <tr>
                    <th style="width:100px;">Alamat #2</th>
                    <td><input type="text" id="mdl_address2" size="100" maxlength="300"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Telepon</th>
                    <td><input type="text" id="mdl_phone" size="15" maxlength="15"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Fax</th>
                    <td><input type="text" id="mdl_fax" size="15" maxlength="15"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Email</th>
                    <td><input type="text" id="mdl_email" size="150" maxlength="150"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">NPWP</th>
                    <td><input type="text" id="mdl_npwp" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Marketing</th>
                    <td><select id="mdl_marketing" <%= html_all_access_disabled %>></select></td>
                </tr>
                <tr>
                    <th>Cabang</th>
                    <td><select id="mdl_branch" <%= branch_disabled %>></select></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td>
                        <table id="mdl_tbl" class="gridView">
                            <tr>
                                <th ><div class="tambah" onclick="mdl_contact.tambah()"></div></th>
                                <th>Name</th>
                                <th>Phone</th>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th><span title="Status input user device jadi mandatory">Status Input User</span></th>
                    <td><input type="checkbox" id="mdl_userdevicemandatory"/></td>
                </tr>
                <tr style="display:none;">
                    <th></th>
                    <td>
                        <uc1:wuc_map runat="server" ID="map" />
                    </td>
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

    
    <div id="mdl_contact">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_contact_name" size="35" maxlength="35"/></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><input type="text" id="mdl_contact_phone" size="15" maxlength="15"/></td>
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
        var def_latitude = sessionStorage.getItem("lat");
        var def_longitude = sessionStorage.getItem("lng");

        var fl = apl.func.get("fr_list");
        fl.fl = {
            tb_customer: apl.func.get("cari_customer"),
            ddl_marketing: apl.createDropdownWS("cari_marketing", activities.dl_marketing_all_list),
            load : function ()
            {
                var name = escape(fl.fl.tb_customer.value);
                var marketing = escape(fl.fl.ddl_marketing.value);
                fl.src = "customer_list.aspx?marketing=<%= g_marketing_id %>&name=" + name + "&marketing0=" + marketing;
            },
            refresh:function()
            {
                //fl.contentWindow.location.reload(true);
                fl.contentWindow.document.refresh();                
            }
        }
        
        
        var mdl = apl.createModal("mdl",
            {
                customer_id: 0,
                customer_address_location_id: 0,
                //ac_group_customer: apl.createAutoComplete("mdl_group_customer", activities.ac_customer, 400),
                ac_group_customer: apl.create_auto_complete_text("mdl_group_customer", activities.ac_customer),
                tb_name: apl.func.get("mdl_name"),
                //tb_address: apl.func.get("mdl_address"),
                tb_address: apl.create_auto_complete_text("mdl_address", activities.ac_location_list, function () { mdl_addlocation.tambah(); },600),
                tb_address2: apl.func.get("mdl_address2"),
                tb_phone: apl.createNumeric("mdl_phone",false),
                tb_fax: apl.createNumeric("mdl_fax",false),
                tb_email: apl.func.get("mdl_email"),
                tb_npwp: apl.func.get("mdl_npwp"),                
                //tb_distance: apl.createNumeric("mdl_distance", true),
                tbl: apl.createTableWS.init("mdl_tbl",
                        [
                            apl.createTableWS.column("", "", [apl.func.createAttribute("class", "edit")], function (data) {
                                mdl_contact.edit(data.contact_id);
                            }, false),
                            apl.createTableWS.column("contact_name"),
                            apl.createTableWS.column("contact_phone")
                        ]
                ),
                dl_marketing: apl.createDropdownWS("mdl_marketing", activities.ddl_marketing),
                dl_branch: apl.createDropdownWS("mdl_branch", activities.dl_par_branch_list),
                cb_userdevicemandatory: apl.func.get("mdl_userdevicemandatory"),
                val_name: apl.createValidator("save", "mdl_name", function () { return apl.func.emptyValueCheck(mdl.tb_name.value); }, "Inputan salah"),
                //val_address: apl.createValidator("save", "mdl_address", function () { return apl.func.emptyValueCheck(mdl.tb_address.value); }, "Inputan salah"),
                val_address: apl.createValidator("save", "mdl_address", function () { return apl.func.emptyValueCheck(mdl.tb_address.id); }, "Inputan salah"),
                val_phone: apl.createValidator("save", "mdl_phone", function () { return apl.func.emptyValueCheck(mdl.tb_phone.value); }, "Inputan salah"),
                val_email: apl.createValidator("save", "mdl_email", function () { return apl.func.emptyValueCheck(mdl.tb_email.value); }, "Inputan salah"),
                //val_distance: apl.createValidator("save", "mdl_distance", function () { return apl.func.emptyValueCheck(mdl.tb_distance.value); }, "Inputan salah"),
                val_marketing: apl.createValidator("save", "mdl_marketing", function () { return apl.func.emptyValueCheck(mdl.dl_marketing.value); }, "Inputan salah"),
                val_branch: apl.createValidator("save", "mdl_branch", function () { return apl.func.emptyValueCheck((mdl.dl_branch.value == "%") ? "" : "mdl.dl_branch.value"); }, "Inputan salah"),
                tbl_load:function()
                {
                    activities.act_customer_contact_list(mdl.customer_id,
                        function (arrData) {
                            mdl.tbl.load(arrData);
                        }, apl.func.showError, ""
                    );
                    
                },
                open_location:function()
                {
                    document.mdl_location.open();
                },
                tambah_location:function()
                {
                    mdl.customer_address_location_id = 0;                    
                    mdl.tb_address.readOnly= false;
                    mdl.tb_address.value = "";                    
                },
                select_location:function(id)
                {
                    activities.act_location_data(id,
                        function (data) {
                            mdl.customer_address_location_id = id;
                            mdl.tb_address.value = data.location_address;
                            mdl.tb_address.readOnly= true;
                            document.mdl_location.close();
                        }, apl.func.showError, ""
                    );
                },
                kosongkan: function ()
                {
                    mdl.customer_id = 0;
                    mdl.customer_address_location_id = 0;
                    mdl.tb_name.value = "";
                    mdl.ac_group_customer.set_value("", "");
                    mdl.tb_address.set_value("", "");
                    //mdl.tb_address.readOnly= true;                    
                    mdl.tb_address2.value = "";
                    mdl.tb_phone.value = "";
                    mdl.tb_fax.value = "";
                    mdl.tb_email.value = "";
                    mdl.tb_npwp.value = "";
                    //mdl.dl_branch.setValue("");
                    
                    //mdl.tb_distance.value = "";
                    mdl.dl_marketing.value = "<%= g_marketing_id%>";
                    mdl.cb_userdevicemandatory.checked = false;
                    apl.func.validatorClear("save");
                },
                tambah: function ()
                {
                    mdl.kosongkan();
                    mdl.tbl.Hide();
                    //mdl.ac_group_customer.Hide();
                    mdl.ac_group_customer.input.disabled = true;
                    mdl.dl_branch.setValue("<%= branch_id %>");
                    mdl.showAdd("Customer - Tambah");

                    document.map.latitude = "";
                    document.map.longitude = "";
                    //document.map.open("", "");
                },
                edit:function(customer_id)
                {
                    mdl.kosongkan();
                    mdl.customer_id = customer_id;
                    mdl.tbl.Show();
                    //mdl.ac_group_customer.Show();                    
                    mdl.ac_group_customer.input.disabled = false;
                    mdl.tbl_load();
                    activities.act_customer_data(customer_id,
                        function (data) {
                            mdl.tb_name.value = data.customer_name;
                            //mdl.tb_address.value = data.customer_address_location;
                            mdl.tb_address.set_value(data.customer_address_location_id, data.customer_address_location);
                            //mdl.customer_address_location_id = data.customer_address_location_id;
                            
                            mdl.tb_address2.value = data.customer_address;
                            mdl.tb_phone.value = data.customer_phone;
                            mdl.tb_fax.value = data.customer_fax;
                            mdl.tb_email.value = data.customer_email;
                            mdl.tb_npwp.value = data.npwp;
                            //mdl.tb_distance.value = data.distance;
                            mdl.dl_marketing.value = data.marketing_id;
                            mdl.ac_group_customer.set_value(data.group_customer_id, data.group_customer);
                            mdl.dl_branch.setValue(data.branch_id);
                            mdl.cb_userdevicemandatory.checked = data.user_device_mandatory;
                            mdl.showEdit("Customer - Edit");

                            document.map.latitude = data.latitude;
                            document.map.longitude = data.longitude;
                            //document.map.open(data.latitude, data.longitude);

                        }, apl.func.showError, ""
                    );                    
                },
                refresh: function ()
                {
                    mdl.hide();
                    fl.fl.refresh();
                }
            },
            function ()
            {
                if(apl.func.validatorCheck("save"))
                {
                    var lat = (document.map.latitude == undefined) ? "" : document.map.latitude;
                    var lng = (document.map.longitude == undefined) ? "" : document.map.longitude;

                    activities.act_customer_add(mdl.tb_name.value, mdl.tb_address.text, mdl.tb_address2.value, mdl.tb_phone.value, mdl.tb_fax.value, mdl.tb_email.value, mdl.dl_marketing.value, mdl.tb_address.id, mdl.tb_npwp.value, lat, lng, mdl.dl_branch.value,mdl.cb_userdevicemandatory.checked,"1",
                        function (customer_id) {
                            mdl.refresh();
                            mdl.edit(customer_id);
                        },
                        apl.func.showError, "");
                }
            }, 
            function () {
                if (apl.func.validatorCheck("save")) {
                    var lat = (document.map.latitude == undefined) ? "" : document.map.latitude;
                    var lng = (document.map.longitude == undefined) ? "" : document.map.longitude;

                    activities.act_customer_edit(mdl.customer_id, mdl.tb_name.value, mdl.tb_address.text, mdl.tb_address2.value, mdl.tb_phone.value, mdl.tb_fax.value, mdl.tb_email.value, mdl.dl_marketing.value, mdl.tb_address.id, mdl.ac_group_customer.id, mdl.customer_address_location_id, mdl.tb_npwp.value, lat, lng, mdl.dl_branch.value, mdl.cb_userdevicemandatory.checked, mdl.refresh, apl.func.showError, "");
                }
            }, 
            function () {
                if (confirm("Yakin akan dihapus?"))
                {
                    activities.act_customer_delete(mdl.customer_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );

        mdl_contact = apl.createModal("mdl_contact",
            {
                contact_id: 0,
                tb_name: apl.func.get("mdl_contact_name"),
                tb_phone: apl.createNumeric("mdl_contact_phone",false),
                val_name: apl.createValidator("contact_save", "mdl_contact_name", function () { return apl.func.emptyValueCheck(mdl_contact.tb_name.value); }, "Input salah"),
                kosongkan: function () {
                    mdl_contact.tb_name.value = "";
                    mdl_contact.tb_phone.value = "";
                    apl.func.validatorClear("contact_save");
                },
                tambah: function () {
                    mdl_contact.contact_id = 0;
                    mdl_contact.kosongkan();
                    mdl_contact.showAdd("Kontak - Tambah");
                },
                edit: function (contact_id) {
                    mdl_contact.contact_id = contact_id;
                    mdl_contact.kosongkan();
                    activities.act_customer_contact_data(contact_id,
                        function (data)
                        {
                            mdl_contact.tb_name.value = data.contact_name;
                            mdl_contact.tb_phone.value = data.contact_phone;
                            mdl_contact.showEdit("Kontak - Edit");
                        }, apl.func.showError, ""
                    );

                },
                refresh: function () {
                    mdl.tbl_load();
                    mdl_contact.hide();
                }
            }, 
            function ()
            {
                if(apl.func.validatorCheck("contact_save")) activities.act_customer_contact_add(mdl.customer_id, mdl_contact.tb_name.value, mdl_contact.tb_phone.value, mdl_contact.refresh, apl.func.showError, "");                
            }, 
            function () {
                if (apl.func.validatorCheck("contact_save")) activities.act_customer_contact_edit(mdl_contact.contact_id, mdl_contact.tb_name.value, mdl_contact.tb_phone.value, mdl_contact.refresh, apl.func.showError, "");
            },
            function()
            {
                if(confirm("Yakin akan dihapus?")) activities.act_customer_contact_delete(mdl_contact.contact_id, mdl_contact.refresh, apl.func.showError, "");                
            },
            "frm_page", "mdl"
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
            function ()
            {
                if (apl.func.validatorCheck("save_location"))
                {
                    apl.func.showSinkMessage("Menyimpan...");
                    activities.exp_location_add(mdl_addlocation.tb_location.value, 0, function () { mdl_addlocation.hide(); apl.func.hideSinkMessage(); }, apl.func.showError, "");
                }
            },
            undefined, undefined, "frm_page", "mdl"
        );

        window.addEventListener("load", function ()
        {
            fl.fl.load();
            document.list_tambah = mdl.tambah;
            document.list_edit = mdl.edit;
            document.list_select = mdl.select_location;
        });
                      
        
    </script>

    
    
</asp:Content>

