$(function() {
  var url = 'https://api.whitehouse.gov/v1/petitions.jsonp';
  $.getJSON(url + '?limit=100&offset=0&callback=?', function(data) {
    var turtle = new InfinityTurtle(data.results);
    turtle.promise.progress(function(data) {
      renderData(data);
    });

    turtle.promise.done(function(data) {
      renderData(data, true);
    });
  });

  var renderData = function(data, done) {
    for (var i = 0; i < data.length; i++) {
      var title = '<h2>' + data[i].title + '</h2>';
      var body  = '<p>' + data[i].body + '</p>';
      var html  = '<div class="petition">' + title + body + '</div>';
      $('section').append(html);
    }

    if (done) {
      $('section').append('<p>All done.</p>');
    }
  };
});
