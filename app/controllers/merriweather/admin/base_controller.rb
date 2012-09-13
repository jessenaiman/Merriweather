module Merriweather
  module Admin
    class BaseController < Merriweather::BaseController
      ssl_required

      helper 'merriweather/admin/navigation'
      layout '/merriweather/layouts/admin'

      before_filter :check_alerts
      before_filter :authorize_admin

      protected
        def authorize_admin
          begin
            record = model_class.new
          rescue
            record = Object.new
          end
          authorize! :admin, record
          authorize! params[:action].to_sym, record
        end

        def check_alerts
          return unless should_check_alerts?

          unless session.has_key? :alerts
            begin
              session[:alerts] = Merriweather::Alert.current(request.host)
              filter_dismissed_alerts
              Merriweather::Config.set :last_check_for_Merriweather_alerts => DateTime.now.to_s
            rescue
              session[:alerts] = nil
            end
          end
        end

        def should_check_alerts?
          return false if !Rails.env.production? || !Merriweather::Config[:check_for_Merriweather_alerts]

          last_check = Merriweather::Config[:last_check_for_Merriweather_alerts]
          return true if last_check.blank?

          DateTime.parse(last_check) < 12.hours.ago
        end

        def flash_message_for(object, event_sym)
          resource_desc  = object.class.model_name.human
          resource_desc += " \"#{object.name}\"" if object.respond_to?(:name) && object.name.present?
          I18n.t(event_sym, :resource => resource_desc)
        end

        def render_js_for_destroy
          render :partial => '/merriweather/admin/shared/destroy'
        end

        # Index request for JSON needs to pass a CSRF token in order to prevent JSON Hijacking
        def check_json_authenticity
          return unless request.format.js? or request.format.json?
          return unless protect_against_forgery?
          auth_token = params[request_forgery_protection_token]
          unless (auth_token and form_authenticity_token == URI.unescape(auth_token))
            raise(ActionController::InvalidAuthenticityToken)
          end
        end

        def filter_dismissed_alerts
          return unless session[:alerts]
          dismissed = (Merriweather::Config[:dismissed_Merriweather_alerts] || '').split(',')
          session[:alerts].reject! { |a| dismissed.include? a.id.to_s }
        end
    end
  end
end