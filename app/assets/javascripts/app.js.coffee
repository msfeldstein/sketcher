$(document).ready () =>
  if not sketch_id then return
  @sketch = new App.Model.Sketch id: sketch_id

  @editorView = new App.View.EditorView model: @sketch
  @processingView = new App.View.ProcessingView model: @sketch