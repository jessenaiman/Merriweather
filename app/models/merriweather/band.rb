class Band < ActiveRecord::Base
	has_many :products
	has_and_belongs_to_many :artists
  attr_accessible :content, :image, :name, :self_titled, :artist_ids

  mount_uploader :image, ImageUploader
end
