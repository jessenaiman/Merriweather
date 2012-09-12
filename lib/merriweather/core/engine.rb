module Merriweather
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Merriweather
      engine_name 'spree'

      config.middleware.use "Merriweather::Core::Middleware::SeoAssist"
      config.middleware.use "Merriweather::Core::Middleware::RedirectLegacyProductUrl"

      config.autoload_paths += %W(#{config.root}/lib)

      def self.activate
      end

      config.to_prepare &method(:activate).to_proc

      config.after_initialize do
        ActiveSupport::Notifications.subscribe(/^spree\./) do |*args|
          event_name, start_time, end_time, id, payload = args
          Activator.active.event_name_starts_with(event_name).each do |activator|
            payload[:event_name] = event_name
            activator.activate(payload)
          end
        end
      end

      # We need to reload the routes here due to how Merriweather sets them up.
      # The different facets of Merriweather (auth, promo, etc.) append/prepend routes to Core
      # *after* Core has been loaded.
      #
      # So we wait until after initialization is complete to do one final reload.
      # This then makes the appended/prepended routes available to the application.
      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end


      initializer "spree.environment", :before => :load_config_initializers do |app|
        app.config.spree = Merriweather::Core::Environment.new
        Merriweather::Config = app.config.spree.preferences #legacy access
      end

      initializer "spree.load_preferences", :before => "spree.environment" do
        ::ActiveRecord::Base.send :include, Merriweather::Preferences::Preferable
      end

      initializer "spree.register.calculators" do |app|
        app.config.spree.calculators.shipping_methods = [
            Merriweather::Calculator::FlatPercentItemTotal,
            Merriweather::Calculator::FlatRate,
            Merriweather::Calculator::FlexiRate,
            Merriweather::Calculator::PerItem,
            Merriweather::Calculator::PriceSack]

         app.config.spree.calculators.tax_rates = [
            Merriweather::Calculator::DefaultTax]
      end

      initializer "spree.register.payment_methods" do |app|
        app.config.spree.payment_methods = [
            Merriweather::Gateway::Bogus,
            Merriweather::Gateway::BogusSimple,
            Merriweather::PaymentMethod::Check ]
      end

      # filter sensitive information during logging
      initializer "spree.params.filter" do |app|
        app.config.filter_parameters += [:password, :password_confirmation, :number]
      end

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer "spree.assets.precompile", :group => :all do |app|
        app.config.assets.precompile += %w[
          store/all.*
          admin/all.*
          admin/orders/edit_form.js
          admin/address_states.js
          jqPlot/excanvas.min.js
          admin/images/new.js
          jquery.jstree/themes/apple/*
        ]
      end

      initializer "spree.mail.settings" do |app|
        if Merriweather::MailMethod.table_exists?
          Merriweather::Core::MailSettings.init
          Mail.register_interceptor(Merriweather::Core::MailInterceptor)
        end
      end
    end
  end
end
