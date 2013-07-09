class App.View.SwatchView extends Backbone.View
  className: 'swatch'
  initialize: () ->
    _.bindAll()
    @render()
    @listenTo @model, "change", @render

  render: () ->
    @el.innerHTML = ""
    color = document.createElement 'div'
    color.className = "color"
    c = "##{@model.get('hex')}"
    color.style.backgroundColor = c
    @el.appendChild color
    title = document.createElement 'div'
    title.className = 'title'
    title.innerText = @model.get('name')
    @el.appendChild title
    @

class App.View.SwatchesView extends Backbone.View
  el: ".swatches"

  initialize: () ->
    _.bindAll @

    @swatchViews = []
    @listenTo @model.get('swatches'), "reset", @render 
    @listenTo @model.get('swatches'), "add", @render
    @listenTo @model.get('swatches'), "remove", @render
    @render()

  render: () ->
    console.log "RENDER SWATCHES"
    @el.innerHTML = ""
    @model.get('swatches').each (swatch) =>
      view = new App.View.SwatchView(model: swatch)
      @swatchViews.push view
      @el.appendChild view.render().el
    @