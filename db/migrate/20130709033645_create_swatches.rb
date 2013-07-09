class CreateSwatches < ActiveRecord::Migration
  def change
    create_table :swatches do |t|
      t.string :name
      t.string :value
      t.timestamps
    end
  end
end
