FactoryGirl.define do
  factory :configuration, :class => Merriweather::Configuration do
    name 'Default Configuration'
    type 'app_configuration'
  end
end
