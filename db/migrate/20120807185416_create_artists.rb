class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :email
      t.string :content
      t.string :image

      t.timestamps
    end
  end
end
