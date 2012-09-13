#module Merriweather
  module Admin
    class GeneralSettingsController < Admin::BaseController
      def show
        @preferences = ['site_name', 'default_seo_title', 'default_meta_keywords',
                        'default_meta_description', 'site_url']
      end

      def edit
        @preferences = [:site_name, :default_seo_title, :default_meta_keywords,
                        :default_meta_description, :site_url, :allow_ssl_in_production,
                        :allow_ssl_in_staging, :allow_ssl_in_development_and_test,
                        :check_for_merriweather_alerts, :display_currency]
      end

      def update
        params.each do |name, value|
          next unless Merriweather::Config.has_preference? name
          Merriweather::Config[name] = value
        end

        redirect_to admin_general_settings_path
      end

      def dismiss_alert
        if request.xhr? and params[:alert_id]
          dismissed = Merriweather::Config[:dismissed_merriweather_alerts] || ''
          Merriweather::Config.set :dismissed_merriweather_alerts => dismissed.split(',').push(params[:alert_id]).join(',')
          filter_dismissed_alerts
          render :nothing => true
        end
      end
    end
  end
#end
