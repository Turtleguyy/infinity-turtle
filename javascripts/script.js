$(function() {
  var url = 'https://api.whitehouse.gov/v1/petitions.jsonp';
  $.getJSON(url + '?limit=100&offset=0&callback=?', function(data) {
    var options = {
      container: 'section',
      scrollView: '.wrapper'
    };

    var turtle = new InfinityTurtle(data.results, options);
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
      var url   = '<p><a href="' + data[i].url + '">Read More ››</a></p>';
      var html  = '<div class="petition">' + title + body + url + '</div>';
      $('section').append(html);
    }

    if (done) {
      $('section').append('<p>All done.</p>');
    }
  };
});
