$(document).ready () =>
  @sketch = new App.Model.Sketch
  @sketch.load()

  @editorView = new App.View.EditorView model: @sketch
  @processingView = new App.View.ProcessingView model: @sketch