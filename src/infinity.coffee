class InfinityTurtle

  defaults:
    container    : 'body'     # Any valid jQuery selector
    loaderColor  : '#ddddff'  # Any valid CSS color value
    loaderClass  : ''         # Class to be added to the loader
    loaderSymbol : 'infinity' # infinity or circle
    loaderWidth  : '2px'      # Stroke width of the symbols
    pageSize     : 10         # Number of items per page
    scrollDelay  : 50         # Milliseconds between pagination calculations
    scrollView   : 'body'     # Any valid jQuery selector

  constructor: (@data, options) ->
    @_options = $.extend {}, @defaults, options
    @view     = $ @_options.container
    @promise  = $.Deferred()
    @_page    = 0
    @_buildLoader()
    @_loadNextPage 0

  hideLoader: (fade = no) ->
    if fade then @_loader.fadeOut() else @_loader.hide()

  _buildLoader: ->
    classes     = "#{@_options.loaderSymbol} #{@_options.loaderClass}"
    classes     = "class='infinite-loader #{classes}'"
    borderWidth = "border-width: #{@_options.loaderWidth};"
    @_loader    = switch @_options.loaderSymbol
      when 'infinity' then @_buildInfinityLoader borderWidth, classes
      else @_buildCircleLoader borderWidth

  _buildInfinityLoader: (borderWidth, classes) ->
    borders = "border-color: #{@_options.loaderColor};"
    html    = """
      <div #{classes} style='#{borders}'>
        <div class='left' style='#{borderWidth}' />
        <div class='right' style='#{borderWidth}' />
      </div>
    """
    $(html).appendTo @view

  _buildCircleLoader: (borderWidth, classes) ->
    borderTop  = "border-top-color: #{@_options.loaderColor};"
    borderLeft = "border-left-color: #{@_options.loaderColor};"
    inlineCSS  = "style='#{borderWidth} #{borderTop} #{borderLeft}'"
    $("<div #{classes} #{inlineCSS} />").appendTo @view

  _checkScrollPosition: ->
    $lastChild = @view.children ':last-child'
    position   = $lastChild.position().top + $lastChild.outerHeight true
    position  -= @view.offset().top
    if position is @view.height()
      @view.append @_loader.show()
      @view.off 'scroll'
      @_loadNextPage()

  _loadNextPage: (delay) ->
    @_page += 1
    index    = @_options.pageSize * (@_page - 1)
    pageData = @data.slice index, @_options.pageSize + index

    if pageData.length < @_options.pageSize
      @_sendPageData yes, pageData, delay
    else
      @_sendPageData no, pageData, delay

  _sendPageData: (lastPage, pageData, delay) ->
    delay ?= if @_options.loaderSymbol is 'infinity' then 900 else 500
    setTimeout =>
      @hideLoader()
      if lastPage
        @promise.resolve pageData
      else
        @promise.notify pageData
        $(@_options.scrollView).on 'scroll', $.proxy this, '_onContainerScroll'
    , delay

  # event handlers
  #

  _onContainerScroll: ->
    clearTimeout @_timeout
    @_timeout = setTimeout =>
      @_checkScrollPosition()
    , @_options.scrollDelay

window.InfinityTurtle = InfinityTurtle
