# This module exists so that controllers that don't inherit from Merriweather::BaseController
# Can still inherit the important bits of functionality and use the Merriweather layout by default.
module Merriweather
  module Core
    module ControllerHelpers
      def self.included(base)
        base.class_eval do
          include Merriweather::Core::CurrentOrder
          include Merriweather::Core::RespondWith
          include SslRequirement

          helper_method :title
          helper_method :title=
          helper_method :accurate_title
          helper_method :current_order
          helper_method :try_merriweather_current_user

          before_filter :set_user_language
          before_filter :set_current_order

          rescue_from CanCan::AccessDenied do |exception|
            return unauthorized
          end

          layout :get_layout
        end
      end
      # can be used in views as well as controllers.
      # e.g. <% title = 'This is a custom title for this view' %>
      attr_writer :title

      # proxy method to *possible* merriweather_current_user method
      # Authentication extensions (such as merriweather_auth_devise) are meant to provide merriweather_current_user
      def try_merriweather_current_user
        respond_to?(:merriweather_current_user) ? merriweather_current_user : nil
      end

      def title
        title_string = @title.present? ? @title : accurate_title
        if title_string.present?
          if Merriweather::Config[:always_put_site_name_in_title]
            [title_string, default_title].join(' - ')
          else
            title_string
          end
        else
          default_title
        end
      end

      def associate_user
        if try_merriweather_current_user && @order
          if @order.user.blank? || @order.email.blank?
            @order.associate_user!(try_merriweather_current_user)
          end
        end

        # This will trigger any "first order" promotions to be triggered
        # Assuming of course that this session variable was set correctly in
        # the authentication provider's registrations controller
        if session[:merriweather_user_signup]
          fire_event('merriweather.user.signup', :user => try_merriweather_current_user, :order => current_order(true))
        end

        session[:guest_token] = nil
        session[:merriweather_user_signup] = nil
      end

      protected

      def set_current_order
        if user = try_merriweather_current_user
          last_incomplete_order = user.last_incomplete_merriweather_order
          if session[:order_id].nil? && last_incomplete_order
            session[:order_id] = last_incomplete_order.id
          elsif current_order && last_incomplete_order && current_order != last_incomplete_order
            current_order.merge!(last_incomplete_order)
          end
        end
      end

      # Needs to be overriden so that we use Merriweather's Ability rather than anyone else's.
      def current_ability
        @current_ability ||= Merriweather::Ability.new(try_merriweather_current_user)
      end

      def store_location
        # disallow return to login, logout, signup pages
        authentication_routes = [:merriweather_signup_path, :merriweather_login_path, :merriweather_logout_path]
        disallowed_urls = []
        authentication_routes.each do |route|
          if respond_to?(route)
            disallowed_urls << send(route)
          end
        end

        disallowed_urls.map!{ |url| url[/\/\w+$/] }
        unless disallowed_urls.include?(request.fullpath)
          session['user_return_to'] = request.fullpath.gsub('//', '/')
        end
      end
      # Redirect as appropriate when an access request fails.  The default action is to redirect to the login screen.
      # Override this method in your controllers if you want to have special behavior in case the user is not authorized
      # to access the requested action.  For example, a popup window might simply close itself.
      def unauthorized
        respond_to do |format|
          format.html do
            if try_merriweather_current_user
              flash.now[:error] = t(:authorization_failure)
              render 'merriweather/shared/unauthorized', :layout => Merriweather::Config[:layout], :status => 401
            else
              store_location
              url = respond_to?(:merriweather_login_path) ? merriweather_login_path : root_path
              redirect_to url
            end
          end
          format.xml do
            request_http_basic_authentication 'Web Password'
          end
          format.json do
            render :text => "Not Authorized \n", :status => 401
          end
        end
      end


      def default_title
        Merriweather::Config[:site_name]
      end

      # this is a hook for subclasses to provide title
      def accurate_title
        Merriweather::Config[:default_seo_title]
      end

      def render_404(exception = nil)
        respond_to do |type|
          type.html { render :status => :not_found, :file    => "#{::Rails.root}/public/404", :formats => [:html], :layout => nil}
          type.all  { render :status => :not_found, :nothing => true }
        end
      end

      # Convenience method for firing instrumentation events with the default payload hash
      def fire_event(name, extra_payload = {})
        ActiveSupport::Notifications.instrument(name, default_notification_payload.merge(extra_payload))
      end

      # Creates the hash that is sent as the payload for all notifications. Specific notifications will
      # add additional keys as appropriate. Override this method if you need additional data when
      # responding to a notification
      def default_notification_payload
        {:user => try_merriweather_current_user, :order => current_order}
      end

      private

      def redirect_back_or_default(default)
        redirect_to(session["user_return_to"] || default)
        session["user_return_to"] = nil
      end

      def set_user_language
        locale = session[:locale]
        locale ||= Rails.application.config.i18n.default_locale
        if locale.blank? || !I18n.available_locales.include?(locale.to_sym)
          locale ||= I18n.default_locale
        end
        I18n.locale = locale.to_sym
      end

      # Returns which layout to render.
      # 
      # You can set the layout you want to render inside your Merriweather configuration with the +:layout+ option.
      # 
      # Default layout is: +app/views/merriweather/layouts/merriweather_application+
      # 
      def get_layout
        layout ||= Merriweather::Config[:layout]
      end


    end
  end
end

