class App.View.EditorView extends Backbone.View
  el: ".editor-holder"

  events:
    'click .play' : 'play'
    'click .pause' : 'pause'

  initialize: () ->
    _.bindAll @
    @render()
    @model.bind 'change:script', @setValue
    @editor.getSession().on 'change', @changed

  changed: () ->
    clearTimeout @timer
    @timer = setTimeout @save, 2000

  save: () ->
    @model.set "script", @editor.getValue()

  render: () ->
    @editor = ace.edit("editor")
    @editor.setTheme("ace/theme/monokai")
    @editor.getSession().setMode("ace/mode/java")
    @setValue()

  setValue: () ->
    @editor.setValue(@model.get('script'), @editor.getCursorPosition())

  play: () ->
    @save()
    @model.set "running", true
    @model.trigger('run')

  pause: () ->
    @model.set "running", false
    @model.trigger('pause')
