FactoryGirl.define do
  factory :activator, :class => Merriweather::Activator do
    name 'Activator name'
    event_name 'spree.order.contents_changed'
    starts_at 2.weeks.ago
    expires_at 2.weeks.from_now
  end
end
