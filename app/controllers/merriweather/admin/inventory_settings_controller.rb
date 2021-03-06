module Merriweather
  module Admin
    class InventorySettingsController < Admin::BaseController

      def update
        Config.set(params[:preferences])

        respond_to do |format|
          format.html {
            redirect_to admin_inventory_settings_path
          }
        end
      end
    end
  end

end
