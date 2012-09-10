class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url
      t.references :product

      t.timestamps
    end

    add_index :videos, :product_id
  end
end
