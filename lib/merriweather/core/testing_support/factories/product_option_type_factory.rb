FactoryGirl.define do
  factory :product_option_type, :class => Merriweather::ProductOptionType do
    product { FactoryGirl.create(:product) }
    option_type { FactoryGirl.create(:option_type) }
  end
end
