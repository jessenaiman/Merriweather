require 'spec_helper'

describe Merriweather::Core::MailSettings do
  let(:mail_method) { Merriweather::MailMethod.new(:environment => "test") }

  context "init" do
    before { Merriweather::MailMethod.stub :current => mail_method }

    context "perform_delivery preference" do
      it "should override the application defaults" do
        mail_method.set_preference(:enable_mail_delivery, false)
        Merriweather::Core::MailSettings.init
        ActionMailer::Base.perform_deliveries.should be_false
        mail_method.set_preference(:enable_mail_delivery, true)
      end
    end

    context "when delivery is true" do
      before { mail_method.set_preference(:enable_mail_delivery, true) }

      context "when mail_auth_type is other than none" do
        before { mail_method.set_preference(:mail_auth_type, "login") }

        context "mail_auth_type preference" do
          it "should override the application defaults" do
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:authentication].should == "login"
          end
        end

        context "mail_host preference" do
          it "should override the application defaults" do
            mail_method.set_preference(:mail_host, "smtp.example.com")
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:address].should == "smtp.example.com"
          end
        end

        context "mail_domain preference" do
          it "should override the application defaults" do
            mail_method.set_preference(:mail_domain, "example.com")
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:domain].should == "example.com"
          end
        end

        context "mail_port preference" do
          it "should override the application defaults" do
            mail_method.set_preference(:mail_port, 123)
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:port].should == 123
          end
        end

        context "smtp_username preference" do
          it "should override the application defaults" do
            mail_method.set_preference(:smtp_username, "schof")
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:user_name].should == "schof"
          end
        end

        context "smtp_password preference" do
          it "should override the application defaults" do
            mail_method.set_preference(:smtp_password, "helloMerriweather!")
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:password].should == "helloMerriweather!"
          end
        end

        context "secure_connection_type preference" do
          it "should override the application defaults" do
            mail_method.set_preference(:secure_connection_type, "TLS")
            Merriweather::Core::MailSettings.init
            ActionMailer::Base.smtp_settings[:enable_starttls_auto].should be_true
          end
        end
      end
    end

  end
end
