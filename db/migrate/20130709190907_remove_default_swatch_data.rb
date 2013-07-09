class RemoveDefaultSwatchData < ActiveRecord::Migration
  def change
  	change_column :sketches, :swatches_data, :text, :default => ""
  end
end
