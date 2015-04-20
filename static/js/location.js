<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script>

var eventposted=0;

$(document).ready(function(){
  $('input.button').click(function() {
    window.setInterval(foo, 100);
  });
});

function foo(){
  if(($(".form-submission-text").is(':visible')) && (eventposted==0)){
    window.location = "/c";
    eventposted=1;
  }
}

</script>
