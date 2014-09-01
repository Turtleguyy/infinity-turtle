# Infinity Turtle

Automatic data pagination, infinite scrolling style.

## Installation

First, you'll need jQuery, so go ahead and download and include him. Then, add `infinity.js` and `infinity.css` to your project.

```html
<link rel="stylesheet" type="text/css" href="vendor/infinity.min.css">
<script type="text/javascript" src="vendor/infinity.min.js"></script>
```

## Basic Usage

InfinityTurtle takes an array of data, and paginates it for you. It also has a nifty little deferred you can use to keep track of what's going on.

```javascript
var data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
var turtle = new InfinityTurtle(data);
turtle.promise.progress(function(data) {
  // The given array is the next "page" worth of data.
  // Use it to render items into your container.
});

turtle.promise.done(function(data) {
  // The given array is the last "page" worth of data.
  // Use it to render items into your container.
});
```

## Configuration

# Contributing

Fork the repo and make sure you have the latest version of node and npm installed. From the project directory, run the following lines. You'll need two terminal windows open to do it.

```
npm install -g coffee-script
coffee -o assets/ -cw src/
gem install sass
sass --watch src:assets
```
