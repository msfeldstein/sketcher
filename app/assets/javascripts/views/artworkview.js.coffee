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
    'mousemove': 'mousemove'
    'click'    : 'click'

  initialize: () ->
    _.bindAll @
    @canvas = @el
    @fbo = document.createElement('canvas')
    @fbo.id = 'fbo'
    @fbo.width = @fbo.height = 20
    $(window).resize @resized
    @resized()
    $(@canvas).dropImageReader @fileDropped
    @listenTo @model, 'change:artwork', @artworkChanged
    @artworkChanged()

  click: (je) ->
    @mouseX = je.offsetX
    @mouseY = je.offsetY
    if @img
      data = @canvas.getContext('2d').getImageData(@mouseX, @mouseY, 1, 1).data;
      name = prompt("Swatch Name:")
      @addSwatch(name, data[0], data[1], data[2])

  addSwatch: (name, r, g, b) ->
    hex = rgbToHex(r, g, b)
    @model.get('swatches').add(name: name, hex: hex, value: parseInt("#FF{hex}", 16))

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
    @el.width = document.body.offsetWidth / 2
    @el.height = (document.body.offsetHeight - 100) / 2
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
    @preview = @el.getContext('2d').getImageData(@mouseX - 10, @mouseY - 10, 20, 20)
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
      # ctx.scale(scale, scale, -@canvas.width / 2, -@canvas.height / 2)
      ctx.drawImage(@img, 0, 0, @img.width, @img.height, @canvas.width / 2 - w / 2, 0, w, h)
      ctx.restore()
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