var map0;
var marker1, marker2;
var arr_messanger = [];
const image = "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png";

// Initialize and add the map
function initMap() {
    // The location of Uluru
    const hq_smc = { lat: -6.1334707, lng: 106.8290689 };
    // The map, centered at Uluru
    map0 = new google.maps.Map(document.getElementById("peta"), {
        zoom: 9,
        center: hq_smc,
    });

    const marker0 = new google.maps.Marker({
        position: hq_smc,
        map: map0,
        label: "HQ SMC"
    });
}

function create_marker(d) {
    var newmarker = new google.maps.Marker({
        position: { lat: parseFloat(d.latitude), lng: parseFloat(d.longitude) },
        map: map0,
        label: d.messanger_name + " - " + d.ping_time,
        icon: image
    })

    arr_messanger.push({
        messanger_id: d.messanger_id,
        marker: newmarker
    });
}

function update_marker(ctr, d) {
    arr_messanger[ctr].marker.setPosition(new google.maps.LatLng(parseFloat(d.latitude), parseFloat(d.longitude)));
}

function check_marker(messanger_id) {
    var ctr = -1;
    for (var i in arr_messanger) {
        if (arr_messanger[i].messanger_id == messanger_id) ctr = i;
        break;
    }

    return ctr;
}

function refresh_marker() {
    if (arr_messanger.length == 0)
        activities.s_messanger_get_location(
            function (arr) {
                arr.map(function (d) {
                    create_marker(d);
                });
            },
            apl.func.showError, ""
        );
    else {
        activities.s_messanger_get_location(
            function (arr) {
                arr.map(function (d) {
                    var ctr = check_marker(d.messanger_id);
                    if (ctr == -1) create_marker(d); else update_marker(ctr, d);
                });
            },
            apl.func.showError, ""
        );
    }

}

