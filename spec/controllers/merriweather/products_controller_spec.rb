require 'spec_helper'

describe Merriweather::ProductsController do
  let!(:product) { create(:product, :available_on => 1.year.from_now) }

  # Regression test for #1390
  it "allows admins to view non-active products" do
    controller.stub :Merriweather_current_user => stub(:has_Merriweather_role? => true, :last_incomplete_Merriweather_order => nil)
    Merriweather_get :show, :id => product.to_param
    response.status.should == 200
  end

  it "cannot view non-active products" do
    Merriweather_get :show, :id => product.to_param
    response.status.should == 404
  end
end
