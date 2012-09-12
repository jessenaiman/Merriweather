FactoryGirl.define do
  factory :global_zone, :class => Merriweather::Zone do
    name 'GlobalZone'
    description { Faker::Lorem.sentence }
    zone_members do |proxy|
      zone = proxy.instance_eval { @instance }
      Merriweather::Country.all.map do |c|
        zone_member = Merriweather::ZoneMember.create(:zoneable => c, :zone => zone)
      end
    end
  end

  factory :zone, :class => Merriweather::Zone do
    name { Faker::Lorem.words }
    description { Faker::Lorem.sentence }
  end
end
