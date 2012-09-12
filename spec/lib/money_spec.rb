require 'spec_helper'

module Merriweather
  describe Money do
    before do
      reset_Merriweather_preferences do |config|
        config.currency = "USD"
        config.currency_symbol_position = :before
        config.display_currency = false
      end
    end

    it "formats correctly" do
      money = Merriweather::Money.new(10)
      money.to_s.should == "$10.00"
    end

    context "with currency" do
      it "passed in option" do
        money = Merriweather::Money.new(10, :with_currency => true)
        money.to_s.should == "$10.00 USD"
      end

      it "config option" do
        Merriweather::Config[:display_currency] = true
        money = Merriweather::Money.new(10)
        money.to_s.should == "$10.00 USD"
      end
    end

    context "symbol positioning" do
      it "passed in option" do
        money = Merriweather::Money.new(10, :symbol_position => :after)
        money.to_s.should == "10.00 $"
      end

      it "passed in option string" do
        money = Merriweather::Money.new(10, :symbol_position => "after")
        money.to_s.should == "10.00 $"
      end

      it "config option" do
        Merriweather::Config[:currency_symbol_position] = :after
        money = Merriweather::Money.new(10)
        money.to_s.should == "10.00 $"
      end
    end
  end
end
