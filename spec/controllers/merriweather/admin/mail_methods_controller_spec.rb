require 'spec_helper'

describe Merriweather::Admin::MailMethodsController do
  stub_authorization!

  let(:order) { mock_model(Merriweather::Order, :complete? => true).as_null_object }
  let(:mail_method) { mock_model(Merriweather::MailMethod).as_null_object }

  before do
    Merriweather::Order.stub :find => order
    Merriweather::MailMethod.stub :find => mail_method
    request.env["HTTP_REFERER"] = "/"
  end

  context "#create" do
    it "should reinitialize the mail settings" do
      Merriweather::Core::MailSettings.should_receive :init
      Merriweather_put :create, {:order_id => "123", :id => "456", :mail_method_parmas => {:environment => "foo"}}
    end
  end

  context "#update" do
    it "should reinitialize the mail settings" do
      Merriweather::Core::MailSettings.should_receive :init
      Merriweather_put :update, {:order_id => "123", :id => "456", :mail_method_params => {:environment => "foo"}}
    end
  end

  it "can trigger testmail without current_user" do
    Merriweather_post :testmail, :id => create(:mail_method).id
    flash[:error].should_not include("undefined local variable or method `current_user'")
  end
end
