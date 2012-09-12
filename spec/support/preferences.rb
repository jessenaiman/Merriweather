# Resets all preferences to default values, you can 
# pass a block to override the defaults with a block
#
# reset_Merriweather_preferences do |config|
#   config.site_name = "my fancy pants store"
# end
#
def reset_Merriweather_preferences
  Merriweather::Preferences::Store.instance.persistence = false
  config = Rails.application.config.Merriweather.preferences
  config.reset
  yield(config) if block_given?
end

