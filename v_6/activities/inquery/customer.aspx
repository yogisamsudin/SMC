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
            <th>Nama</th>
            <td><input type="text" id="cari_name"/></td>
        </tr>
        <tr>
            <th>Marketing</th>
            <td><select id="cari_marketing"></select></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>                
    </table>

    <iframe class="frameList" id="cari_list"></iframe>

    <div class="modal" id="mdl">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>Nama</th>
                    <td><span id="mdl_name"></span></td>
                </tr>
                <tr>
                    <th>Alamat #1</th>
                    <td><span id="mdl_location"></span></td>
                </tr>
                <tr>
                    <th>Alamat #2</th>
                    <td><textarea id="mdl_address" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Telepon</th>
                    <td><span id="mdl_phone"></span></td>
                </tr>
                <tr>
                    <th>Fax</th>
                    <td><span id="mdl_fax"></span></td>
                </tr>
                <tr>
                    <th>NPWP</th>
                    <td><span id="mdl_npwp"></span></td>
                </tr>
                <tr>
                    <th>Marketing</th>
                    <td><span id="mdl_marketing"></span></td>
                </tr>
                <tr>
                    <th>Kontak</th>
                    <td>
                        <table class="gridView" id="mdl_tbl" style="min-width:800px">
                            <tr>                                
                                <th style="width:200px">Telp.</th>
                                <th>Nama</th>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div class="button_panel">                
                <input type="button" value="Close" />
            </div>
        </fieldset>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script>
        var cari = {
            tb_name: apl.func.get("cari_name"),
            dl_marketing:apl.createDropdownWS("cari_marketing",activities.dl_marketing_all_list),
            fl_list: apl.func.get("cari_list"),

            load: function () {
                var name = window.escape(cari.tb_name.value);
                var makt = window.escape(cari.dl_marketing.value);

                cari.fl_list.src = "customer_list.aspx?name=" + name + "&mark="+makt;
            },
            refresh: function () {
                cari.fl_list.contentWindow.document.refresh();
            }
        }

        var mdl = apl.createModal("mdl",
            {
                customer_id: 0,
                lb_name: apl.func.get("mdl_name"),                
                lb_location: apl.func.get("mdl_location"),
                tb_address: apl.func.get("mdl_address"),
                lb_phone: apl.func.get("mdl_phone"),
                lb_fax: apl.func.get("mdl_fax"),
                lb_npwp: apl.func.get("mdl_npwp"),
                lb_marketing: apl.func.get("mdl_marketing"),
                tbl: apl.createTableWS.init("mdl_tbl",
                    [
                        apl.createTableWS.column("contact_phone"),
                        apl.createTableWS.column("contact_name")                        
                    ]
                ),
                tbl_load:function(id){
                    activities.act_customer_contact_list(id, function (arrdata) { mdl.tbl.load(arrdata); }, apl.func.showError, "");
                },

                edit:function(id)
                {
                    mdl.customer_id = id;
                    mdl.tbl_load(id);
                    activities.act_customer_data(id,
                        function (data) {
                            mdl.lb_name.innerHTML = data.customer_name;                            
                            mdl.lb_location.innerHTML = data.customer_address_location;
                            mdl.tb_address.value = data.customer_address;
                            mdl.lb_phone.innerHTML = data.customer_phone;
                            mdl.lb_fax.innerHTML = data.customer_fax;
                            mdl.lb_npwp.innerHTML = data.npwp;
                            mdl.lb_marketing.innerHTML = data.marketing_id;
                            mdl.showEdit("Data - Info")
                        },
                        apl.func.showError, ""
                    );
                }
            },
            undefined, undefined, undefined, "frm_page", "cover_content"
        );

        document.list_edit = mdl.edit;
    </script>
</asp:Content>

