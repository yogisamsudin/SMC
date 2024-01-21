<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/komponen.js"></script>
    <style type="text/css">
        #peta {
            height: 600px;
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="~/activities/activities.asmx" />
        </Services>
    </asp:ScriptManager>  


    <input type="button" value="Refresh Marker" onclick="refresh_marker()" />
    <!--The div element for the map -->
    <div id="peta"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        
    </script>

    <script src="messenger_position.js" type="text/javascript"></script>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6gIDzA2LtGhqeG_AOtZBXbWdqZSxESYA&callback=initMap&libraries=&v=weekly" async></script>

</asp:Content>

