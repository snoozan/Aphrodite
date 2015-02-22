// IFEE
(function() {

  function getData() {
    // AJAX our API to get the data
    var request = new XMLHttpRequest();
    var url = "";

    request.onreadystatechange = function() {
      if (request.readyState == 4 && request.status == 200) {
          var data = JSON.parse(xmlhttp.responseText);
      }
      //else if (request.status == 00) {
        // add error handling later you lazy mofo
      //}
    }
    request.open("GET", url, true);
    request.send();

    return data;
  }

  // Get the parameters that we submitted on the form
  function getParams() {
      function decode(s) {
          return decodeURIComponent(s).split(/\+/).join(" ");
      }

      var params = {};

      document.location.search.replace(
          /\??(?:([^=]+)=([^&]*)&?)/g,
          function () {
              params[decode(arguments[1])] = decode(arguments[2]);
          });

      return params;
  }


  // Document ready
  window.addEventListener("DOMContentLoaded", function() {
    // Compile Handlebars template
    var template = document.querySelector("#entry-template").innerHTML;
    var compiledTemplate = Handlebars.compile(template);
    var result = compiledTemplate();

    var container = document.querySelector(".container");
    container.innerHTML = result;
  });
}());
