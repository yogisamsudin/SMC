<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%>

<%@ Register Src="~/activities/expedition/wuc_location_select.ascx" TagPrefix="uc1" TagName="wuc_location_select" %>


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
            <th>Vendor</th>
            <td><input type="text" id="cari_vendor"/></td>
        </tr>
        <tr>
            <th>Kategori</th>
            <td><select id="cari_category"></select></td>
        </tr>
        <tr>
            <th>Merek</th>
            <td><select id="cari_merk"></select></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe> 

    <uc1:wuc_location_select runat="server" ID="mdl_location" parent_id="frm_page" cover_id="mdl" select_function="list_select" />

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Vendor</th>
                    <td><input type="text" id="mdl_vendor" size="100" maxlength="100"/></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><input type="text" size="100" maxlength="100" id="mdl_contact"/></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><input type="text" size="100" maxlength="100" id="mdl_phone1"/></td>
                </tr>
                <tr>
                    <th>Fax</th>
                    <td><input type="text" size="100" maxlength="100" id="mdl_phone2"/></td>
                </tr>
                <tr>
                    <th>Alamat #1</th>
                    <td>
                        <textarea id="mdl_address1" maxlength="300" style="float:left;"></textarea>
                        <div class="select" style="float:left;" onclick="mdl.select_location();"></div>
                        <div class="tambah" style="float:left;" onclick="mdl.tambah_location();"></div>
                    </td>
                </tr>
                <tr>
                    <th>Alamat #2</th>
                    <td><textarea id="mdl_address2" maxlength="300"></textarea></td>
                </tr>                
                <tr>
                    <th>Akses Servis Data</th>
                    <td><input type="checkbox" id="mdl_access"/></td>
                </tr>
                <tr>
                    <th>Rekening</th>
                    <td>
                        <table class="gridView" id="mdl_tbl" style="min-width:400px;">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl_bill.tambah()"></div></th>
                                <th>Nama Rekening</th>
                                <th>No.Rekening</th>
                                <th>Bank</th>
                            </tr>
                        </table>
                    </td>
                </tr>                
                <tr>
                    <th>Kategori</th>
                    <td>
                        <table class="gridView" id="mdl_tbl_category" style="min-width:400px;">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl_category.tambah()"></div></th>
                                <th>Kategori</th>                                
                            </tr>
                        </table>
                    </td>
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

    <div class="modal" id="mdl_bill">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><input type="text" id="mdl_bill_name" size="50"/></td>
                </tr>
                <tr>
                    <th>No.Rekening</th>
                    <td><input type="text" id="mdl_bill_no" size="50"/></td>
                </tr>
                <tr>
                    <th>Bank</th>
                    <td><input type="text" id="mdl_bill_bank" size="50"/></td>
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

    <div class="modal" id="mdl_category">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Kategori</th>
                    <td><select id="mdl_category_dl"></select></td>
                </tr>
                <tr>
                    <th>Merk</th>
                    <td>
                        <select id="mdl_category_dlmerk"></select>
                        <table class="gridView" id="mdl_category_tbl" style="min-width:400px;">
                            <tr>
                                <th style="width:25px"><div class="tambah" onclick="mdl_category_merk.tambah()"></div></th>
                                <th>Merk</th>                                
                            </tr>
                        </table>
                    </td>
                </tr> 
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>                
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div class="modal" id="mdl_category_merk">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Merk</th>
                    <td><select id="mdl_category_merk_dl"></select></td>
                </tr>                
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Add"/>                
                <input type="button" value="Delete"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_vendor: apl.func.get("cari_vendor"),
            dl_category: apl.createDropdownWS("cari_category", activities.dl_par_vendor_category_all),
            dl_merk: apl.createDropdownWS("cari_merk", activities.dl_par_merk_all),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = window.escape(cari.tb_vendor.value);
                var catg = window.escape(cari.dl_category.value);
                var merk = window.escape(cari.dl_merk.value);
                cari.fl.src = "vendor_list.aspx?name=" + name+"&catg="+catg+"&merk="+merk;
            },
            fl_refresh: function () {                
                cari.fl.contentDocument.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                vendor_id: 0,
                location_id: 0,
                tb_vendor: apl.func.get("mdl_vendor"),
                tb_contact: apl.func.get("mdl_contact"),
                tb_phone1: apl.createNumeric("mdl_phone1",false),
                tb_phone2: apl.createNumeric("mdl_phone2",false),
                tb_address1: apl.func.get("mdl_address1"),
                tb_address2: apl.func.get("mdl_address2"),
                cb_access: apl.func.get("mdl_access"),
                tbl: apl.createTableWS.init("mdl_tbl", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_bill.edit(data.bill_id); }),
                    apl.createTableWS.column("bill_name"),
                    apl.createTableWS.column("bill_no"),
                    apl.createTableWS.column("bill_bank_name")
                ]),
                tbl_load:function()
                {
                    activities.opr_vendor_bill_list(mdl.vendor_id, function (arr_data) { mdl.tbl.load(arr_data);}, apl.func.showError, "");
                },
                tbl_category: apl.createTableWS.init("mdl_tbl_category", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_category.edit(data.vendor_id, data.vendor_category_id); }),
                    apl.createTableWS.column("vendor_category_name")
                ]),
                tbl_category_load: function () {
                    activities.opr_vendor_category_list(mdl.vendor_id, function (arr_data) { mdl.tbl_category.load(arr_data); }, apl.func.showError, "");
                },
                

                val_vendor: apl.createValidator("save", "mdl_vendor", function () { return apl.func.emptyValueCheck(mdl.tb_vendor.value); }, "Salah input"),
                val_address1: apl.createValidator("save", "mdl_address1", function () { return apl.func.emptyValueCheck(mdl.tb_address1.value); }, "Salah input"),

                select_location:function()
                {
                    document.mdl_location.open();
                },
                tambah_location: function ()
                {
                    mdl.location_id = 0;
                    mdl.tb_address1.disabled = false;
                    mdl.tb_address1.value = "";
                    mdl.tb_contact.value = "";
                    mdl.tb_phone1.value = "";
                    mdl.tb_phone2.value = "";
                    mdl.tbl.clearAllRow();
                    mdl.tbl_category.clearAllRow();
                },
                select:function(id)
                {
                    activities.act_location_data(id,
                        function (data) {
                            mdl.location_id = id;
                            mdl.tb_address1.value = data.location_address;
                            mdl.tb_address1.disabled = true;
                            document.mdl_location.close();
                        }, apl.func.showError, ""
                    );                    
                },
                kosongkan: function () {
                    mdl.vendor_id = 0;
                    mdl.tb_vendor.value = "";
                    mdl.tb_contact.value = "";
                    mdl.tb_phone1.value = "";
                    mdl.tb_phone2.value = "";
                    mdl.tb_address1.value = "";
                    mdl.tb_address1.disabled = true;
                    mdl.tb_address2.value = "";
                    mdl.cb_access.checked = false;
                    apl.func.validatorClear("save");

                    mdl.tbl.clearAllRow();
                    mdl.tbl_category.clearAllRow();
                },
                tambah: function () {
                    mdl.kosongkan();
                    mdl.showAdd("Device - Tambah");
                },
                edit: function (id) {                    
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    mdl.vendor_id = id;
                    mdl.tbl_load();
                    mdl.tbl_category_load();
                    
                    activities.opr_vendor_data(id,
                        function (data) {                            
                            mdl.tb_vendor.value = data.vendor_name;
                            mdl.location_id = data.location_id;
                            mdl.tb_address1.value = data.location_address;
                            mdl.tb_address2.value = data.vendor_address;
                            mdl.tb_contact.value = data.contact_name;
                            mdl.tb_phone1.value = data.phone1;
                            mdl.tb_phone2.value = data.phone2;
                            mdl.cb_access.checked = data.access_service_data_sts;                            
                            mdl.showEdit("Vendor - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    cari.fl_refresh();
                    mdl.hide();
                    apl.func.hideSinkMessage();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.opr_vendor_add(mdl.tb_vendor.value, mdl.location_id, mdl.tb_address1.value, mdl.tb_address2.value, mdl.tb_contact.value, mdl.tb_phone1.value, mdl.tb_phone2.value,mdl.cb_access.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    apl.func.showSinkMessage("Menyimpan");
                    activities.opr_vendor_edit(mdl.vendor_id,mdl.tb_vendor.value, mdl.location_id, mdl.tb_address1.value, mdl.tb_address2.value,mdl.tb_contact.value,mdl.tb_phone1.value,mdl.tb_phone2.value,mdl.cb_access.checked, mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus");
                    activities.opr_vendor_delete(mdl.vendor_id, mdl.refresh, apl.func.showError, "");
                }
            }, "frm_page", "cover_content"
        );
        
        var mdl_bill = apl.createModal("mdl_bill",
            {
                id: 0,
                tb_name: apl.func.get("mdl_bill_name"),
                tb_no: apl.func.get("mdl_bill_no"),
                tb_bank: apl.func.get("mdl_bill_bank"),

                val_name: apl.createValidator("bill_save", "mdl_bill_name", function () { return apl.func.emptyValueCheck(mdl_bill.tb_name.value) }, "Kesalahan input"),
                val_no: apl.createValidator("bill_save", "mdl_bill_no", function () { return apl.func.emptyValueCheck(mdl_bill.tb_no.value) }, "Kesalahan input"),
                val_bank: apl.createValidator("bill_save", "mdl_bill_bank", function () { return apl.func.emptyValueCheck(mdl_bill.tb_bank.value) }, "Kesalahan input"),

                kosongkan:function()
                {
                    mdl_bill.id = 0;
                    mdl_bill.tb_name.value = "";
                    mdl_bill.tb_no.value = "";
                    mdl_bill.tb_bank.value = "";                    
                    apl.func.validatorClear("bill_save");
                },
                tambah:function()
                {
                    if (mdl.vendor_id > 0)
                    {
                        mdl_bill.kosongkan();
                        mdl_bill.showAdd("Rekening - Tambah");
                    }                    
                },
                edit:function(bill_id)
                {
                    mdl_bill.kosongkan();
                    apl.func.showSinkMessage("Memuat data...");
                    activities.opr_vendor_bill_data(bill_id,
                        function (data)
                        {
                            mdl_bill.id = bill_id;
                            mdl_bill.tb_name.value = data.bill_name;
                            mdl_bill.tb_no.value = data.bill_no;
                            mdl_bill.tb_bank.value = data.bill_bank_name;
                            mdl_bill.showEdit("Rekening - Edit");
                            apl.func.hideSinkMessage();
                        }, apl.func.showError, ""
                    );
                },
                refresh:function()
                {
                    apl.func.hideSinkMessage();
                    mdl_bill.hide();
                    mdl.tbl_load();
                }
            }, 
            function ()
            {
                if(apl.func.validatorCheck("bill_save"))
                {
                    apl.func.showSinkMessage("Menyimpan data...");                    
                    activities.opr_vendor_bill_add(mdl.vendor_id, mdl_bill.tb_name.value, mdl_bill.tb_no.value, mdl_bill.tb_bank.value, mdl_bill.refresh, apl.func.showError, "");
                }
            }, 
            function () {
                if (apl.func.validatorCheck("bill_save")) {
                    apl.func.showSinkMessage("Menyimpan data...");
                    activities.opr_vendor_bill_edit(mdl_bill.id,mdl.vendor_id, mdl_bill.tb_name.value, mdl_bill.tb_no.value, mdl_bill.tb_bank.value, mdl_bill.refresh, apl.func.showError, "");
                }
            },
            function ()
            {
                if(confirm("Yakin akan dihapus?"))
                {
                    apl.func.showSinkMessage("Menghapus data...");
                    activities.opr_vendor_bill_delete(mdl_bill.id, mdl_bill.refresh, apl.func.showError, "");
                }
            }, "frm_page", "mdl"
        );
        
        var mdl_category = apl.createModal("mdl_category",
            {
                vendor_id: 0,                
                dl_category: apl.createDropdownWS("mdl_category_dl", activities.dl_par_vendor_category),
                dl_merk: apl.createDropdownWS("mdl_category_dlmerk", activities.dl_par_merk),
                
                tbl: apl.createTableWS.init("mdl_category_tbl", [
                    apl.createTableWS.column("", undefined, [apl.createTableWS.attribute("class", "edit")], function (data) { mdl_category_merk.edit(data.vendor_id, data.vendor_category_id, data.merk_id); }),
                    apl.createTableWS.column("merk_name")
                ]),
                tbl_load: function () {
                    activities.opr_vendor_category_merk_list(mdl.vendor_id,mdl_category.dl_category.value, function (arr_data) { mdl_category.tbl.load(arr_data); }, apl.func.showError, "");
                },
                
                val1: apl.createValidator("catsave", "mdl_category_dl", function () { return apl.func.emptyValueCheck(mdl_category.dl_category.value); }, "Invalid input"),
                val2: apl.createValidator("catsave", "mdl_category_dlmerk", function () { return apl.func.emptyValueCheck(mdl_category.dl_merk.value); }, "Invalid input"),
                

                tambah: function () {
                    mdl_category.vendor_id = mdl.vendor_id;
                    mdl_category.dl_category.value = "";
                    mdl_category.dl_category.disabled = false;

                    mdl_category.dl_merk.value = "";
                    mdl_category.dl_merk.Show();

                    mdl_category.tbl.Hide();
                    apl.func.validatorClear("catsave");

                    mdl_category.showAdd("Kategori- Tambah");
                },
                edit:function(vendor_id, vendor_category_id){
                    mdl_category.vendor_id = vendor_id;
                    mdl_category.dl_category.value = vendor_category_id;
                    apl.func.validatorClear("catsave");
                    apl.func.showSinkMessage("Load data");
                    mdl_category.dl_merk.Hide();
                    mdl_category.tbl.Show();
                    mdl_category.tbl_load();
                    activities.opr_vendor_category_data(vendor_id, vendor_category_id,
                        function (data) {
                            mdl_category.dl_category.disabled = true;
                            apl.func.hideSinkMessage();
                            mdl_category.showEdit("Kategori - Edit");
                        }, apl.func.showError, ""
                    );
                },
                close: function (hide_sts) {                    
                    apl.func.hideSinkMessage();
                    mdl.tbl_category_load();

                    if(hide_sts==undefined || hide_sts == true) mdl_category.hide();
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("catsave")) {
                    apl.func.showSinkMessage("Menyimpan data");
                    activities.opr_vendor_category_add(mdl_category.vendor_id, mdl_category.dl_category.value,mdl_category.dl_merk.value,
                        function () {
                            mdl_category.close(false);
                            mdl_category.edit(mdl.vendor_id, mdl_category.dl_category.value);                            
                        }, apl.func.showError, ""
                    );
                }
            },
            undefined,
            function ()
            {
                if (confirm("Yakin akan dihapus?")) {
                    apl.func.showSinkMessage("Menghapus data");
                    activities.opr_vendor_category_delete(mdl_category.vendor_id, mdl_category.dl_category.value, mdl_category.close, apl.func.showError,"");
                }
            }, "frm_page", "mdl"
        );
        
        var mdl_category_merk = apl.createModal("mdl_category_merk",
            {
                vendor_id: 0,
                vendor_category_id: 0,
                dl_merk: apl.createDropdownWS("mdl_category_merk_dl", activities.dl_par_merk),

                val1: apl.createValidator("merksave", "mdl_category_merk_dl", function () { return apl.func.emptyValueCheck(mdl_category_merk.dl_merk.value);}, "Invalid input"),

                tambah: function () {
                    mdl_category_merk.vendor_id = mdl.vendor_id;
                    mdl_category_merk.vendor_category_id = mdl_category.dl_category.value;
                    mdl_category_merk.dl_merk.value = "";
                    mdl_category_merk.dl_merk.disabled = false;
                    apl.func.validatorClear("merksave");
                    mdl_category_merk.showAdd("Merk - Tambah");
                },
                edit:function(vendor_id, vendor_category_id, merk_id){
                    mdl_category_merk.vendor_id = vendor_id;
                    mdl_category_merk.vendor_category_id = vendor_category_id;
                    mdl_category_merk.dl_merk.value = merk_id;
                    apl.func.validatorClear("merksave");
                    mdl_category_merk.showAdd("Edit- Tambah");
                    activities.opr_vendor_category_merk_data(vendor_id, vendor_category_id, merk_id,
                        function (data)
                        {
                            apl.func.hideSinkMessage();
                            mdl_category_merk.dl_merk.disabled = true;
                            mdl_category_merk.showEdit("Merk - Edit");
                        },
                        apl.func.showError, ""
                    );
                },
                close:function()
                {
                    mdl_category.tbl_load();
                    apl.func.hideSinkMessage();
                    mdl_category_merk.hide();
                }
            },
            function ()
            {
                if (apl.func.validatorCheck("merksave")) {
                    apl.func.showSinkMessage("Menambah data");
                    activities.opr_vendor_category_merk_add(mdl_category_merk.vendor_id, mdl_category_merk.vendor_category_id, mdl_category_merk.dl_merk.value, mdl_category_merk.close, apl.func.showError, "");
                }
            }, undefined, 
            function ()
            {
                if (confirm("Yakin akan dihapus?")) {
                    activities.opr_vendor_category_merk_delete(mdl_category_merk.vendor_id, mdl_category_merk.vendor_category_id, mdl_category_merk.dl_merk.value, mdl_category_merk.close, apl.func.showError, "");
                }
            }, "frm_page", "mdl_category"
        );
        

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
            document.list_select = mdl.select;
        });
    </script>
</asp:Content>

