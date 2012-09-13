require 'cancan'
module Merriweather
	class Merriweather::BaseController < ApplicationController
	  include Merriweather::Core::ControllerHelpers
	end
end
