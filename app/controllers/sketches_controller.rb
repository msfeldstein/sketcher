class SketchesController < ApplicationController
  def index
    @sketches = Sketch.all
  end

  def show
    @sketch = Sketch.find params[:id]
    if request.xhr? or params[:json]
      render json: @sketch
    end
  end

  def new
  end

  def edit
  end

  def create
    sketch = Sketch.new params[:sketch]
    if sketch.save
      redirect_to sketch
    else
      flash[:error] = "ERROR"
    end
  end

  def update
    sketch = Sketch.find params[:id]
    sketch.name = params[:name] || sketch.name
    sketch.script = params[:script] || sketch.script
    sketch.artwork = params[:artwork] || sketch.artwork
    sketch.swatches_data = params[:swatches_data].to_json || sketch.swatches_data
    sketch.save
    render json: sketch
  end

  def destroy
  end
end
