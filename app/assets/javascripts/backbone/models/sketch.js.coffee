class Illustratingjs.Models.Sketch extends Backbone.Model
  paramRoot: 'sketch'

  defaults:
    swatches: []
    artwork: ''
    code: ''

class Illustratingjs.Collections.SketchesCollection extends Backbone.Collection
  model: Illustratingjs.Models.Sketch
  url: '/sketches'
