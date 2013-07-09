# img = null
# color = null
# preview = null
# canvas = null
# mouseX = 0
# mouseY = 0
# scale = 1
# fbo = document.createElement('canvas')
# fbo.id = 'fbo'
# fbo.width = fbo.height = 20

# componentToHex = (c) ->
#     hex = c.toString(16)
#     if hex.length is 1 then "0" + hex else hex

# rgbToHex = (r, g, b) ->
#     hex = "FF" + componentToHex(r) + componentToHex(g) + componentToHex(b)
#     parseInt(hex, 16)

# draw = () ->
#   canvas = $(".image-drop")[0]
#   ctx = canvas.getContext('2d')
#   ctx.fillStyle = "#000000"
#   ctx.fillRect(0, 0, canvas.width, canvas.height)
#   if img
#     ratio = canvas.height / img.height
#     w = img.width * ratio
#     h = img.height * ratio
#     ctx.save()
#     ctx.scale(scale, scale, -canvas.width / 2, -canvas.height / 2)
#     ctx.drawImage(img, 0, 0, img.width, img.height, canvas.width / 2 - w / 2, 0, w, h)
#     ctx.restore()
#     ctx.fillStyle = color
#     ctx.fillRect(20, 20, 80, 80)

#     fbo.getContext('2d').putImageData(preview, 0, 0)
#     ctx.save()
#     ctx.drawImage(fbo, 20, 100, 80, 80)
#     ctx.restore()
#     ctx.fillStyle = null
#     ctx.strokeStyle = "#000000"
#     ctx.strokeRect(20 + 40 - 2, 100 + 40 - 2, 4, 4)

# addSwatch = (name, r, g, b) ->
#   swatch = document.createElement('div')
#   swatch.className = 'swatch'
#   swatch.style.backgroundColor = "rgb(#{r}, #{g}, #{b})"
#   window[name] = rgbToHex(r, g, b)
#   $(".swatches").append(swatch)

# loadDroppedImage = (imageUrl) ->
#   img = new Image()
#   img.src = imageUrl
#   img.addEventListener "load", draw

# $(document).ready () ->
#   imageDrop = $(".image-drop")[0]
#   canvas = $(".image-drop")[0]
#   ctx = canvas.getContext('2d')
#   $(".droppable").on "dragenter", (je) ->
#     je.originalEvent.preventDefault()
#     je.stopPropagation()
#     je.currentTarget.classList.add("dragover")
#   $(".droppable").on "dragover", (je) ->
#     je.originalEvent.preventDefault()
#     je.stopPropagation()
#   $(".droppable").on "dragleave", (je) ->
#     je.originalEvent.preventDefault()
#     je.currentTarget.classList.remove("dragover")
#   $(".droppable").on "drop", (je) ->
#     console.log je
#     je.stopPropagation()
#     je.originalEvent.preventDefault()
#     je.currentTarget.classList.remove("dragover")
#     # je.currentTarget.style.backgroundImage = 

#   $(".image-drop").dropImageReader (file, event) ->
#     loadDroppedImage(event.target.result)

#   $(".image-drop").on "mousemove", (je) ->
#     mouseX = je.offsetX
#     mouseY = je.offsetY
#     data = canvas.getContext('2d').getImageData(mouseX, mouseY, 1, 1).data;
#     color = "rgb(#{data[0]}, #{data[1]}, #{data[2]})"
#     preview = canvas.getContext('2d').getImageData(mouseX - 10, mouseY - 10, 20, 20)
#     draw();

#   $(".image-drop").on "click", (je) ->
#     mouseX = je.offsetX
#     mouseY = je.offsetY
#     if img
#       data = canvas.getContext('2d').getImageData(mouseX, mouseY, 1, 1).data;
#       name = prompt("Swatch Name:")
#       addSwatch(name, data[0], data[1], data[2])

#   resized = () ->
#     imageDrop.width = document.body.offsetWidth / 2
#     imageDrop.height = (document.body.offsetHeight - 100) / 2
#   $(window).resize resized
#   resized()