module Merriweather
	class Prototype < ActiveRecord::Base
	  has_and_belongs_to_many :properties, :join_table => :properties_prototypes
	  has_and_belongs_to_many :option_types, :join_table => :option_types_prototypes

	  attr_accessible :name

	  validates :name, :presence => true
	end
end