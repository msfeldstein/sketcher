class App.Model.Sketch extends Backbone.Model
  urlRoot : '/sketches'
  defaults:
    script: """
      void setup() {
        size(WIDTH, HEIGHT);
        background(0);
      }"""
    artwork: ""
    swatches: []
    name: "Sketch"
    running: false

  initialize: () ->
    _.bindAll @
    @listenTo @, "changed", @save