require 'spec_helper'
require 'Merriweather/product_filters'

describe 'product filters' do
  # Regression test for #1709
  context 'finds products filtered by brand' do
    let(:product) { create(:product) }
    before do
      property = Merriweather::Property.create!(:name => "brand", :presentation => "brand")
      product.set_property("brand", "Nike")
    end

    it "does not attempt to call value method on Arel::Table" do
      lambda { Merriweather::ProductFilters.brand_filter }.should_not raise_error(NoMethodError)
    end

    it "can find products in the 'Nike' brand" do
      Merriweather::Product.brand_any("Nike").should include(product)
    end
  end
end
