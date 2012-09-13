module Merriweather
  module Admin
    class BannersController < Admin::BaseController
      def dismiss
        if request.xhr? and params[:id]
          if user = try_merriweather_current_user
            user.dismiss_banner(params[:id])
          end
          render :nothing => true
        end
      end
    end
  end
end
