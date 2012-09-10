class Product < ActiveRecord::Base
  belongs_to :genre
  belongs_to :band
  belongs_to :product_type
  has_many :songs
  has_many :reviews

  attr_accessible :content, :gemm, :image, :name, :release_date, :band_id, :genre_id, :product_type_id, :heading

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :genre, :band, :product_type
end
