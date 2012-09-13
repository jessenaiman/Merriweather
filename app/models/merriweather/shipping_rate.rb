module Merriweather
  class ShippingRate < Struct.new(:id, :shipping_method, :name, :cost)
    def initialize(attributes = {})
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def display_price
      if Merriweather::Config[:shipment_inc_vat]
        price = (1 + Merriweather::TaxRate.default) * cost
      else
        price = cost
      end

      Merriweather::Money.new(price)
    end
  end
end
