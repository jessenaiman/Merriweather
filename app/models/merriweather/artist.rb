class Artist < ActiveRecord::Base
	has_and_belongs_to_many :bands
	has_many :products, :through => :bands

	attr_accessible :content, :email, :image, :name, :band_ids

	mount_uploader :image, ImageUploader
end
