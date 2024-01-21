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
            <th>Device</th>
            <td><input type="text" id="cari_device" size="50"/></td>
        </tr>
        <tr>
            <th>Tipe Transaksi</th>
            <td><select id="cari_type"></select></td>
        </tr>
        <tr>
            <th>Vendor</th>
            <td><input type="text" id="cari_vendor" size="50"/></td>
        </tr>
        <tr>
            <th>SN</th>
            <td><input type="text" id="cari_sn"/></td>
        </tr>
        <tr>
            <th>Sts.Inventory</th>
            <td><input type="checkbox" id="cari_sts"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.fl.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fl"></iframe> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_device: apl.func.get("cari_device"),            
            dl_type: apl.createDropdownWS("cari_type", activities.dl_inventory_type_list_all),
            tb_vendor: apl.func.get("cari_vendor"),
            tb_sn: apl.func.get("cari_sn"),
            cb_status: apl.func.get("cari_sts"),
            fl: (function () {
                var _o = apl.func.get("cari_fl");
                _o.load = function ()
                {
                    var device = escape(cari.tb_device.value);
                    var type = escape(cari.dl_type.value);
                    var vendor = escape(cari.tb_vendor.value);
                    var sn= escape(cari.tb_sn.value);
                    var sts = cari.cb_status.checked;
                    this.src = "inventory_inq_list.aspx?vendor=" + vendor + "&sts=" + sts + "&sn=" + sn + "&type=" + type + "&device=" + device;                    
                },
                _o.refresh= function () {
                    this.contentWindow.document.refresh();                
                }
                return _o;
            })()
        }

        window.addEventListener("load", function () {
            cari.fl.load();
        });
    </script>
</asp:Content>

