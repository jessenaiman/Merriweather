require 'active_record/fixtures'

fixtures_dir = File.expand_path('../../../../../db/default', __FILE__)
ActiveRecord::Fixtures.create_fixtures(fixtures_dir, ['merriweather/countries', 'merriweather/zones', 'merriweather/zone_members', 'merriweather/states', 'merriweather/roles'])