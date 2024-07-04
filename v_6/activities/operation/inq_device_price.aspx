<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/activities/operation/wuc_inq_sales.ascx" TagPrefix="uc1" TagName="wuc_inq_sales" %>




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
            <th>Device</th>
            <td><input type="text" id="cari_device" size="50"/></td>
        </tr>
        <tr>
            <th>Customer</th>
            <td><input type="text" id="cari_customer" size="50"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>

    <%--<uc1:wuc_sales_inq runat="server" ID="wuc_sales_inq" cover_id="cover_content" parent_id="frm_page" />--%>

    <uc1:wuc_inq_sales runat="server" ID="inq" cover_id="cover_content" parent_id="frm_page" func_select="document.list_edit" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_device: apl.func.get("cari_device"),
            tb_customer: apl.func.get("cari_customer"),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var device = escape(cari.tb_device.value);
                var customer = escape(cari.tb_customer.value);
                cari.fl.src = "inq_device_price_list.aspx?device=" + device + "&customer=" + customer;
            },
            fl_refresh: function () {
                cari.fl.contentWindow.document.refresh();
            }
        }

        //document.list_edit = function (id) { alert(id) };
    </script>
</asp:Content>

