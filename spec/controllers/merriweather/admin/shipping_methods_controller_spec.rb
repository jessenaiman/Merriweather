require 'spec_helper'

describe Merriweather::Admin::ShippingMethodsController do
  stub_authorization!
  
  # Regression test for #1240
  it "should not hard-delete shipping methods" do
    Merriweather::ShippingMethod.should_receive(:find).and_return(shipping_method = stub_model(Merriweather::ShippingMethod))
    shipping_method.should_not_receive(:destroy)
    shipping_method.deleted_at.should be_nil
    Merriweather_delete :destroy, :id => 1
    shipping_method.deleted_at.should_not be_nil
  end
end
