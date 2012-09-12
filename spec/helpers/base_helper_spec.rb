require 'spec_helper'

describe Merriweather::BaseHelper do
  include Merriweather::BaseHelper

  context "available_countries" do
    let(:country) { create(:country) }

    before do
      3.times { create(:country) }
    end

    context "with no checkout zone defined" do
      before do
        Merriweather::Config[:checkout_zone] = nil
      end

      it "return complete list of countries" do
        available_countries.count.should == Merriweather::Country.count
      end
    end

    context "with a checkout zone defined" do
      context "checkout zone is of type country" do
        before do
          @country_zone = create(:zone, :name => "CountryZone")
          @country_zone.members.create(:zoneable => country)
          Merriweather::Config[:checkout_zone] = @country_zone.name
        end

        it "return only the countries defined by the checkout zone" do
          available_countries.should == [country]
        end
      end

      context "checkout zone is of type state" do
        before do
          state_zone = create(:zone, :name => "StateZone")
          state = create(:state, :country => country)
          state_zone.members.create(:zoneable => state)
          Merriweather::Config[:checkout_zone] = state_zone.name
        end

        it "return complete list of countries" do
          available_countries.count.should == Merriweather::Country.count
        end
      end
    end
  end

  # Regression test for #889
  context "seo_url" do
    let(:taxon) { stub(:permalink => "bam") }
    it "provides the correct URL" do
      seo_url(taxon).should == "/t/bam"
    end
  end

  # Regression test for #1436
  context "defining custom image helpers" do
    let(:product) { mock_model(Merriweather::Product, :images => []) }
    before do
      Merriweather::Image.class_eval do
        attachment_definitions[:attachment][:styles].merge!({:very_strange => '1x1'})
      end
    end

    it "should not raise errors when style exists" do
      lambda { very_strange_image(product) }.should_not raise_error
    end

    it "should raise NoMethodError when style is not exists" do
      lambda { another_strange_image(product) }.should raise_error(NoMethodError)
    end

  end
end
