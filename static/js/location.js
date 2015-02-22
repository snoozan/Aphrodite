var locationForm = function(input, trigger) {
  trigger.addEventListener("click", function() {
   navigator.geolocation.getCurrentPosition(function(position) {
     var str = position.coords.latitude.toString() + ", " + position.coords.longitude.toString();
     input.value = str;
     console.log(position);
   });
  });
};

window.addEventListener("DOMContentLoaded", function() {
  // init location form
  var input = document.querySelector('.location-box'),
   trigger = document.querySelector('.location-trigger');

  locationForm(input, trigger);
});
