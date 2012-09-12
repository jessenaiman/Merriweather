# Merriweather's rpsec controller tests get the Merriweather::ControllerHacks
# we don't need those for the anonymous controller here, so
# we call process directly instead of get
require 'spec_helper'

describe Merriweather::Admin::BaseController do

  controller(Merriweather::Admin::BaseController) do
    def index
      render :text => 'test'
    end
  end

  describe "check alerts" do
    it "checks alerts with before_filter" do
      controller.should_receive :check_alerts
      process :index
    end

    it "saves alerts into session" do
      controller.stub(:should_check_alerts? => true)
      Merriweather::Alert.should_receive(:current).and_return([Merriweather::Alert.new(:message => "test alert", :severity => 'release')])
      process :index
      session[:alerts].first.message.should eq "test alert"
    end

    describe "should_check_alerts?" do
      before do
        Rails.env.stub(:production? => true)
        Merriweather::Config[:check_for_Merriweather_alerts] = true
        Merriweather::Config[:last_check_for_Merriweather_alerts] = nil
      end

      it "only checks alerts if production and preference is true" do
        controller.send(:should_check_alerts?).should be_true
      end

      it "only checks for production" do
        Rails.env.stub(:production? => false)
        controller.send(:should_check_alerts?).should be_false
      end

      it "only checks if preference is true" do
        Merriweather::Config[:check_for_Merriweather_alerts] = false
        controller.send(:should_check_alerts?).should be_false
      end
    end
  end
end
