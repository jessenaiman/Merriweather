module Merriweather
  module Core
    class Environment
      include EnvironmentExtension

      attr_accessor :calculators, :payment_methods, :preferences

      def initialize
        @calculators = Calculators.new
        @preferences = Merriweather::AppConfiguration.new
      end
    end
  end
end
