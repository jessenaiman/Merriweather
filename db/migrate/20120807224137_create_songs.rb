class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :mp3
      t.references :product

      t.timestamps
    end
    add_index :songs, :product_id
  end
end
