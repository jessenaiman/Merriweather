FactoryGirl.define do
  factory :taxon, :class => Merriweather::Taxon do
    name 'Ruby on Rails'
    taxonomy { FactoryGirl.create(:taxonomy) }
    parent_id nil
  end
end
