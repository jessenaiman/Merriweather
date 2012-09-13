module Merriweather
	class Genre < ActiveRecord::Base
		has_many :products
	  attr_accessible :abbr, :name
	end
end
