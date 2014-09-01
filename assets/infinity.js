// Generated by CoffeeScript 1.8.0
(function() {
  var InfinityTurtle;

  InfinityTurtle = (function() {
    InfinityTurtle.prototype.defaults = {
      container: 'body',
      loaderColor: '#ddddff',
      loaderSymbol: 'infinity',
      loaderURL: false,
      loaderWidth: '2px',
      pageSize: 2,
      scrollDelay: 50
    };

    function InfinityTurtle(data, options) {
      this.data = data;
      this._options = $.extend({}, this.defaults, options);
      this.view = $(this._options.container);
      this.promise = $.Deferred();
      this._page = 0;
      this.buildLoader();
      this.loadNextPage();
      if (!(this.data.length > this._options.pageSize)) {
        return;
      }
      this.view.on('scroll', $.proxy(this, '_onContainerScroll'));
    }

    InfinityTurtle.prototype.buildLoader = function() {
      var borderWidth;
      borderWidth = "border-width: " + this._options.loaderWidth + ";";
      return this._loader = (function() {
        switch (this._options.loaderSymbol) {
          case 'infinity':
            return this._buildInfinityLoader(borderWidth);
          default:
            return this._buildCircleLoader(borderWidth);
        }
      }).call(this);
    };

    InfinityTurtle.prototype._buildInfinityLoader = function(borderWidth) {
      var borders, classes, html;
      borders = "border-color: " + this._options.loaderColor + ";";
      classes = "class='infinite-loader " + this._options.loaderSymbol + "'";
      html = "<div " + classes + " style='" + borders + "'>\n  <div class='left' style='" + borderWidth + "' />\n  <div class='right' style='" + borderWidth + "' />\n</div>";
      return $(html);
    };

    InfinityTurtle.prototype._buildCircleLoader = function(borderWidth) {
      var borderLeft, borderTop, classes, inlineCSS;
      borderTop = "border-top-color: " + this._options.loaderColor + ";";
      borderLeft = "border-left-color: " + this._options.loaderColor + ";";
      inlineCSS = "style='" + borderWidth + " " + borderTop + " " + borderLeft + "'";
      classes = "class='infinite-loader " + this._options.loaderSymbol + "'";
      return $("<div " + classes + " " + inlineCSS + " />");
    };

    InfinityTurtle.prototype.checkScrollPosition = function() {
      var $lastChild, position;
      $lastChild = this.view.find(':last-child');
      position = $lastChild.offset().top + $lastChild.height();
      position -= this.view.offset().top;
      console.log(position, this.view.height());
      if (position <= this.view.height()) {
        this.view.append(this._loader);
        this.view.off('scroll');
        return this.loadNextPage();
      }
    };

    InfinityTurtle.prototype.loadNextPage = function() {
      var index, pageData;
      this._page += 1;
      this._loader.remove();
      index = this._options.pageSize * (this._page - 1);
      pageData = this.data.slice(index, this._options.pageSize + index);
      if (pageData.length < this._options.pageSize) {
        return this.promise.resolve(pageData);
      } else {
        this.promise.notify(pageData);
        return this.view.on('scroll', $.proxy(this, '_onContainerScroll'));
      }
    };

    InfinityTurtle.prototype._onContainerScroll = function() {
      clearTimeout(this._timeout);
      return this._timeout = setTimeout((function(_this) {
        return function() {
          return _this.checkScrollPosition();
        };
      })(this), this._options.scrollDelay);
    };

    return InfinityTurtle;

  })();

  window.InfinityTurtle = InfinityTurtle;

}).call(this);