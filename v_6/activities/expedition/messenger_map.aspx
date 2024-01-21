<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>
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

    <table>
        <tr>
            <td>
                <select id="cari_messenger"></select></td>
            <td>
                <input type="button" value="load" onclick="load_marker()" /></td>
        </tr>
    </table>

    <!--The div element for the map -->
    <div id="peta"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var map0;
        var arr_marker = [];
        const image = "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png";

        function initMap() {
            // The location of Uluru
            const hq_smc = { lat: -6.1334707, lng: 106.8290689 };
            // The map, centered at Uluru
            map0 = new google.maps.Map(document.getElementById("peta"), {
                zoom: 9,
                center: hq_smc,
            });
        }

        var ddl = apl.createDropdownWS("cari_messenger", activities.dl_messanger_geotag);

        function create_marker(d) {
            arr_messanger.push(new google.maps.Marker({
                position: { lat: parseFloat(d.latitude), lng: parseFloat(d.longitude) },
                map: map0,
                label: d.messanger_name + " - " + d.ping_time,
                icon: image
            }));

            alert(JSON.stringify(d));
        }

        function load_marker() {
            if (ddl.value != "") {
                arr_marker = [];
                activities.s_exp_messanger_geotag_list(ddl.value,
                    function (arr) {
                        arr.map(function (d) { create_marker(d); });
                    },
                    apl.func.showError, ""
                );
            }
        }
    </script>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6gIDzA2LtGhqeG_AOtZBXbWdqZSxESYA&callback=initMap&libraries=&v=weekly" async></script>
</asp:Content>

