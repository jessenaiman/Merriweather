# Configure merriweather Preferences
# 
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do: 
# config.setting_name = 'new value'
Merriweather.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "merriweather Demo Site"
end

Merriweather.user_class = <%= (options[:user_class] || "Merriweather::LegacyUser").inspect %>
