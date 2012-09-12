FactoryGirl.define do
  factory :tracker, :class => Merriweather::Tracker do
    environment { Rails.env }
    analytics_id 'A100'
    active true
  end
end
