FactoryGirl.define do
  factory :product_property, :class => Merriweather::ProductProperty do
    product { FactoryGirl.create(:product) }
    property { FactoryGirl.create(:property) }
  end
end
