class MakeSwatchesASingleField < ActiveRecord::Migration
  def change
  	drop_table :swatches
  	add_column :sketches, :swatches, :text, :default => "[]"
  end
end
