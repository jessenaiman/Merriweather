require 'spec_helper'

describe Merriweather::Order do
  let(:order) { Merriweather::Order.new }

  context 'validation' do
    context "when @use_billing is populated" do
      before do
        order.bill_address = stub_model(Merriweather::Address)
        order.ship_address = nil
      end

      context "with true" do
        before { order.use_billing = true }

        it "clones the bill address to the ship address" do
          order.valid?
          order.ship_address.should == order.bill_address
        end
      end

      context "with 'true'" do
        before { order.use_billing = 'true' }

        it "clones the bill address to the shipping" do
          order.valid?
          order.ship_address.should == order.bill_address
        end
      end

      context "with '1'" do
        before { order.use_billing = '1' }

        it "clones the bill address to the shipping" do
          order.valid?
          order.ship_address.should == order.bill_address
        end
      end

      context "with something other than a 'truthful' value" do
        before { order.use_billing = '0' }

        it "does not clone the bill address to the shipping" do
          order.valid?
          order.ship_address.should be_nil
        end
      end
    end
  end
end
