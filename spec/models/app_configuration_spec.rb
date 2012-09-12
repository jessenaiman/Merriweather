require 'spec_helper'

describe Merriweather::AppConfiguration do

  let (:prefs) { Rails.application.config.Merriweather.preferences }

  it "should be available from the environment" do
    prefs.site_name = "TEST SITE NAME"
    prefs.site_name.should eq "TEST SITE NAME"
  end

  it "should be available as Merriweather::Config for legacy access" do
    Merriweather::Config.site_name = "Merriweather::Config TEST SITE NAME"
    Merriweather::Config.site_name.should eq "Merriweather::Config TEST SITE NAME"
  end

  it "uses base searcher class by default" do
    prefs.searcher_class = nil
    prefs.searcher_class.should eq Merriweather::Core::Search::Base
  end

end

