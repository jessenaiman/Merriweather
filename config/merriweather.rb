require 'mail'

# merriweather Configuration
SESSION_KEY = '_merriweather_session_id'

LIKE = ActiveRecord::Base.connection.adapter_name == 'PostgreSQL' ? 'ILIKE' : 'LIKE'
