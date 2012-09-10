class CreateInventoryUnits < ActiveRecord::Migration
  def change
    create_table :inventory_units do |t|
      t.integer    :lock_version,        :default => 0
      t.string     :state
      t.references :variant
      t.references :order
      t.references :shipment
      t.references :return_authorization
      t.timestamps
    end

    add_index :inventory_units, [:order_id], :name => 'index_inventory_units_on_order_id'
    add_index :inventory_units, [:shipment_id], :name => 'index_inventory_units_on_shipment_id'
    add_index :inventory_units, [:variant_id], :name => 'index_inventory_units_on_variant_id'

    create_table :line_items do |t|
      t.references :variant
      t.references :order
      t.integer    :quantity,                               :null => false
      t.decimal    :price,    :precision => 8, :scale => 2, :null => false
      t.timestamps
    end

    add_index :line_items, [:order_id],   :name => 'index_line_items_on_order_id'
    add_index :line_items, [:variant_id], :name => 'index_line_items_on_variant_id'

    create_table :log_entries do |t|
      t.references :source, :polymorphic => true
      t.text     :details
      t.timestamps
    end
  end
end