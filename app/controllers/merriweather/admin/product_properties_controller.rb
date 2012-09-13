module Merriweather
  module Admin
    class ProductPropertiesController < ResourceController
      belongs_to 'product', :find_by => :permalink
      before_filter :find_properties
      before_filter :setup_property, :only => [:index]

      private
        def find_properties
          @properties = Property.pluck(:name)
        end

        def setup_property
          @product.product_properties.build
        end
    end
  end
end
