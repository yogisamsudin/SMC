<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page"%> 

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
            <th>Nama Customer</th>
            <td><input type="text" id="cari_name"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>
    
    <div id="mdl"> 
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Customer</th>
                    <td><input type="text" id="mdl_customer" size="50" maxlength="50"readonly="readonly"/></td>
                </tr>
                <tr>
                    <th>TGL. Transaksi Terakhir</th>
                    <td><input type="text" id="mdl_trx" size="50" maxlength="50" readonly="readonly"/></td>
                </tr>
                <tr>
                    <th>Current Marketing</th>
                    <td><input type="text" id="mdl_cur_marketing" size="50" maxlength="50"readonly="readonly"/></td>
                </tr>
                <tr>
                    <th>New Marketing</th>
                    <td><select id="mdl_new_marketing"/></td>
                </tr>
                
            </table>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Cancel"/>
            </div>
        </fieldset>
    </div>

    <div id="mdl_logo">
        <fieldset>
            <legend></legend>
            <iframe id="mdl_logo_if" style="border:none;width:100%;"></iframe>
            <div style="padding-top:5px;" class="button_panel">
                <input type="button" value="Save"/>
                <input type="button" value="Close"/>
            </div>
        </fieldset>        
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_name: apl.func.get("cari_name"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var name = escape(cari.tb_name.value);
                cari.fl.src = "pasif_customer_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                customer_id: 0,
                tb_customer: apl.func.get("mdl_customer"),
                tb_trx: apl.func.get("mdl_trx"),
                tb_cur_marketing: apl.func.get("mdl_cur_marketing"),
                ddl_new_marketing: apl.func.get("mdl_new_marketing"),
                val_1: apl.createValidator("save", "mdl_new_marketing", function () { return apl.func.emptyValueCheck(mdl.ddl_new_marketing.value); }, "Salah input"),
                kosongkan: function () {
                    mdl.customer_id = 0;
                    mdl.tb_customer.value = "";
                    mdl.tb_trx.value = "";
                    mdl.ddl_new_marketing.value = "";
                    mdl.tb_cur_marketing.value = "";
                    apl.func.validatorClear("save");
                    apl.func.hideSinkMessage();
                },
                edit: function (id) {
                    apl.func.showSinkMessage("Memuat Data");
                    mdl.kosongkan();
                    mdl.showEdit("Broker - Edit");
                    apl.func.hideSinkMessage();
                 },
                refresh: function () {
                    mdl.hide();
                    cari.fl_refresh();
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.opr_broker_add(mdl.tb_broker.value, mdl.tb_address.value, mdl.tb_title1.value, mdl.tb_title2.value, mdl.tb_title3.value, mdl.tb_initial.value, mdl.cb_tax.checked, mdl.tb_guaranti_term.getIntValue(), mdl.refresh, apl.func.showError, "");
                }
            },
            function () {
                if (apl.func.validatorCheck("save")) {
                    activities.opr_broker_edit(mdl.broker_id, mdl.tb_broker.value, mdl.tb_address.value, mdl.tb_title1.value, mdl.tb_title2.value, mdl.tb_title3.value, mdl.tb_initial.value, mdl.cb_tax.checked, mdl.tb_guaranti_term.getIntValue(), mdl.refresh, apl.func.showError, "");
                }
            },undefined,
            "frm_page", "cover_content"
        );

        var mdl_logo = apl.createModal("mdl_logo",
            {
                if_logo: apl.func.get("mdl_logo_if"),
                open: function (id, field_image) {
                    if (id != 0) {
                        mdl_logo.if_logo.src = "broker_logo.aspx?id=" + id + "&field=" + field_image;
                        mdl_logo.showEdit("Logo - Edit");
                    }
                }
            }, undefined,
            function () {
                mdl_logo.if_logo.contentDocument.submit();
                mdl_logo.hide();
            }, undefined, "frm_page", "mdl"
        );

        window.addEventListener("load", function () {
            cari.load();
            document.list_add = mdl.tambah;
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

