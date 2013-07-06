editor = null
canvas = null
processingInstance = null

save = () ->
  sketch = {}
  sketch.code = editor.getValue()
  localStorage.setItem('sketch', JSON.stringify(sketch))

load = () ->
  json = localStorage.getItem('sketch')
  if json
    sketch = JSON.parse(json)
    editor.setValue(sketch.code)

play = () ->
  save()
  canvas?.parentNode.removeChild canvas
  processingInstance?.noLoop()
  canvas = document.createElement('canvas')
  canvas.width = document.body.offsetWidth / 2
  canvas.height = (document.body.offsetHeight - 100) / 2
  window.WIDTH = canvas.width
  window.HEIGHT = canvas.height
  $(".canvas").append(canvas)
  processingInstance = new Processing(canvas, editor.getValue())

pause = () ->
  processingInstance.noLoop()

$(document).ready () ->
  editor = ace.edit("editor");
  editor.setTheme("ace/theme/monokai");
  editor.getSession().setMode("ace/mode/java");

  editor.setValue(document.getElementById("sample").innerText);

  load()

  $('.play').on 'click', play
  $('.pause').on 'click', pause
  $(window).resize play