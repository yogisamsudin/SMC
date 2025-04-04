<%@ Page Title="" Language="C#" MasterPageFile="~/page.master"  theme="Page"%>

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
            <th>Marketing</th>
            <td><select id="cari_marketing"></select></td>
        </tr>
        <tr>
            <th>Pelanggan</th>
            <td><input type="text" id="cari_customer" size="35" value="%"/></td>            
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="fr_list"></iframe> 

    <div id="mdl" class="modal">
        <fieldset>
            <legend>Pelanggan</legend>
            <table class="formview">
                <tr>
                    <th style="width:100px;">Nama</th>
                    <td><input type="text" id="mdl_name" size="50" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Group</th>
                    <td><input type="text" id="mdl_group_customer" size="50" disabled="disabled"/></td>
                </tr>
                
                <tr>
                    <th style="width:100px;">Alamat #1</th>
                    <td><input type="text" id="mdl_address" size="100" maxlength="300" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Alamat #2</th>
                    <td><input type="text" id="mdl_address2" size="100" maxlength="300" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Telepon</th>
                    <td><input type="text" id="mdl_phone" size="15" maxlength="15" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Fax</th>
                    <td><input type="text" id="mdl_fax" size="15" maxlength="15" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Email</th>
                    <td><input type="text" id="mdl_email" size="150" maxlength="150" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">NPWP</th>
                    <td><input type="text" id="mdl_npwp" size="50" maxlength="50" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">Marketing</th>
                    <td><select id="mdl_marketing"></select></td>
                </tr>
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Close"/>
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari  = {
            tb_customer: apl.func.get("cari_customer"),
            ddl_marketing: apl.createDropdownWS("cari_marketing", activities.dl_marketing_all_list),
            fl:apl.func.get("fr_list"),

            load: function () {
                var name = escape(cari.tb_customer.value);
                var marketing = escape(cari.ddl_marketing.value);
                cari.fl.src = "customer_passive_list.aspx?name=" + name + "&marketing=" + marketing;
            },
            refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                customer_id: 0,
                tb_group_customer: apl.func.get("mdl_group_customer"),
                tb_name: apl.func.get("mdl_name"),
                tb_address: apl.func.get("mdl_address"),
                tb_address2: apl.func.get("mdl_address2"),
                tb_phone: apl.createNumeric("mdl_phone", false),
                tb_fax: apl.createNumeric("mdl_fax", false),
                tb_email: apl.func.get("mdl_email"),
                tb_npwp: apl.func.get("mdl_npwp"),
                dl_marketing: apl.createDropdownWS("mdl_marketing", activities.ddl_marketing),

                latitude: 0,
                longitude: 0,
                user_device_mandatory: false,
                address_id: 0,
                group_customer_id: 0,
                branch_id: 0,
                customer_address_location_id: 0,

                edit: function (customer_id) {
                    mdl.customer_id = customer_id;
                    //mdl.ac_group_customer.input.disabled = false;
                    activities.act_customer_data(customer_id,
                        function (data) {
                            mdl.tb_name.value = data.customer_name;
                            mdl.tb_group_customer.value = data.group_customer;
                            mdl.tb_address.value = data.customer_address_location;
                            //mdl.tb_address2.set_value(data.customer_address_location_id, data.customer_address_location);
                            //mdl.customer_address_location_id = data.customer_address_location_id;

                            mdl.tb_address2.value = data.customer_address;
                            mdl.tb_phone.value = data.customer_phone;
                            mdl.tb_fax.value = data.customer_fax;
                            mdl.tb_email.value = data.customer_email;
                            mdl.tb_npwp.value = data.npwp;
                            mdl.dl_marketing.value = data.marketing_id;

                            mdl.latitude = data.latitude;
                            mdl.longitude = data.longitude;
                            mdl.user_device_mandatory = data.user_device_mandatory;
                            mdl.address_id = data.customer_address_location_id;
                            mdl.group_customer_id = data.group_customer_id;
                            mdl.branch_id = data.branch_id;
                            mdl.customer_address_location_id = data.customer_address_location_id;

                            mdl.showEdit("Customer - Edit");


                        }, apl.func.showError, ""
                    );
                },
                refresh: function () {
                    mdl.hide();
                    fl.fl.refresh();
                }
            },
            undefined,
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.act_customer_edit(mdl.customer_id, mdl.tb_name.value, mdl.tb_address.value, mdl.tb_address2.value, mdl.tb_phone.value, mdl.tb_fax.value, mdl.tb_email.value, mdl.dl_marketing.value, mdl.address_id, mdl.group_customer_id, mdl.customer_address_location_id, mdl.tb_npwp.value, mdl.latitude, mdl.longitude, mdl.branch_id, mdl.user_device_mandatory, mdl.refresh, apl.func.showError, "");
                }
            },
            undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            document.list_edit = mdl.edit;
        });
        
    </script>
</asp:Content>

