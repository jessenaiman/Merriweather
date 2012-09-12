FactoryGirl.define do
  factory :option_value, :class => Merriweather::OptionValue do
    name 'Size'
    presentation 'S'
    option_type
  end

  factory :option_type, :class => Merriweather::OptionType do
    name 'foo-size'
    presentation 'Size'
  end
end
