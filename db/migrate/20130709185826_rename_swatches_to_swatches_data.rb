class RenameSwatchesToSwatchesData < ActiveRecord::Migration
  def change
  	rename_column :sketches, :swatches, :swatches_data
  end
end
