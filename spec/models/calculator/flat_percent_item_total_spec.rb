require 'spec_helper'

describe Merriweather::Calculator::FlatPercentItemTotal do
  let(:calculator) { Merriweather::Calculator::FlatPercentItemTotal.new }
  let(:order) { mock_model Merriweather::Order, :line_items => [mock_model(Merriweather::LineItem, :amount => 10), mock_model(Merriweather::LineItem, :amount => 20)] }

  before { calculator.stub :preferred_flat_percent => 10 }

  context "compute" do
    it "should compute amount correctly" do
      calculator.compute(order).should == 3.0
    end

    it "should round result correctly" do
      order.stub :line_items => [mock_model(Merriweather::LineItem, :amount => 10.56), mock_model(Merriweather::LineItem, :amount => 20.49)]
      calculator.compute(order).should == 3.11

      order.stub :line_items => [mock_model(Merriweather::LineItem, :amount => 10.56), mock_model(Merriweather::LineItem, :amount => 20.48)]
      calculator.compute(order).should == 3.10
    end
  end
end
