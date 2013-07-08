class App.View.ProcessingView extends Backbone.View
  el: "#canvas-container"

  initialize: () ->
    _.bindAll @
    @jel = $(@el)
    @model.bind "run", @runningChanged
    @model.bind "pause", @runningChanged
    $(window).resize @runningChanged

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
      @processingInstance = new Processing(canvas, @model.get("script"))
    else
      @processingInstance?.noLoop()