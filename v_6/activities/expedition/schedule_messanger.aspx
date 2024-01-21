<%@ Page Title="" Language="C#" MasterPageFile="~/page.master" Theme="Page" %>

<script runat="server">
    public _test.App a;

    void Page_Load(object o, EventArgs e)
    {
        a = new _test.App(Request, Response);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../../js/Komponen.js"></script>   
    <style>
        .pilih
        {
            cursor:pointer;            
            width:100%;
        }
        .pilih:hover
        {
            background-color:lightgray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <asp:ScriptManager runat="server" ID="sm">
        <Services>
            <asp:ServiceReference Path="../activities.asmx" />
        </Services>
    </asp:ScriptManager>  

    <table class="formview">
        <tr>
            <th style="width:100px;">Tanggal</th>
            <td><input type="text" id="cari_date_list" size="10" maxlength="10" style="float:left;" value="<%= a.cookieApplicationDateValue %>"/></td> 
        </tr>
        <tr>
            <th></th>
            <td><div class="buttonCari" onclick="cari.load();">Cari</div></td>
        </tr>        
    </table>

    <table class="gridView">
        <tr>
            <td><div id="map"  style="width:800px;height:400px;"></div></td>
            <td style="vertical-align:top;">
                <div style="height:400px;overflow:scroll;">
                    <table class="gridView" id="tbl_marker">
                      <tr>
                            <th style="width:25px">No.</th>
                            <th>Pelanggan</th>
                            <th>Kurir</th>
                        </tr>  
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td><span id="info_jarak"></span></td>
            <td></td>
        </tr>
    </table> 
    
    <div id="mdl" class="modal">
        <fieldset>
            <legend></legend>
            <table class="formview">
                <tr>
                    <th>No. Jadwal</th>
                    <td><span id="mdl_schedule_id"></span></td>
                </tr>
                <tr>
                    <th>Customer</th>
                    <td><label id="mdl_customer"></label></td>
                </tr>
                <tr>
                    <th>Alamat</th>
                    <td><textarea id="mdl_address" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Ambil Barang</th>
                    <td><textarea id="mdl_note_ambil" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Kirim Barang</th>
                    <td><textarea id="mdl_note_kirim" readonly="readonly"></textarea></td>
                </tr>
                <tr>
                    <th>Kurir</th>
                    <td><select id="mdl_messanger"></select></td>
                </tr>
            </table>
            <div class="button_panel">
                <input type="button" value="Save" />
                <input type="button" value="Cancel" />
            </div>
        </fieldset>
    </div>   

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var data_marker;
                
        var cari = {
            dl_date: apl.createCalender("cari_date_list"),            
            load:function()
            {
                activities.xml_exp_schedule_map_list(cari.dl_date.value,
                    function (arrData) {
                        tbl.load(arrData);
                        data_marker = arrData;
                        messanger = undefined;
                        messanger_id = undefined;
                        window.parent.document.initmap = initmap;
                        window.parent.document.initmap();
                    }, apl.func.showError, ""
                );
            }
        }
    </script>

    <script type="text/javascript">
        var ggl = window.parent.google;
        var arr_marker = [];
        var latitude = sessionStorage.getItem("lat");
        var longitude = sessionStorage.getItem("lng");
        var latlng = new ggl.maps.LatLng(latitude, longitude);
        var default_zoom = 10;
        var map = new ggl.maps.Map(document.getElementById('map'), {
            zoom: default_zoom,
            center: latlng
        });
        map.addListener('rightclick', function (event) { map.setZoom(default_zoom); });
        var center_marker = new ggl.maps.Marker({
            position: latlng,
            title: 'HQ',
            map: map
        });
        var directionsService = new ggl.maps.DirectionsService;
        var directionsDisplay = new ggl.maps.DirectionsRenderer({
            //draggable: true,
            map: map
        });
        var waypts;
        var messanger;
        var messanger_id;
        var tbl = document.getElementById("tbl_marker");
        tbl.load=function(arrData)
        {
            var _t = this;
            //for (var i = 1; i > _t.rows.length; i--) {_t.deleteRow(i);}
            apl.func.table.clearRowAll(_t, 1);
            
            for (var i = 0; i < arrData.length; i++)
            {
                var span1 = document.createElement("div");
                span1.innerHTML = i + 1;
                span1.latitude = arrData[i].latitude;
                span1.longitude = arrData[i].longitude
                span1.onclick=function()
                {
                    map.setZoom(18);
                    map.setCenter(new ggl.maps.LatLng(this.latitude,this.longitude));
                }
                var span2 = document.createElement("div");
                span2.innerHTML = arrData[i].customer_name;
                span2.className = "pilih";
                span2.address_id = arrData[i].address_id;
                span2.customer_name = arrData[i].customer_name;
                span2.address_location= arrData[i].address_location;
                span2.address = arrData[i].address;
                span2.schedule_id = arrData[i].schedule_id;
                span2.onclick = function ()
                {
                    mdl.edit(this.address_id, this.customer_name, this.address_location, this.address, cari.dl_date.value, this.schedule_id);
                }
                var span3 = document.createElement("div");
                span3.innerHTML = arrData[i].messanger_name;
                span3.className = "pilih";
                span3.messanger_id = arrData[i].messanger_id;
                span3.onclick = function ()
                {
                    messanger = this.innerHTML;
                    messanger_id = this.messanger_id;
                    window.parent.document.initmap = initmap;
                    window.parent.document.initmap();

                }
                
                apl.func.table.insertRow(_t, [apl.func.table.insertCell([span1]), apl.func.table.insertCell([span2]), apl.func.table.insertCell([span3])]);
            }
        }
        
        var mdl = apl.createModal("mdl",
            {
                schedule_id: 0,
                lb_id: apl.func.get("mdl_schedule_id"),
                lb_customer: apl.func.get("mdl_customer"),                
                tb_address: apl.func.get("mdl_address"),
                tb_note_ambil: apl.func.get("mdl_note_ambil"),
                tb_note_kirim: apl.func.get("mdl_note_kirim"),
                dl_messanger: apl.createDropdownWS("mdl_messanger", activities.dl_messanger, undefined, undefined, true),
                edit:function(address_id, customer_name, address_location, address,tanggal,schedule_id)
                {
                    mdl.lb_id.innerHTML = schedule_id;
                    mdl.schedule_id = schedule_id;
                    mdl.lb_customer.innerHTML = customer_name;                    
                    mdl.tb_address.value = address_location + ' ' + address;
                    mdl.dl_messanger.setValue("0");
                    activities.xml_exp_schedule_map_detail(schedule_id,
                        function (data) {
                            mdl.tb_note_ambil.value = data.note_ambil;
                            mdl.tb_note_kirim.value = data.note_kirim;                            
                            mdl.dl_messanger.setValue(data.messanger_id);
                            mdl.showEdit("Edit - Set Kurir");
                        }, apl.func.showError, ""
                    );

                    
                }
            }, undefined, 
            function ()
            {
                apl.func.showSinkMessage("Menyimpan");
                activities.exp_schedule_map_update(mdl.schedule_id, mdl.dl_messanger.value,
                    function () {
                        mdl.hide();
                        apl.func.hideSinkMessage();
                        cari.load();
                    }, apl.func.showError, ""
                );
            }, undefined, "frm_page", "cover_content");

        var initmap = function ()
        {
            //clear marker            
            for (var ctr = 0; ctr < arr_marker.length; ctr++)
            {
                arr_marker[ctr].setMap(null);
            }
            arr_marker = [];

            var shape = {
                coords: [1, 1, 1, 20, 18, 20, 18, 1],
                type: 'poly'
            };

            var dm,image = {                
                url: 'http://maps.gstatic.com/mapfiles/ms2/micons/grn-pushpin.png',
                size: new ggl.maps.Size(40, 32),
                origin: new ggl.maps.Point(0, 0),                
                anchor: new ggl.maps.Point(10, 32)                
            };

            for (var ctr = 0; ctr < data_marker.length; ctr++)
            {
                if (data_marker[ctr].messanger_name == messanger) { dm = image; } else { dm = undefined; }                    

                var marker = new ggl.maps.Marker({
                    position: new ggl.maps.LatLng(data_marker[ctr].latitude, data_marker[ctr].longitude),
                    title: data_marker[ctr].customer_name,
                    label: (ctr + 1).toString(),                    
                    address_id:data_marker[ctr].address_id, 
                    customer_name:data_marker[ctr].customer_name, 
                    address_location:data_marker[ctr].address_location, 
                    address: data_marker[ctr].address,
                    tanggal: cari.dl_date.value,
                    schedule_id: data_marker[ctr].schedule_id,
                    map: map,
                    //shape: shape,
                    icon: dm

                });

                ggl.maps.event.addListener(marker, 'rightclick', function () {
                    map.setZoom(18);
                    map.setCenter(this.getPosition());
                });

                ggl.maps.event.addListener(marker, 'click', function () {
                    mdl.edit(this.address_id, this.customer_name, this.address_location, this.address, this.tanggal, this.schedule_id);                    
                });

                arr_marker.push(marker);                
            }

            //render_direction(messanger_id);

            
        };
        
        function render_direction(messanger_id)
        {
            if (messanger_id == undefined) {
                directionsDisplay.setMap(null);
                return;
            }
            directionsDisplay.setMap(map);
            activities.exp_schedule_map_matrix_distance_messanger(cari.dl_date.value, messanger_id,
                function (arr_data)
                {
                    
                    waypts = [];
                    for (var i = 0; i < arr_data.length; i++)
                    {
                        waypts.push({
                            //location: parseFloat(arr_data[i].latitude) + ',' + parseFloat(arr_data[i].longitude),
                            location: new ggl.maps.LatLng(arr_data[i].latitude, arr_data[i].longitude),
                            stopover: false
                        });
                    }

                    directionsService.route({
                        origin: latitude + ',' + longitude,
                        destination: latitude + ',' + longitude,
                        travelMode: 'DRIVING',
                        waypoints: waypts,
                        optimizeWaypoints: true,
                        avoidTolls: true
                    }, function (response, status) {
                        if (status === 'OK') {
                            directionsDisplay.setDirections(response);
                        } else {
                            window.alert('Directions request failed due to ' + status);
                        }
                    });

                    directionsDisplay.addListener('directions_changed', function () { computeTotalDistance(directionsDisplay.getDirections()); });
                }, apl.func.showError, ""
            );            
            
        }

        function computeTotalDistance(result) {
            var total = 0;
            var myroute = result.routes[0];
            
            for (var i = 0; i < myroute.legs.length; i++) {
                total += myroute.legs[i].distance.value;
            }
            total = total / 1000;
            document.getElementById('info_jarak').innerHTML = total + ' km';
        }

    </script>
    
</asp:Content>

