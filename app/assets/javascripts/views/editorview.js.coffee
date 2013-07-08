class App.View.EditorView extends Backbone.View
  el: ".editor-holder"

  events:
    'click .play' : 'play'
    'click .pause' : 'pause'

  initialize: () ->
    _.bindAll @
    @render()
    @model.bind 'change:script', 'setValue'

  render: () ->
    @editor = ace.edit("editor")
    @editor.setTheme("ace/theme/monokai")
    @editor.getSession().setMode("ace/mode/java")
    @setValue()

  setValue: () ->
    @editor.setValue(@model.get('script'))

  play: () ->
    @model.set "running", true, {silent: true}
    @model.trigger('change:running')

  pause: () ->
    @model.set "running", false, {silent: true}
    @model.trigger('change:running')
