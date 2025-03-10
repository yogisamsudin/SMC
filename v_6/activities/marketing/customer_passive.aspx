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
            <td><input type="text" id="cari_customer" size="35"/></td>            
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="fr_list"></iframe> 
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

        document.edit = undefined;
        document.tambah = undefined;
    </script>
</asp:Content>

