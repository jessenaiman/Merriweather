require 'cancan'

class BaseController < ApplicationController
  include Merriweather::Core::ControllerHelpers
end
