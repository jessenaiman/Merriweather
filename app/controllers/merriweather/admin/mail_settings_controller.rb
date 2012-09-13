module Merriweather
  module Admin
    class MailSettingsController < Admin::BaseController

      def update
        Merriweather::Config.set(params[:preferences])
        Merriweather::Preferences::MailSettings.init

        respond_to do |format|
          format.html {
            redirect_to admin_mail_settings_path
          }
        end
      end
    end
  end
end