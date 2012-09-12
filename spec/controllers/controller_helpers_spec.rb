require 'spec_helper'

# In this file, we want to test that the controller helpers function correctly
# So we need to use one of the controllers inside Merriweather.
# ProductsController is good.
describe Merriweather::ProductsController do

  before do
    I18n.stub(:available_locales => [:en, :de])
    Rails.application.config.i18n.default_locale = :de
  end

  after do
    Rails.application.config.i18n.default_locale = :en
    I18n.locale = :en
  end

  # Regression test for #1184
  it "sets the default locale based off config.i18n.default_locale" do
    I18n.locale.should == :en
    Merriweather_get :index
    I18n.locale.should == :de
  end
end
