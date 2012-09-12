FactoryGirl.define do
  factory :payment_method, :class => Merriweather::PaymentMethod::Check do
    name 'Check'
    environment 'test'
    #display_on :front_end
  end

  factory :bogus_payment_method, :class => Merriweather::Gateway::Bogus do
    name 'Credit Card'
    environment 'test'
    #display_on :front_end
  end

  # authorize.net was moved to spree_gateway. Leaving this factory
  # in place with bogus in case anyone is using it
  factory :authorize_net_payment_method, :class => Merriweather::Gateway::BogusSimple do
    name 'Credit Card'
    environment 'test'
    #display_on :front_end
  end
end
