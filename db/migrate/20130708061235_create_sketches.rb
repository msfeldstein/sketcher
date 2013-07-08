class CreateSketches < ActiveRecord::Migration
  def change
    create_table :sketches do |t|
      t.text :script
      t.text :artwork
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
