// FUNCTIONS FOR USER STATS UPDATING

// chrome and other browsers don't start with focus, firefox does.
var initTimer;
var timer;

// initial run of stats before timer kicks in
lets_count('current_sessions', 'person');
lets_count('feelings_today', 'cloud');

initTimer = setInterval(function(){
                  lets_count('current_sessions', 'person');
                  lets_count('feelings_today', 'cloud');
                }, 20000);

$(window).on("blur focus", function(e) {
  var prevType = $(this).data("prevType");

  if (prevType != e.type) {   //  reduce double fire issues
    switch (e.type) {
      case "blur":
        clearInterval(initTimer);
        clearInterval(timer);
      break;
      case "focus":
        clearInterval(initTimer);
        timer = setInterval(function(){
                  lets_count('current_sessions', 'person');
                  lets_count('feelings_today', 'cloud');
                }, 20000);
      break;
    }
  }
  $(this).data("prevType", e.type);
})

function lets_count(path, icon){
  $.ajax({
    url: "/stats/"+path,
    method: "GET",
    data: {},
    dataType: "json",
    success: function ( msg ) {
      update_count(msg.count, icon);
    }
  });
 }

// check if counts have updated or not

function update_count(count, id){
  var oldCount = +$("#"+id +' span').text();
  if (count !== oldCount){
    $("#"+id +' span').text(count);
  }
}