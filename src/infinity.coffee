class InfinityTurtle

  defaults:
    container    : 'body'     # Any valid jQuery selector
    loaderColor  : '#ddddff'  # Any valid CSS color value
    loaderSymbol : 'infinity' # infinity or circle
    loaderURL    : no         # Path to an image to use in place of a symbol
    loaderWidth  : '2px'      # Stroke width of the symbols
    pageSize     : 2          # Number of items per page
    scrollDelay  : 50         # Milliseconds between pagination calculations

  constructor: (@data, options) ->
    @_options = $.extend {}, @defaults, options
    @view     = $ @_options.container
    @promise  = $.Deferred()
    @_page    = 0
    @buildLoader()
    @loadNextPage()

    return unless @data.length > @_options.pageSize
    @view.on 'scroll', $.proxy this, '_onContainerScroll'

  buildLoader: ->
    borderWidth = "border-width: #{@_options.loaderWidth};"
    @_loader = switch @_options.loaderSymbol
      when 'infinity' then @_buildInfinityLoader borderWidth
      else @_buildCircleLoader borderWidth

  _buildInfinityLoader: (borderWidth) ->
    borders = "border-color: #{@_options.loaderColor};"
    classes = "class='infinite-loader #{@_options.loaderSymbol}'"
    html    = """
      <div #{classes} style='#{borders}'>
        <div class='left' style='#{borderWidth}' />
        <div class='right' style='#{borderWidth}' />
      </div>
    """
    $ html

  _buildCircleLoader: (borderWidth) ->
    borderTop  = "border-top-color: #{@_options.loaderColor};"
    borderLeft = "border-left-color: #{@_options.loaderColor};"
    inlineCSS  = "style='#{borderWidth} #{borderTop} #{borderLeft}'"
    classes    = "class='infinite-loader #{@_options.loaderSymbol}'"
    $ "<div #{classes} #{inlineCSS} />"

  checkScrollPosition: ->
    $lastChild = @view.find ':last-child'
    position   = $lastChild.offset().top + $lastChild.height()
    position  -= @view.offset().top
    console.log position, @view.height()
    if position <= @view.height()
      @view.append @_loader
      @view.off 'scroll'
      @loadNextPage()

  loadNextPage: ->
    @_page += 1
    @_loader.remove()
    index    = @_options.pageSize * (@_page - 1)
    pageData = @data.slice index, @_options.pageSize + index

    if pageData.length < @_options.pageSize
      @promise.resolve pageData
    else
      @promise.notify pageData
      @view.on 'scroll', $.proxy this, '_onContainerScroll'

  # event handlers
  #

  _onContainerScroll: ->
    clearTimeout @_timeout
    @_timeout = setTimeout =>
      @checkScrollPosition()
    , @_options.scrollDelay

window.InfinityTurtle = InfinityTurtle
