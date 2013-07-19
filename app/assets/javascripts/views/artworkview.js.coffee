componentToHex = (c) ->
    hex = c.toString(16)
    if hex.length is 1 then "0" + hex else hex

rgbToHex = (r, g, b) ->
    componentToHex(r) + componentToHex(g) + componentToHex(b)

class App.View.ArtworkView extends Backbone.View
  el: ".image-drop"

  events:
    'dragenter': 'dragenter'
    'dragover' : 'dragover'
    'dragleave': 'dragleave'
    'drop'     : 'drop'
    'mouseenter': 'mouseenter'
    'mouseleave': 'mouseleave'
    'mousemove': 'mousemove'
    'click .zoom-in': 'zoomIn'
    'click .zoom-out': 'zoomOut'
    'click canvas'    : 'click'

  initialize: () ->
    _.bindAll @
    @scale = 1
    @canvas = @el.getElementsByTagName('canvas')[0];
    @fbo = document.createElement('canvas')
    @fbo.id = 'fbo'
    @fbo.width = @fbo.height = 20
    $(window).resize @resized
    @resized()
    $(@canvas).dropImageReader @fileDropped
    @listenTo @model, 'change:artwork', @artworkChanged
    @artworkChanged()
    @previewAlpha = 0

  mouseenter: () =>
    clearTimeout @fadeTimer
    @fadeTimer = setTimeout @fadeIn, 30

  mouseleave: () =>
    clearTimeout @fadeTimer
    @fadeTimer = setTimeout @fadeOut, 30    

  fadeIn: () =>
    @previewAlpha += 1
    if @previewAlpha > 1 then @previewAlpha = 1
    @render()
    if @previewAlpha < 1
      @fadeTimer = setTimeout @fadeIn, 15 

  fadeOut: () =>
    @previewAlpha -= 1
    if @previewAlpha < 0 then @previewAlpha = 0
    @render()
    if @previewAlpha > 0
      @fadeTimer = setTimeout @fadeOut, 15  

  zoomIn: (e) =>
    @scale++
    @render()
    e.preventDefault()

  zoomOut: (e) =>
    @scale--
    if @scale < 1 then @scale = 1
    @render()
    e.preventDefault()

  click: (je) ->
    @mouseX = je.offsetX
    @mouseY = je.offsetY
    if @img
      data = @canvas.getContext('2d').getImageData(@mouseX, @mouseY, 1, 1).data;
      name = prompt("Swatch Name:")
      @addSwatch(name, data[0], data[1], data[2])

  addSwatch: (name, r, g, b) ->
    hex = rgbToHex(r, g, b)
    value = parseInt("FF#{hex}", 16)
    console.log "HEX #{hex} VALUE #{value} 'FF#{hex}'"
    @model.get('swatches').add(name: name, hex: hex, value: value)

  fileDropped: (file, event) ->
    @model.set "artwork", event.target.result
    @model.save()

  artworkChanged: () -> 
    if @model.get("artwork") 
      @img = new Image()
      @img.src = @model.get("artwork")
      @img.addEventListener "load", @render
    else
      @img = null

  resized: () ->
    @canvas.width = document.body.offsetWidth / 2
    @canvas.height = (document.body.offsetHeight - 100) / 2
    @render()

  dragenter: (je) ->
    je.originalEvent.preventDefault()
    je.stopPropagation()
    je.currentTarget.classList.add("dragover")
  dragover: (je) ->
    je.originalEvent.preventDefault()
    je.stopPropagation()
  dragleave: (je) ->
    je.originalEvent.preventDefault()
    je.currentTarget.classList.remove("dragover")
  drop: (je) ->
    je.stopPropagation()
    je.originalEvent.preventDefault()
    je.currentTarget.classList.remove("dragover")

  mousemove: (je) ->
    @mouseX = je.offsetX
    @mouseY = je.offsetY
    data = @canvas.getContext('2d').getImageData(@mouseX, @mouseY, 1, 1).data;
    @color = "rgb(#{data[0]}, #{data[1]}, #{data[2]})"
    @preview = @canvas.getContext('2d').getImageData(@mouseX - 10, @mouseY - 10, 20, 20)
    @render()

  render: () ->
    ctx = @canvas.getContext('2d')
    ctx.fillStyle = "#000000"
    ctx.fillRect(0, 0, @canvas.width, @canvas.height)
    if @img
      ratio = @canvas.height / @img.height
      w = @img.width * ratio
      h = @img.height * ratio
      ctx.save()
      ctx.translate(@canvas.width / 2, @canvas.height / 2)
      ctx.scale(@scale, @scale)
      ctx.translate(-@canvas.width / 2, -@canvas.height / 2)
      ctx.drawImage(@img, 0, 0, @img.width, @img.height, @canvas.width / 2 - w / 2, 0, w, h)
      ctx.restore()
    ctx.globalAlpha = @previewAlpha
    ctx.fillStyle = @color
    ctx.fillRect(20, 20, 80, 80)
    if @preview
      @fbo.getContext('2d').putImageData(@preview, 0, 0)
    ctx.save()
    ctx.drawImage(@fbo, 20, 100, 80, 80)
    ctx.restore()
    ctx.fillStyle = null
    ctx.strokeStyle = "#000000"
    ctx.strokeRect(20 + 40 - 2, 100 + 40 - 2, 4, 4)
    ctx.globalAlpha = 1