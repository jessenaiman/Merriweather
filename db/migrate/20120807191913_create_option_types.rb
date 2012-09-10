class CreateOptionTypes < ActiveRecord::Migration
  def change

    create_table :option_types do |t|
      t.string    :name,         :limit => 100
      t.string    :presentation, :limit => 100
      t.integer   :position,                   :default => 0, :null => false
      t.timestamps
    end

    create_table :option_types_prototypes, :id => false do |t|
      t.references :prototype
      t.references :option_type
    end

    create_table :option_values do |t|
      t.integer    :position
      t.string     :name
      t.string     :presentation
      t.references :option_type
      t.timestamps
    end

    create_table :option_values_variants, :id => false do |t|
      t.references :variant
      t.references :option_value
    end

    add_index :option_values_variants, [:variant_id, :option_value_id], :name => 'index_option_values_variants_on_variant_id_and_option_value_id'
    add_index :option_values_variants, [:variant_id], :name => 'index_option_values_variants_on_variant_id'
  end
end