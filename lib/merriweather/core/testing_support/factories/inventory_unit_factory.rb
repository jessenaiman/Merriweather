FactoryGirl.define do
  factory :inventory_unit, :class => Merriweather::InventoryUnit do
    variant { FactoryGirl.create(:variant) }
    order { FactoryGirl.create(:order) }
    state 'sold'
    shipment { FactoryGirl.create(:shipment, :state => 'pending') }
    #return_authorization { FactoryGirl.create(:return_authorization) }
  end
end
