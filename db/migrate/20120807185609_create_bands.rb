class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.string :content
      t.string :image
      t.boolean :self_titled

      t.timestamps
    end
  end
end
