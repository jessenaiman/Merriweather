var map, infoWindow, locationSelect, marker;
    var ne_lat;
    var ne_lng;
    var nw_lat;
    var nw_lng;
    var markers = [];

$(document).ready(function() { 
    $("#search").click(function(){
        searchLocations();
    });

  if($('#map').length){

    
    
    function initialize() {
        var options = {
            mapTypeId: 'roadmap'
        };
        map = new google.maps.Map(document.getElementById("map"), options);
        infoWindow = new google.maps.InfoWindow();

        locationSelect = document.getElementById("locationSelect");
        locationSelect.onchange = function () {
           var markerNum = locationSelect.options[locationSelect.selectedIndex].value;
           if (markerNum != "none") {
              google.maps.event.trigger(markers[markerNum], 'click');
          }
        };

        findMe();
    }
    
    function detectBrowser() {
      var useragent = navigator.userAgent;
      var mapdiv = document.getElementById("map");

      if (useragent.indexOf('iPhone') != -1 || useragent.indexOf('Android') != -1) {
          mapdiv.style.width = '100%';
          mapdiv.style.height = '100%';
      } else {
          mapdiv.style.width = '600px';
          mapdiv.style.height = '800px';
      }
    }

    initialize();
    detectBrowser();
  };

  
});

  function findMe() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(positionSuccess)
        }
        else {
            alert('The browser does not support geolocation');
        }
    }

    function searchLocations() {
        var address = $("#addressInput").val();
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({ address: address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                searchLocationsNear(results[0].geometry.location);
            } else {
                alert(address + ' not found');
            }
        });
    }

    function searchLocationsGeo(geo){
      var geocoder = new google.maps.Geocoder();
      var latlng = new google.maps.LatLng(geo.coords.latitude, geo.coords.longitude);
      geocoder.geocode({ latLng: latlng }, function (results, status) {
        searchLocationsNear(results[0].geometry.location);
      });
    }

    function positionSuccess(position) {
        // Centre the map on the new location
        var coords = position.coords || position.coordinate || position;
        var latLng = new google.maps.LatLng(coords.latitude, coords.longitude);
        map.setCenter(latLng);
        map.setZoom(12);
        var marker = new google.maps.Marker({
	        map: map,
	        position: latLng,
	        title: 'Why, there you are!'
        });
       //setTimeout('searchLocationsNear()', 2000);
      }

function clearLocations() {
        infoWindow.close();
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers.length = 0;

        locationSelect.innerHTML = "";
        var option = document.createElement("option");
        option.value = "none";
        option.innerHTML = "See all results:";
        locationSelect.appendChild(option);
    }
    
    function getBounds(){
        ne_lat = map.getBounds().getNorthEast().lat();
        ne_lng = map.getBounds().getNorthEast().lng();
        nw_lat = map.getBounds().getSouthWest().lat();
        nw_lng = map.getBounds().getSouthWest().lng();
    }

    function createMarker(latlng, name, address, phone) {
        var html = "<b>" + name + "</b> <br/>" + address + "<br />" + phone;
        var marker = new google.maps.Marker({
            map: map,
            position: latlng
        });
        google.maps.event.addListener(marker, 'click', function () {
            infoWindow.setContent(html);
            infoWindow.open(map, marker);
        });
        markers.push(marker);
    }

    function createOption(name, distance, num) {
        var option = document.createElement("option");
        option.value = num;
        option.innerHTML = name + "(" + distance.toFixed(1) + ")";
        locationSelect.appendChild(option);
    }

function searchLocationsNear() {
        clearLocations();

        var radius = 10;//getRadius(); //document.getElementById('radiusSelect').value;
        getBounds();
        var searchUrl = 'http://192.168.0.111:3000/locator.json?ne_lat=' + ne_lat + '&ne_lng=' + ne_lng + '&nw_lat=' + nw_lat + '&nw_lng=' + nw_lng +'&radius=' + radius;
        $.get(searchUrl, function (data) {
            var markerNodes = eval(data);
            var bounds = new google.maps.LatLngBounds();
            for (var i = 0; i < markerNodes.length; i++) {
                var name = markerNodes[i].name;
                var address = markerNodes[i].address;
                var distance = parseFloat(markerNodes[i].distance);
                var phone = markerNodes[i].phone;
                var latlng = new google.maps.LatLng(
                  parseFloat(markerNodes[i].lat),
                  parseFloat(markerNodes[i].lng));
                    createOption(name, distance, i);
                    createMarker(latlng, name, address, phone);
                    bounds.extend(latlng);
            }
            map.fitBounds(bounds);
            locationSelect.style.visibility = "visible";
            locationSelect.onchange = function () {
                var markerNum = locationSelect.options[locationSelect.selectedIndex].value;
                google.maps.event.trigger(markers[markerNum], 'click');
            };
        });
        //map.setCenter(center);
    }
