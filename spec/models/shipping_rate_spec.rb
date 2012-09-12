require 'spec_helper'

describe Merriweather::ShippingRate do
  let(:shipping_rate) { Merriweather::ShippingRate.new(:cost => 10.55) }
  before { Merriweather::TaxRate.stub(:default => 0.05) }

  context "#display_price" do
    context "when shipment includes VAT" do
      before { Merriweather::Config[:shipment_inc_vat] = true }
      it "displays the correct price" do
        shipping_rate.display_price.to_s.should == "$11.08" # $10.55 * 1.05 == $11.08
      end
    end

    context "when shipment does not include VAT" do
      before { Merriweather::Config[:shipment_inc_vat] = false }
      it "displays the correct price" do
        shipping_rate.display_price.to_s.should == "$10.55"
      end
    end
  end
end
