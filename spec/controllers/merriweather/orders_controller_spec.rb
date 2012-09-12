require 'spec_helper'

describe Merriweather::OrdersController do
  let(:user) { create(:user) }
  let(:order) { mock_model(Merriweather::Order, :number => "R123", :reload => nil, :save! => true, :coupon_code => nil, :user => user, :completed? => false)}
  before do
    Merriweather::Order.stub(:find).with(1).and_return(order)
    #ensure no respond_overrides are in effect
    if Merriweather::BaseController.Merriweather_responders[:OrdersController].present?
      Merriweather::BaseController.Merriweather_responders[:OrdersController].clear
    end
  end

  context "#populate" do
    before { Merriweather::Order.stub(:new).and_return(order) }

    it "should create a new order when none specified" do
      Merriweather::Order.should_receive(:new).and_return order
      Merriweather_post :populate, {}, {}
      session[:order_id].should == order.id
    end

    context "with Variant" do
      before do
        @variant = mock_model(Merriweather::Variant)
        Merriweather::Variant.should_receive(:find).and_return @variant
      end

      it "should handle single variant/quantity pair" do
        order.should_receive(:add_variant).with(@variant, 2)
        Merriweather_post :populate, {:order_id => 1, :variants => {@variant.id => 2}}
      end
      it "should handle multiple variant/quantity pairs with shared quantity" do
        @variant.stub(:product_id).and_return(10)
        order.should_receive(:add_variant).with(@variant, 1)
        Merriweather_post :populate, {:order_id => 1, :products => {@variant.product_id => @variant.id}, :quantity => 1}
      end
      it "should handle multiple variant/quantity pairs with specific quantity" do
        @variant.stub(:product_id).and_return(10)
        order.should_receive(:add_variant).with(@variant, 3)
        Merriweather_post :populate, {:order_id => 1, :products => {@variant.product_id => @variant.id}, :quantity => {@variant.id.to_s => 3}}
      end
    end
  end

  context "#update" do
    before {
      order.stub(:update_attributes).and_return true
      order.stub(:line_items).and_return([])
      order.stub(:line_items=).with([])
      Merriweather::Order.stub(:find_by_id).and_return(order)
    }
    it "should not result in a flash notice" do
      Merriweather_put :update, {}, {:order_id => 1}
      flash[:notice].should be_nil
    end
    it "should render the edit view (on failure)" do
      order.stub(:update_attributes).and_return false
      order.stub(:errors).and_return({:number => "has some error"})
      Merriweather_put :update, {}, {:order_id => 1}
      response.should render_template :edit
    end
    it "should redirect to cart path (on success)" do
      order.stub(:update_attributes).and_return true
      Merriweather_put :update, {}, {:order_id => 1}
      response.should redirect_to(Merriweather.cart_path)
    end
  end

  context "#empty" do
    it "should destroy line items in the current order" do
      controller.stub!(:current_order).and_return(order)
      order.should_receive(:empty!)
      Merriweather_put :empty
      response.should redirect_to(Merriweather.cart_path)
    end
  end

  #TODO - move some of the assigns tests based on session, etc. into a shared example group once new block syntax released
end
