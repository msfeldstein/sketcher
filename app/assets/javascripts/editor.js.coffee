editor = null
canvas = null

play = () ->
  new Processing(canvas, editor.getValue())
$(document).ready () ->
  editor = ace.edit("editor");
  editor.setTheme("ace/theme/monokai");
  editor.getSession().setMode("ace/mode/java");

  canvas = $(".canvas")[0]

  $('.play').on 'click', play
    

  resized = () ->
    canvas.width = document.body.offsetWidth / 2
    canvas.height = (document.body.offsetHeight - 100) / 2
    window.WIDTH = canvas.width
    window.HEIGHT = canvas.height
    play()
  $(window).resize resized
  resized()