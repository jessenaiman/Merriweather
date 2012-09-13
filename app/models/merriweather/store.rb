module Merriweather
	class Store < ActiveRecord::Base
	  attr_accessible :address, :coordinates, :lat, :lng, :name, :phone, :url
	end
end

