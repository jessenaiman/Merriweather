# Use this module to easily test Merriweather actions within Merriweather components
# or inside your application to test routes for the mounted Merriweather engine.
#
# Inside your spec_helper.rb, include this module inside the RSpec.configure
# block by doing this:
#
#   require 'merriweather/core/testing_support/controller_requests'
#   RSpec.configure do |c|
#     c.include Merriweather::Core::TestingSupport::ControllerRequests, :type => :controller
#   end
#
# Then, in your controller tests, you can access merriweather routes like this:
#
#   require 'spec_helper'
#
#   describe Merriweather::ProductsController do
#     it "can see all the products" do
#       merriweather_get :index
#     end
#   end
#
# Use merriweather_get, merriweather_post, merriweather_put or merriweather_delete to make requests
# to the Merriweather engine, and use regular get, post, put or delete to make
# requests to your application.
#
module Merriweather
  module Core
    module TestingSupport
      module ControllerRequests
        def merriweather_get(action, parameters = nil, session = nil, flash = nil)
          process_merriweather_action(action, parameters, session, flash, "GET")
        end

        # Executes a request simulating POST HTTP method and set/volley the response
        def merriweather_post(action, parameters = nil, session = nil, flash = nil)
          process_merriweather_action(action, parameters, session, flash, "POST")
        end

        # Executes a request simulating PUT HTTP method and set/volley the response
        def merriweather_put(action, parameters = nil, session = nil, flash = nil)
          process_merriweather_action(action, parameters, session, flash, "PUT")
        end

        # Executes a request simulating DELETE HTTP method and set/volley the response
        def merriweather_delete(action, parameters = nil, session = nil, flash = nil)
          process_merriweather_action(action, parameters, session, flash, "DELETE")
        end

        def merriweather_xhr_get(action, parameters = nil, session = nil, flash = nil)
          parameters ||= {}
          parameters.reverse_merge!(:format => :json)
          parameters.merge!(:use_route => :merriweather)
          xml_http_request(:get, action, parameters, session, flash)
        end

        private

        def process_merriweather_action(action, parameters = nil, session = nil, flash = nil, method = "GET")
          parameters ||= {}
          process(action, parameters.merge!(:use_route => :merriweather), session, flash, method)
        end
      end
    end
  end
end


