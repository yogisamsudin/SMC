<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<%@ Register Src="~/wuc/wuc_view_sales.ascx" TagPrefix="uc1" TagName="wuc_view_sales" %>


<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>

    <table class="formview">
        <tr>
            <th>No.Penawaran</th>
            <td>
                <input type="text" id="cari_no" value="RQSL519/SMC/I/24"/></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="buttonCari" onclick="cari.load();">Cari</div>
            </td>
        </tr>
    </table>

    <iframe class="frameList" id="cari_list"></iframe>
    <uc1:wuc_view_sales runat="server" ID="wuc_view_sales" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script>
        var cari = {
            tb_offerno: apl.func.get("cari_no"),
            fl_list: apl.func.get("cari_list"),

            load: function () {
                var no = window.escape(cari.tb_offerno.value);
                //"opr_sales_stsproses_list.aspx?no=" + no + "&cust=" + cust + "&status=" + status + "&fs=" + fs + "&branch=" + cari.dl_branch.value + "&ssm=" + ssm + "&displayadd=1&nopo=%";
                cari.fl_list.src = "isales_list.aspx?no=" + no + "&cust=%&status=%&fs=%&branch=%&ssm=%&nopo=%";
            },
            refresh: function () {
                cari.fl_list.contentWindow.document.refresh();
            }
        }

        document.list_edit = function(id)
        {
            alert(id);
        }
    </script>
</asp:Content>

