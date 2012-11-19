class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.binary :photo_file
      t.binary :photo_medium_file
      t.binary :photo_thumb_file
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
