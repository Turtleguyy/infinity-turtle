$(function() {
  var url = 'https://api.whitehouse.gov/v1/petitions.jsonp';
  $.getJSON(url + '?limit=100&offset=0&callback=?', function(data) {
    var turtle = new InfinityTurtle(data.results);
    turtle.promise.progress(function(data) {
      console.log('new page', data);
    });

    turtle.promise.done(function(data) {
      console.log('last page', data);
    });
  });
});
