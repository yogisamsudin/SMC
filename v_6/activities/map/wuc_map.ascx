<%@ Control Language="C#" ClassName="wuc_map" %>

<script runat="server">
    public string func_get_geotag { set; get; }
    public string key_api_map;

    void Page_Load(object o, EventArgs e)
    {
        ClientIDMode = System.Web.UI.ClientIDMode.Static;
        key_api_map = System.Configuration.ConfigurationManager.AppSettings["key_api_map"].ToString();
    }
</script>

<style>
    .pac-container
    {
        background-color:white;
        border:thin solid gray;
        cursor:pointer;
        overflow: hidden;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
    }
    .pac-icon
    {
        
    }
    .pac-item
    {
        cursor: default;
        padding: 0 4px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        line-height: 30px;
        text-align: left;
        font-size:small;
    }
    .pac-item:hover,.pac-item-selected
    {
        background-color:gray;
    }
    .pac-matched
    {
        font-weight:bold;
    }
</style>

<input type="text" size="70" style="margin-top:10px;" id="<%= ClientID %>_address" value="<%= key_api_map %>"/>
<div style="width:800px;height:400px;" id="<%= ClientID %>_map"></div>

<script type="text/javascript">
    var ggl = window.parent.google;
            
    document["<%= ClientID %>_myLatLng"] = {};
    document["<%= ClientID %>_map"] = {};    
    document["<%= ClientID %>_marker"] = {};
    document["<%= ClientID %>_initmap"] = function () {
        var o = document["<%= ClientID %>"];
        var lat = o.latitude;
        var lng = o.longitude;
        var def_zoom = 17;

        if (o.latitude + o.longitude == "") {
            lat = sessionStorage.getItem("lat");
            lng = sessionStorage.getItem("lng");
        }

        document["<%= ClientID %>_myLatLng"] = new ggl.maps.LatLng(lat, lng);

            document["<%= ClientID %>_map"] = new ggl.maps.Map(o.dv_map, {
            zoom: def_zoom,
            center: document["<%= ClientID %>_myLatLng"],
                streetViewControl: false,
                fullscreenControl: false
            });

        document["<%= ClientID %>_marker"] = new ggl.maps.Marker({
            position: document["<%= ClientID %>_myLatLng"],
                map: document["<%= ClientID %>_map"]
                //,title: 'Surya Mandiri Computer',
            });

        ggl.maps.event.addListener(document["<%= ClientID %>_map"], 'click', function (event) {
            o.latitude = event.latLng.lat();
            o.longitude = event.latLng.lng();

            document["<%= ClientID %>_marker"].setPosition(new ggl.maps.LatLng(o.latitude, o.longitude));
                document["<%= ClientID %>_marker"].setVisible(true);
            });

        var input = (o.tb_address);

        document["<%= ClientID %>_map"].controls[ggl.maps.ControlPosition.TOP_LEFT].push(input);

        var autocomplete = new ggl.maps.places.Autocomplete(input);
        autocomplete.bindTo('bounds', document["<%= ClientID %>_map"]);
        autocomplete.setTypes('address');
        

        autocomplete.addListener('place_changed', function () {

            document["<%= ClientID %>_marker"].setVisible(false);
            var place = autocomplete.getPlace();
            if (!place.geometry) {
                window.alert("No details available for input: '" + place.name + "'");
                return;
            }

            if (place.geometry.viewport) {
                document["<%= ClientID %>_map"].fitBounds(place.geometry.viewport);
            } else {
                document["<%= ClientID %>_map"].setCenter(place.geometry.location);
                document["<%= ClientID %>_map"].setZoom(20);  // Why 17? Because it looks good.                        
            }

            document["<%= ClientID %>_marker"].setPosition(place.geometry.location);
            document["<%= ClientID %>_marker"].setVisible(true);

            o.latitude = place.geometry.location.lat();
            o.longitude = place.geometry.location.lng();

        });
    }

    window.addEventListener("load", function () {
        
        var o = document["<%= ClientID %>"] =
        {
            tb_address: apl.func.get("<%= ClientID %>_address"),
            dv_map: apl.func.get("<%= ClientID %>_map"),
            latitude: '',
            longitude: '',
            open:function(lat,lng)
            {
                o.latitude = lat;
                o.longitude = lng;
                o.tb_address.value = "";                
                window.parent.document.initmap = document["<%= ClientID %>_initmap"];
                window.parent.document.initmap();
            }
        };
    });
</script>

<!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6gIDzA2LtGhqeG_AOtZBXbWdqZSxESYA&callback=<%= ClientID %>initmap&libraries=places"></script>-->

<!--<script src="https://maps.googleapis.com/maps/api/js?key=<%= key_api_map %>&callback=<%= ClientID %>initmap&libraries=places"></script>-->