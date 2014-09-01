// Generated by CoffeeScript 1.8.0
(function() {
  var InfinityTurtle;

  InfinityTurtle = (function() {
    InfinityTurtle.prototype.defaults = {
      container: 'body',
      loaderColor: '#ddddff',
      loaderClass: '',
      loaderSymbol: 'infinity',
      loaderWidth: '2px',
      pageSize: 10,
      scrollDelay: 50,
      scrollView: 'body'
    };

    function InfinityTurtle(data, options) {
      this.data = data;
      this._options = $.extend({}, this.defaults, options);
      this.view = $(this._options.container);
      this.promise = $.Deferred();
      this._page = 0;
      this._buildLoader();
      this._loadNextPage(0);
    }

    InfinityTurtle.prototype.hideLoader = function(fade) {
      if (fade == null) {
        fade = false;
      }
      if (fade) {
        return this._loader.fadeOut();
      } else {
        return this._loader.hide();
      }
    };

    InfinityTurtle.prototype._buildLoader = function() {
      var borderWidth, classes;
      classes = "" + this._options.loaderSymbol + " " + this._options.loaderClass;
      classes = "class='infinite-loader " + classes + "'";
      borderWidth = "border-width: " + this._options.loaderWidth + ";";
      return this._loader = (function() {
        switch (this._options.loaderSymbol) {
          case 'infinity':
            return this._buildInfinityLoader(borderWidth, classes);
          default:
            return this._buildCircleLoader(borderWidth);
        }
      }).call(this);
    };

    InfinityTurtle.prototype._buildInfinityLoader = function(borderWidth, classes) {
      var borders, html;
      borders = "border-color: " + this._options.loaderColor + ";";
      html = "<div " + classes + " style='" + borders + "'>\n  <div class='left' style='" + borderWidth + "' />\n  <div class='right' style='" + borderWidth + "' />\n</div>";
      return this.view.append(html);
    };

    InfinityTurtle.prototype._buildCircleLoader = function(borderWidth, classes) {
      var borderLeft, borderTop, inlineCSS;
      borderTop = "border-top-color: " + this._options.loaderColor + ";";
      borderLeft = "border-left-color: " + this._options.loaderColor + ";";
      inlineCSS = "style='" + borderWidth + " " + borderTop + " " + borderLeft + "'";
      return this.view.append("<div " + classes + " " + inlineCSS + " />");
    };

    InfinityTurtle.prototype._checkScrollPosition = function() {
      var $lastChild, position;
      $lastChild = this.view.children(':last-child');
      position = $lastChild.position().top + $lastChild.outerHeight(true);
      position -= this.view.offset().top;
      if (position === this.view.height()) {
        this.view.append(this._loader.show());
        this.view.off('scroll');
        return this._loadNextPage();
      }
    };

    InfinityTurtle.prototype._loadNextPage = function(delay) {
      var index, pageData;
      this._page += 1;
      index = this._options.pageSize * (this._page - 1);
      pageData = this.data.slice(index, this._options.pageSize + index);
      if (pageData.length < this._options.pageSize) {
        return this._sendPageData(true, pageData, delay);
      } else {
        return this._sendPageData(false, pageData, delay);
      }
    };

    InfinityTurtle.prototype._sendPageData = function(lastPage, pageData, delay) {
      if (delay == null) {
        delay = this._options.loaderSymbol === 'infinity' ? 900 : 500;
      }
      return setTimeout((function(_this) {
        return function() {
          _this.hideLoader();
          if (lastPage) {
            return _this.promise.resolve(pageData);
          } else {
            _this.promise.notify(pageData);
            return $(_this._options.scrollView).on('scroll', $.proxy(_this, '_onContainerScroll'));
          }
        };
      })(this), delay);
    };

    InfinityTurtle.prototype._onContainerScroll = function() {
      clearTimeout(this._timeout);
      return this._timeout = setTimeout((function(_this) {
        return function() {
          return _this._checkScrollPosition();
        };
      })(this), this._options.scrollDelay);
    };

    return InfinityTurtle;

  })();

  window.InfinityTurtle = InfinityTurtle;

}).call(this);
