FactoryGirl.define do
  factory :prototype, :class => Merriweather::Prototype do
    name 'Baseball Cap'
    properties { [FactoryGirl.create(:property)] }
  end
end
