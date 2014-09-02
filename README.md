# Infinity Turtle

Automatic data pagination, infinite scrolling style. Check out the [demo](http://turtleguyy.github.io/infinity-turtle/demo/).

## Installation

First, you'll need jQuery, so go ahead and download and include him. Then, add `infinity.min.js` and `infinity.min.css` to your project.

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

You also have the ability to pass in a number of options along with your data. It would look something like this:

```javascript
var options = {};
new InfinityTurtle(data, options);
```

There are obviously defaults for every option, but they can all be overridden.

#### `container`

Defaults to `body`, can be any valid jQuery selector. This should be the element that will be containing the pages of data.

#### `loaderClass`

Defaults to an empty string. This is your own custom css class you want added to the loader.

#### `loaderColor`

Defaults to `#ddddff`, can be any valid CSS color value. This is the color of the loader symbol that shows up while preparing the next page of data.

#### `loaderSymbol`

Defaults to `infinity`, can also be `circle`. This is how you choose which of the two symbols you want to use for loading.

#### `loaderWidth`

Defaults to `2px`. This is the stroke width of the loader symbol.

#### `pageSize`

Defaults to `10`, can be any integer. This is the number of items you want per page.

#### `scrollDelay`

Defaults to `50`, can be any value in milliseconds. This is delay between scroll events before we check to see if we need to get the next page of data.

#### `scrollView`

Defaults to `body`, can be any valid jQuery selector. This should be the element that will be scrolling. This element *must* have a defined `height` and `overflow: auto` set.

## Coming Soon

* Ability to pass in a path to a loading image to use instead of one of the built in symbols.
* Ability to pass in a url to get the data from, instead of needing to have it all preloaded up front.

## Contributing

Fork the repo and make sure you have the latest version of node and npm installed. From the project directory, run the following lines. You'll need two terminal windows open to do it.

```
npm install -g coffee-script
coffee -o assets/ -cw src/
```

```
gem install sass
sass --watch src:assets
```
