FactoryGirl.define do
  sequence :user_authentication_token do |n|
    "xxxx#{Time.now.to_i}#{rand(1000)}#{n}xxxxxxxxxxxxx"
  end

  factory :user, :class => Merriweather.user_class do
    email { Faker::Internet.email }
    login { email }
    password 'secret'
    password_confirmation 'secret'
    authentication_token { FactoryGirl.generate(:user_authentication_token) } if Merriweather.user_class.attribute_method? :authentication_token
  end

  factory :admin_user, :parent => :user do
    spree_roles { [Merriweather::Role.find_by_name('admin') || FactoryGirl.create(:role, :name => 'admin')] }
  end
end
