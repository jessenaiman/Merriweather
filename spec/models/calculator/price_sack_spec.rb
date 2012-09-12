require 'spec_helper'

describe Merriweather::Calculator::PriceSack do
  let(:calculator) { Merriweather::Calculator::PriceSack.new }
  let(:order) { stub_model(Merriweather::Order) }
  let(:shipment) { stub_model(Merriweather::Shipment) }

  # Regression test for #714 and #739
  it "computes with an order object" do
    calculator.compute(order)
  end

  # Regression test for #1156
  it "computes with a snipment object" do
    calculator.compute(shipment)
  end
end
