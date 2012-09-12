FactoryGirl.define do
  factory :state, :class => Merriweather::State do
    name 'Alabama'
    abbr 'AL'
    country do |country|
      if usa = Merriweather::Country.find_by_numcode(840)
        country = usa
      else
        country.association(:country)
      end
    end
  end
end
