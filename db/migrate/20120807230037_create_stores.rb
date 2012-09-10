class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :coordinates
      t.string :phone
      t.string :url
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
