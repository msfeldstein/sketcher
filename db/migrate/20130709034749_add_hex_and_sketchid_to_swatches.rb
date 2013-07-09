class AddHexAndSketchidToSwatches < ActiveRecord::Migration
  def change
    add_column :swatches, :hex, :string
    add_column :swatches, :sketch_id, :integer
  end
end
