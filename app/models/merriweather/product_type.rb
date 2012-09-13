module Merriweather
	class ProductType < ActiveRecord::Base
		has_many :products
	  attr_accessible :name, :price
	end
end
