class Song < ActiveRecord::Base
  belongs_to :product
  attr_accessible :mp3, :name, :product_id

  mount_uploader :mp3, SoundUploader

end
