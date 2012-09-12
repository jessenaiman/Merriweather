FactoryGirl.define do
  sequence(:shipping_category_sequence) { |n| "ShippingCategory ##{n}" }

  factory :shipping_category, :class => Merriweather::ShippingCategory do
    name { FactoryGirl.generate :shipping_category_sequence }
  end
end
