require 'spec_helper'

describe Merriweather::PaymentMethod do
  describe "#available" do
    before(:all) do
      Merriweather::PaymentMethod.delete_all

      [nil, 'both', 'front_end', 'back_end'].each do |display_on|
        Merriweather::Gateway::Test.create({:name => 'Display Both', :display_on => display_on,
           :active => true, :environment => 'test', :description => 'foofah'}, :without_protection => true)
      end
      Merriweather::PaymentMethod.all.size.should == 4
    end

    it "should return all methods available to front-end/back-end when no parameter is passed" do
      Merriweather::PaymentMethod.available.size.should == 2
    end

    it "should return all methods available to front-end/back-end when display_on = :both" do
      Merriweather::PaymentMethod.available(:both).size.should == 2
    end

    it "should return all methods available to front-end when display_on = :front_end" do
      Merriweather::PaymentMethod.available(:front_end).size.should == 2
    end

    it "should return all methods available to back-end when display_on = :back_end" do
      Merriweather::PaymentMethod.available(:back_end).size.should == 2
    end
  end

end
