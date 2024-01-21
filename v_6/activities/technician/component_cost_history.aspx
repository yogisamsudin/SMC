<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" theme="Page"%>

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
            <th>Part</th>
            <td><input type="text" id="cari_part" /></td>
        </tr>
        <tr>
            <th>Device</th>
            <td><input type="text" id="cari_device" /></td>
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
            ac_part: apl.create_auto_complete_text("cari_part", activities.ac_part),            
            ac_device: apl.create_auto_complete_text("cari_device", activities.ac_device),
            fl: apl.func.get("cari_fr"),
            load: function () {
                var id = cari.ac_part.id;
                var id2 = cari.ac_device.id;
                cari.fl.src = "component_cost_history_list.aspx?id=" + id+"&id2="+id2;
            }
        }

        window.addEventListener("load", function () { cari.ac_device.input.title = "Kosong untuk mencari semua"; });

     </script>   
</asp:Content>

