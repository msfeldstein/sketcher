loadDroppedImage = (imageUrl) ->
  img = new Image()
  img.src = imageUrl
  img.addEventListener "load", () ->
    canvas = $(".image-drop")[0]
    ctx = canvas.getContext('2d')
    ratio = canvas.height / img.height
    console.log ratio
    w = img.width * ratio
    h = img.height * ratio
    ctx.drawImage(img, 0, 0, img.width, img.height, canvas.width / 2 - w / 2, 0, w, h)

$(document).ready () ->
  imageDrop = $(".image-drop")[0]
  canvas = $(".image-drop")[0]
  ctx = canvas.getContext('2d')
  $(".droppable").on "dragenter", (je) ->
    je.originalEvent.preventDefault()
    je.stopPropagation()
    je.currentTarget.classList.add("dragover")
  $(".droppable").on "dragover", (je) ->
    je.originalEvent.preventDefault()
    je.stopPropagation()
  $(".droppable").on "dragleave", (je) ->
    je.originalEvent.preventDefault()
    je.currentTarget.classList.remove("dragover")
  $(".droppable").on "drop", (je) ->
    console.log je
    je.stopPropagation()
    je.originalEvent.preventDefault()
    je.currentTarget.classList.remove("dragover")
    # je.currentTarget.style.backgroundImage = 

  $(".image-drop").dropImageReader (file, event) ->
    loadDroppedImage(event.target.result)

  $(".image-drop").on "mousemove", (je) ->
    x = je.offsetX
    y = je.offsetY
    data = canvas.getContext('2d').getImageData(x, y, 1, 1).data;
    imageDrop.style.backgroundColor = "rgb(#{data[0]}, #{data[1]}, #{data[2]})"

  $(".image-drop").on "click", (je) ->
    x = je.offsetX
    y = je.offsetY
    data = canvas.getContext('2d').getImageData(x, y, 1, 1).data;
    swatch = document.createElement('div')
    swatch.className = 'swatch'
    swatch.style.backgroundColor = "rgb(#{data[0]}, #{data[1]}, #{data[2]})"
    $(".swatches").append(swatch)

  resized = () ->
    imageDrop.width = document.body.offsetWidth / 2
    imageDrop.height = (document.body.offsetHeight - 100) / 2
  $(window).resize resized
  resized()