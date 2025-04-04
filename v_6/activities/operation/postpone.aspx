﻿<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

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
            <td><input type="text" id="cari_device"/></td>
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>
    </table>
    
    <iframe class="frameList" id="cari_fr"></iframe>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var cari = {
            tb_device: apl.func.get("cari_device"),
            fl:apl.func.get("cari_fr"),
            load:function()
            {
                var device = escape(cari.tb_device.value);
                cari.fl.src = "postpone_list.aspx?device=" + device;
            },
            refresh:function()
            {
                cari.fl.contentWindow.document.refresh();
            }
        }
    </script>
</asp:Content>

