$(function() {
  var call = $.get('https://api.whitehouse.gov/v1/petitions.json?limit=100');
  call.done(function(data) {
    var turtle = new InfinityTurtle(data.results);
    turtle.promise.progress(function(data) {
      console.log('new page', data);
    });

    turtle.promise.done(function(data) {
      console.log('last page', data);
    });
  });
});
