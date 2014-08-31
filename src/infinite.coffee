class InfiniteTurtle

  defaults:
    pageSize: 20
    loader:
      symbol: 'circle'
      color: '#0bc6d4'
      width: '2px'
      url: ''

  constructor: (options) ->
    @_options = $.extend options, @defaults
    @buildLoader()

  buildLoader: ->
    borderWidth = "border-width: #{@_options.loader.width};"
    if @_options.loader.symbol is 'infinity'
      borderColor = "border-color: #{@_options.loader.color};"
      inlineCSS   = "style='#{borderWidth} #{borderColor}'"

    else
      borderTop  = "border-top-color: #{@_options.loader.color};"
      borderLeft = "border-left-color: #{@_options.loader.color};"
      inlineCSS  = "style='#{borderWidth} #{borderTop} #{borderLeft}'"

    classes     = "class='infinite-loader #{@_options.loader.symbol}'"
    $("<div #{classes} #{inlineCSS} />").appendTo 'body'

window.InfiniteTurtle = InfiniteTurtle
