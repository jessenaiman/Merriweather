require 'spec_helper'

describe Merriweather::State do
  before(:all) do
    Merriweather::State.destroy_all
  end

  it "can find a state by name or abbr" do
    state = create(:state, :name => "California", :abbr => "CA")
    Merriweather::State.find_all_by_name_or_abbr("California").should include(state)
    Merriweather::State.find_all_by_name_or_abbr("CA").should include(state)
  end

  it "can find all states group by country id" do
    state = create(:state)
    Merriweather::State.states_group_by_country_id.should == { state.country_id.to_s => [[state.id, state.name]] }
  end
end
