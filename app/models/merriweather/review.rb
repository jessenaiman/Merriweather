module Merriweather
	class Review < ActiveRecord::Base
	  belongs_to :product
	  attr_accessible :content, :name
	end
end

