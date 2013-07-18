class App.Model.Swatch extends Backbone.Model
  defaults:
    value: ""
    name: ""

class App.Model.Sketch extends Backbone.Model
  urlRoot : '/sketches'
  defaults:
    script: """
      void setup() {
        size(WIDTH, HEIGHT);
        background(0);
      }"""
    artwork: ""
    name: "Sketch"
    running: false

  initialize: () ->
    _.bindAll @
    @set 'swatches', new Backbone.Collection @get('swatches_data'), model: App.Model.Swatch
    @listenTo @, "change:swatches_data", @makeSwatches
    @listenTo @get('swatches'), "add", @makeSwatchData
    @listenTo @get('swatches'), "remove", @makeSwatchData

  makeSwatches: () ->
    if @get('swatches_data')
      @get('swatches').reset JSON.parse(@get('swatches_data'))

  makeSwatchData: () ->
    @set 'swatches_data', @get('swatches'), {silent: true}
