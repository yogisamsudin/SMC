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
            <th>Vendor</th>
            <td><input type="text" id="cari_name"/></td>
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

    <iframe class="frameList" id="cari_list"></iframe>

    <div id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Vendor</th>
                    <td><input type="text" id="mdl_vendor" size="100" maxlength="100" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td><input type="text" size="100" maxlength="100" id="mdl_contact"  disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><input type="text" size="100" maxlength="100" id="mdl_phone1"  disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Fax</th>
                    <td><input type="text" size="100" maxlength="100" id="mdl_phone2"  disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>Alamat #1</th>
                    <td>
                        <textarea id="mdl_address1" maxlength="300" style="float:left;"  disabled="disabled"></textarea>                        
                    </td>
                </tr>
                <tr>
                    <th>Alamat #2</th>
                    <td><textarea id="mdl_address2" maxlength="300" disabled="disabled" ></textarea></td>
                </tr>                                
                <tr>
                    <th>Rekening</th>
                    <td>
                        <table class="gridView" id="mdl_tbl" style="min-width:400px;">
                            <tr>                                
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
                                <th>Kategori</th>
                                <th>Merek</th>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script>
        var cari = {
            tb_name: apl.func.get("cari_name"),
            dl_category: apl.createDropdownWS("cari_category", activities.dl_par_vendor_category_all),
            dl_merk: apl.createDropdownWS("cari_merk", activities.dl_par_merk_all),
            fl_list: apl.func.get("cari_list"),

            load: function () {
                var name = window.escape(cari.tb_name.value);
                var catg = window.escape(cari.dl_category.value);
                var merk = window.escape(cari.dl_merk.value);

                cari.fl_list.src = "vendor_list.aspx?name=" + name + "&catg=" + catg + "&merk=" + merk;
            },
            refresh: function () {
                cari.fl_list.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                vendor_id: 0,
                location_id: 0,
                tb_vendor: apl.func.get("mdl_vendor"),
                tb_contact: apl.func.get("mdl_contact"),
                tb_phone1: apl.createNumeric("mdl_phone1", false),
                tb_phone2: apl.createNumeric("mdl_phone2", false),
                tb_address1: apl.func.get("mdl_address1"),
                tb_address2: apl.func.get("mdl_address2"),                
                tbl: apl.createTableWS.init("mdl_tbl", [                
                    apl.createTableWS.column("bill_name"),
                    apl.createTableWS.column("bill_no"),
                    apl.createTableWS.column("bill_bank_name")
                ]),
                tbl_load: function () {
                    activities.opr_vendor_bill_list(mdl.vendor_id, function (arr_data) { mdl.tbl.load(arr_data); }, apl.func.showError, "");
                },
                tbl_category: apl.createTableWS.init("mdl_tbl_category", [                    
                    apl.createTableWS.column("vendor_category_name"),
                    apl.createTableWS.column("merk_name")
                ]),
                tbl_category_load: function () {
                    activities.opr_vendor_category_merk_list_by_vendor(mdl.vendor_id, function (arr_data) { mdl.tbl_category.load(arr_data); }, apl.func.showError, "");
                },

                select_location: function () {
                    document.mdl_location.open();
                },
                tambah_location: function () {
                    mdl.location_id = 0;
                    mdl.tb_address1.disabled = false;
                    mdl.tb_address1.value = "";
                    mdl.tb_contact.value = "";
                    mdl.tb_phone1.value = "";
                    mdl.tb_phone2.value = "";
                    mdl.tbl.clearAllRow();
                    mdl.tbl_category.clearAllRow();
                },
                select: function (id) {
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
                    apl.func.validatorClear("save");

                    mdl.tbl.clearAllRow();
                    mdl.tbl_category.clearAllRow();
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
            undefined,
            undefined,
            undefined,
            "frm_page", "cover_content"
        );

        document.list_edit = mdl.edit;
    </script>
</asp:Content>

