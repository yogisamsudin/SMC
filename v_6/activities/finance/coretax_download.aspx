<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    string pesan, apl_date;

    void Page_Load(object o, EventArgs e)
    {
        pesan = (Request.QueryString["pesan"]!=null)?Request.QueryString["pesan"].ToString():"";

        _test.App a = new _test.App(Request, Response);
        apl_date = a.cookieApplicationDateValue;
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
            <th>Tanggal Invoice</th>
            <td><input type="text" id="cari_invoicedate" size="10" readOnly value="<%= apl_date %>"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.process();">Download</div></td>
        </tr>
        <tr>
            <th>Note</th>
            <td>sistem akan mendownload data invoice penjualan dan service</td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var pesan = "<%= pesan %>";

        if (pesan != '') alert(pesan);

        var cari = {
            tb_invoicedate: apl.createCalender("cari_invoicedate"),
            val1: apl.createValidator("proses", "cari_invoicedate", function () { return apl.func.emptyValueCheck(cari.tb_invoicedate.value); }, "Invalid date"),
            process: function ()
            {
                if (apl.func.validatorCheck("proses"))
                {
                    activities.tmp_generate_cortex(cari.tb_invoicedate.value, function () { window.location = "download_coretax.ashx?tanggal="+cari.tb_invoicedate.value; }, apl.func.showError, "");
                }
            }
        }
    </script>
</asp:Content>

