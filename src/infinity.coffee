class InfinityTurtle

  defaults:
    container    : 'body'     # Any valid jQuery selector
    loaderColor  : '#ddddff'  # Any valid CSS color value
    loaderClass  : ''         # Class to be added to the loader
    loaderSymbol : 'infinity' # infinity or circle
    loaderWidth  : '2px'      # Stroke width of the symbols
    pageSize     : 10         # Number of items per page
    scrollDelay  : 50         # Milliseconds between pagination calculations
    scrollView   : null       # Any valid jQuery selector

  constructor: (@data, options) ->
    @_options = $.extend {}, @defaults, options
    @_options.scrollView ?= @_options.container

    # Store some variables so we don't have to making them elsewhere
    @container = $ @_options.container
    @view      = $ @_options.scrollView
    @promise   = $.Deferred()

    # Build the loader, then go ahead and load up the first page
    @_buildLoader()
    @_loadNextPage 0

  # Hides or fades out the loader
  hideLoader: (fade = no) ->
    if fade then @_loader.fadeOut() else @_loader.hide()


  # loader markup generation
  #

  # Builds the correct loader, using the given symbol option
  _buildLoader: ->
    classes     = "#{@_options.loaderSymbol} #{@_options.loaderClass}"
    classes     = "class='infinite-loader #{classes}'"
    borderWidth = "border-width: #{@_options.loaderWidth};"
    @_loader    = switch @_options.loaderSymbol
      when 'infinity' then @_buildInfinityLoader borderWidth, classes
      else @_buildCircleLoader borderWidth

  # Builds out the markup for the infinity loader, and stores it
  _buildInfinityLoader: (borderWidth, classes) ->
    borders = "border-color: #{@_options.loaderColor};"
    html    = """
      <div #{classes} style='#{borders}'>
        <div class='left' style='#{borderWidth}' />
        <div class='right' style='#{borderWidth}' />
      </div>
    """
    $(html).appendTo @container

  # Builds out the markup for the circle loader, and stores it
  _buildCircleLoader: (borderWidth, classes) ->
    borderTop  = "border-top-color: #{@_options.loaderColor};"
    borderLeft = "border-left-color: #{@_options.loaderColor};"
    inlineCSS  = "style='#{borderWidth} #{borderTop} #{borderLeft}'"
    $("<div #{classes} #{inlineCSS} />").appendTo @container


  # position checking
  #

  # Checks the scroll position, and acts appropriately
  _checkScrollPosition: ->
    sameElements = @_options.container is @_options.scrollView
    loadNextPage = if sameElements then @_checkContainer() else @_checkView()

    # If we need to load the next page...
    # Stop listening for the scroll event, add the loader, then load the page
    if loadNextPage
      @view.off 'scroll'
      @container.append @_loader.show()
      @_loadNextPage()

  # Check the scroll position of the given container
  # Returns a boolean containing whether or not we need to load the next page
  _checkContainer: ->
    $lastChild = @container.children ':last-child'
    position   = $lastChild.offset().top + $lastChild.outerHeight yes
    position  -= @view.offset().top
    position  <= @view.outerHeight no

  # Check the scroll position of the given scroll view
  # Returns a boolean containing whether or not we need to load the next page
  _checkView: ->
    height   = @container.outerHeight yes
    position = @container.position().top
    height + position <= @view.outerHeight yes


  # page loading
  #

  # Grab the next page's data, and load it up
  _loadNextPage: (delay) ->
    @_page  ?= 0
    @_page  += 1
    index    = @_options.pageSize * (@_page - 1)
    pageData = @data.slice index, @_options.pageSize + index

    # Send the page's data up and out
    if pageData.length < @_options.pageSize
      @_sendPageData yes, pageData, delay
    else
      @_sendPageData no, pageData, delay

  # Fires the promise, sending the page data with it
  # Waits one animation cycle before sending the data
  _sendPageData: (lastPage, pageData, delay) ->
    delay ?= if @_options.loaderSymbol is 'infinity' then 900 else 500
    setTimeout =>
      @hideLoader()
      if lastPage
        @promise.resolve pageData
      else
        @promise.notify pageData
        @view.on 'scroll', $.proxy this, '_onContainerScroll'
    , delay


  # event handlers
  #

  # Waits the given amount of time, then checks the scroll position
  _onContainerScroll: ->
    clearTimeout @_timeout
    @_timeout = setTimeout =>
      @_checkScrollPosition()
    , @_options.scrollDelay

window.InfinityTurtle = InfinityTurtle
