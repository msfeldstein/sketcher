class App.Model.Sketch extends Backbone.Model
  urlRoot : '/sketch'
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

  initialize: () ->
    _.bindAll @
    @listenTo @, "changed", @save