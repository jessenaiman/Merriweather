class AddArtistsToBands < ActiveRecord::Migration
  def change
  	create_table :artists_bands, :id => false do |t|
      t.integer :band_id
      t.integer :artist_id
    end
  end
end
