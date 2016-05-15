// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var coords_set = [];
var map;
var setExifData = function setExifData(newData) {
  document.getElementById("observation_image_exif").value = JSON.stringify(newData);
};

function initMap(){
  map = L.map('map', {'scrollWheelZoom' : false} ).setView([-37.8221645, 145.0382583], 13);
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);
};


function initMarkers(){
  coords_set.map(function(i){
    L.marker(i).addTo(map).bindPopup(i.toString()).openPopup();
  });

}

function getLocation() {
  var positionCB = function (position) {
    console.log("Position");
    var crd = position.coords;

    console.log('Your current position is:');
    console.log('Latitude : ' + crd.latitude);
    console.log('Longitude: ' + crd.longitude);
    console.log('More or less ' + crd.accuracy + ' meters.');

    console.dir(position);
    var positionObject = {
      'latitude':         position.coords.latitude,
      'longitude':        position.coords.longitude,
      'altitude':         position.coords.altitude,
      'accuracy':         position.coords.accuracy,
      'altitudeAccuracy': position.coords.altitudeAccuracy,
      'heading':          position.coords.heading,
      'speed':            position.coords.speed
    };

    //map.setView([position.coords.latitude, position.coords.longitude]);


    //var map = L.map('map').setView([position.coords.latitude, position.coords.longitude], 13);



    L.marker([position.coords.latitude, position.coords.longitude]).addTo(map);//.bindPopup("A pretty CSS3 popup.<br> Easily customizable.").openPopup();


    document.getElementById("observation_recorder_location_data").value = JSON.stringify(positionObject);
  };


  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(positionCB, null, {enableHighAccuracy: true});

  } else {
    console.log("NO GEO ENABLED")
  }
}

function closeAll(classNames) {
  var divs = document.getElementsByClassName("content");
  $.each(divs, function() {
    $(this).toggle(false);
  });
}

function toggleVisibility(id) {
  closeAll('content');
  $('#'+id).toggle();
}

$(document).ready(function(){
  closeAll('content');
});


$(document).ready(function(){
  var map = document.getElementById('map');
  if(!map) return;
  //$('#observation_attachment').change(imageChange);
  initMap();

  initMarkers();

  document.getElementById("observation_attachment").onchange = function(e) {
      getLocation();
      if (e.target.files[0]) {
      EXIF.getData(e.target.files[0], function() {
          //console.dir(EXIF.pretty(this));
          console.dir(this.exifdata);
          setExifData(this.exifdata);

      });
      //previewImage(this);
      } else {
        console.log('No file selected');
      }
  };
});
