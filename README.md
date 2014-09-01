# Infinity Turtle

Automatic data pagination, infinite scrolling style.

## Usage

First, make sure you've got jQuery included in your project, then include the
infinity turtle files.

```html
<script type="text/javascript" src="assets/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="assets/infinity.js"></script>
```

Then...

```javascript
new InfinityTurtle
```

# To contribute

clone the repo
cd into the project
make sure you have the latest version of node and npm installed
run `npm install -g coffee-script`
run `coffee -o assets/ -cw src/`
open up a new terminal window
run `gem install sass`
run `sass --watch src:assets`
