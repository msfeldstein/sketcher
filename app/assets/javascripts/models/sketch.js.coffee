class App.Model.Sketch extends Backbone.Model
  defaults:
    script: """
      void setup() {
        size(WIDTH, HEIGHT);
        background(0);
      }"""
    imagedata: ""
    swatches: []
    name: "Sketch"
    running: false

  save: () ->
    data = 
      script: @script
      imagedata: @imagedata
      swatches: @swatches
    localStorage.setItem(@sketch, JSON.stringify(data))
  load: (name = "Sketch") ->
    data = JSON.parse(localStorage.getItem(name))
    if data
      @set("script", data.script)
      @set("imagedata", @imagedata)
      @set("swatches", @swatches)