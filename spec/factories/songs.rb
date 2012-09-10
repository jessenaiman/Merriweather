# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    name "MyString"
    mp3 "MyString"
    ogg "MyString"
    album nil
  end
end
