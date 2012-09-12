module Merriweather
  module Core
    module UrlHelpers
      def spree
        Merriweather::Core::Engine.routes.url_helpers
      end
    end
  end
end
