class CreateTaxons < ActiveRecord::Migration
  def up
  	create_table :product_properties do |t|
      t.string     :value
      t.references :product
      t.references :property
      t.timestamps
    end

    add_index :product_properties, [:product_id], :name => 'index_product_properties_on_product_id'

    create_table :products_taxons, :id => false do |t|
      t.references :product
      t.references :taxon
    end

    add_index :products_taxons, [:product_id], :name => 'index_products_taxons_on_product_id'
    add_index :products_taxons, [:taxon_id],   :name => 'index_products_taxons_on_taxon_id'

    create_table :properties do |t|
      t.string     :name
      t.string     :presentation, :null => false
      t.timestamps
    end

    create_table :properties_prototypes, :id => false do |t|
      t.references :prototype
      t.references :property
    end

    create_table :prototypes do |t|
      t.string     :name
      t.timestamps
    end

    create_table :taxonomies do |t|
      t.string     :name, :null => false
      t.timestamps
    end

    create_table :taxons do |t|
      t.references :parent
      t.integer    :position,          :default => 0
      t.string     :name,                             :null => false
      t.string     :permalink
      t.references :taxonomy
      t.integer    :lft
      t.integer    :rgt
      t.string     :icon_file_name
      t.string     :icon_content_type
      t.integer    :icon_file_size
      t.datetime   :icon_updated_at
      t.text       :description
      t.timestamps
    end

    add_index :taxons, [:parent_id],   :name => 'index_taxons_on_parent_id'
    add_index :taxons, [:permalink],   :name => 'index_taxons_on_permalink'
    add_index :taxons, [:taxonomy_id], :name => 'index_taxons_on_taxonomy_id'

    create_table :variants do |t|
      t.string     :sku,                                         :default => '',    :null => false
      t.decimal    :price,         :precision => 8, :scale => 2,                    :null => false
      t.decimal    :weight,        :precision => 8, :scale => 2
      t.decimal    :height,        :precision => 8, :scale => 2
      t.decimal    :width,         :precision => 8, :scale => 2
      t.decimal    :depth,         :precision => 8, :scale => 2
      t.datetime   :deleted_at
      t.boolean    :is_master,                                   :default => false
      t.references :product
      t.integer    :count_on_hand,                               :default => 0,     :null => false
      t.decimal    :cost_price,    :precision => 8, :scale => 2
      t.integer    :position
    end

    add_index :variants, [:product_id], :name => 'index_variants_on_product_id'
  end

  def down
  end
end
