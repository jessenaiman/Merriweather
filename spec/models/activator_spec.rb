require 'spec_helper'

describe Merriweather::Activator do

  context "event_names" do
    specify { Merriweather::Activator.event_names.is_a?(Array) }
    specify { Merriweather::Activator.event_names.all?{|n| n.is_a?(String)} }
  end

  context "register_event_name" do
    it "adds the name to event_names" do
      Merriweather::Activator.register_event_name('Merriweather.new_event')
      Merriweather::Activator.event_names.should include('Merriweather.new_event')
    end
  end

end
