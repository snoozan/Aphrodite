// IFEE
(function() {

  // template module handler
  var resultsLoader = {
    "template": undefined,
    "container": undefined,
    "getParams": function() {   // Get the parameters that we submitted on the form
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
    },
    "getData": function(params) {   // AJAX our API to get the data
      var request = new XMLHttpRequest();
      var url = "";

      request.onreadystatechange = function() {
        if (request.readyState == 4 && request.status == 200) {
            var data = JSON.parse(xmlhttp.responseText);
        }
        // else if (request.status == 00) {
          // add error handling later you lazy mofo
        // }
      }
      request.open("GET", url, true);
      request.send();
      
      data.query = params;
      return data;
    },
    "render": function(data) {
      var compiledTemplate = Handlebars.compile(this.template);
      var result = compiledTemplate(data);
      this.container.innerHTML = result;
    },
    "init": function() {
      // Get the location query
      var location = this.getParams().location;

      // Get the data
      var data = this.getData(location);

      // Render the template
      this.render(data);
    }
  }

  // Document ready
  window.addEventListener("DOMContentLoaded", function() {
    // attach templating DOM nodes
    resultsLoader.container = document.querySelector(".container");
    resultsLoader.template = document.querySelector("#entry-template").innerHTML;
    // init the templating
    resultsLoader.init();
  });
}());
