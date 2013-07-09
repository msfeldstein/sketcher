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
    console.log "DATA", @get('swatches_data')
    if @get('swatches_data')
      console.log "Setting to that"
      @get('swatches').reset JSON.parse(@get('swatches_data'))
    @set "swatches_data", null
    console.log "DONE DATA MAKE SWATCHES"

  makeSwatchData: () ->
    console.log "MAKE SWATCH DATA"
    @set 'swatches_data', @get('swatches'), {silent: true}
    console.log "DONE MAKE SWATCH DATA"
