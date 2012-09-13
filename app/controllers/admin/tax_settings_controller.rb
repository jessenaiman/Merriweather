#module Merriweather
  module Admin
    class TaxSettingsController < Admin::BaseController

      def update
        Merriweather::Config.set(params[:preferences])

        respond_to do |format|
          format.html {
            redirect_to admin_tax_settings_path
          }
        end
      end

    end
  end
#end
