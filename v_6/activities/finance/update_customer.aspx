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
            <th>Customer</th>
            <td><input type="text" id="cari_customer"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>

    <div class="modal" id="mdl">
        <fieldset>
            <legend>Pelanggan</legend>
            <table class="formview">
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_customer"></label></td>
                </tr>
                <tr>
                    <th>Alamat</th>
                    <td><input type="text" id="mdl_address" size="100" maxlength="300" disabled="disabled"/></td>
                </tr>
                <tr>
                    <th>NPWP</th>
                    <td><input type="text" id="mdl_npwp" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>ID.TKU</th>
                    <td><input type="text" id="mdl_tkuid" size="50" maxlength="50"/></td>
                </tr>
                <tr>
                    <th>Jns.ID.Pembeli</th>
                    <td><select id="mdl_jenisidpembeli"></select></td>
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
        var cari = {
            tb_customer: apl.func.get("cari_customer"),
            fl: apl.func.get("cari_fr"),
            load:function()
            {
                var name = escape(cari.tb_customer.value);
                cari.fl.src = "update_customer_list.aspx?name=" + name;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                customer_id:0,
                lb_customer: apl.func.get("mdl_customer"),
                tb_address: apl.func.get("mdl_address"),
                tb_npwp: apl.func.get("mdl_npwp"),
                tb_tkuid: apl.func.get("mdl_tkuid"),
                dl_jenisidpembeli:apl.createDropdownWS("mdl_jenisidpembeli",activities.dl_jenisidpembeli),
                edit:function(id)
                {
                    mdl.customer_id = id;
                    activities.act_customer_data(id,
                        function (data) {
                            mdl.lb_customer.innerHTML = data.customer_name;
                            mdl.tb_address.value = data.customer_address;
                            mdl.tb_npwp.value = data.npwp;
                            mdl.tb_tkuid.value = data.tkuid;
                            mdl.dl_jenisidpembeli.value = data.jenisidpembeli_id;
                            mdl.showEdit("Edit");
                        },
                        apl.func.showError, ""
                    );
                    
                }
            },
            undefined,
            function () {
                activities.act_customer_finance_update(mdl.customer_id, mdl.tb_npwp.value, mdl.tb_tkuid.value, mdl.dl_jenisidpembeli.value, function () { mdl.hide(); cari.fl_refresh(); }, apl.func.showError, "");
            },
            undefined, "frm_page", "cover_content"
        );

        window.addEventListener("load", function () {
            document.list_edit = mdl.edit;
        });
    </script>
</asp:Content>

