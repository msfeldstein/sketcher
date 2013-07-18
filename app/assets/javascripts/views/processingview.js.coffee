class App.View.ProcessingView extends Backbone.View
  el: "#canvas-container"

  initialize: () ->
    _.bindAll @
    @jel = $(@el)
    @listenTo @model, 'run', @runningChanged
    @listenTo @model, 'pause', @runningChanged
    @listenTo @model.get('swatches'), 'reset', @updateSwatches
    @listenTo @model.get('swatches'), 'add', @updateSwatches
    @listenTo @model.get('swatches'), 'remove', @updateSwatches
    $(window).resize @runningChanged

  updateSwatches: () ->
    @runningChanged()

  runningChanged: () ->
    if @model.get("running")
      @processingInstance?.noLoop()
      canvas = document.createElement('canvas')
      canvas.width = document.body.offsetWidth / 2
      canvas.height = (document.body.offsetHeight - 100) / 2
      window.WIDTH = canvas.width
      window.HEIGHT = canvas.height
      @jel.empty()
      @jel.append(canvas)
      script = @model.get("script")
      @model.get('swatches').each (swatch) =>
        script = "color #{swatch.get('name')} = #{swatch.get('value')};\n" + script
      try 
        @processingInstance = new Processing(canvas, script)
      catch e
        alert("ERROR: " + e.message)
    else
      @processingInstance?.noLoop()