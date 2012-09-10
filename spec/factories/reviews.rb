# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    name "MyString"
    content "MyString"
    artist nil
  end
end
