require 'spec_helper'

describe Merriweather::Taxonomy do
  context "#destroy" do
    before do
       @taxonomy = create(:taxonomy)
       @root_taxon = @taxonomy.root
       @child_taxon = create(:taxon, :taxonomy_id => @taxonomy.id, :parent => @root_taxon)
    end

    it "should destroy all associated taxons" do
      @taxonomy.destroy
      expect{ Merriweather::Taxon.find(@root_taxon.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Merriweather::Taxon.find(@child_taxon.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

