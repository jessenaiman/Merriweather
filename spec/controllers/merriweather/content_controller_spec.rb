require 'spec_helper'
describe Merriweather::ContentController do
  it "should not display a local file" do
    Merriweather_get :show, :path => "../../Gemfile"
    response.response_code.should == 404
  end

  it "should display CVV page" do
    Merriweather_get :cvv
    response.response_code.should == 200
  end
end
