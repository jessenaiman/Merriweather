require 'spec_helper'

describe Merriweather::MailMethod do
  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Merriweather::MailMethod.create(:environment => "test")
      Merriweather::MailMethod.current.should == method
    end
  end

  context "valid?" do
    it "should be false when missing an environment value" do
      method = Merriweather::MailMethod.new
      method.valid?.should be_false
    end
    it "should be valid if it has an environment" do
      method = Merriweather::MailMethod.new(:environment => "foo")
      method.valid?.should be_true
    end
  end
end
