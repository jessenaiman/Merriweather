module Merriweather
  module Core
    module UrlHelpers
      def merriweather
        Merriweather::Core::Engine.routes.url_helpers
      end
    end
  end
end
