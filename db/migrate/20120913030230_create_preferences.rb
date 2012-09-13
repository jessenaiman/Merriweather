class CreatePreferences < ActiveRecord::Migration
  def up
  	create_table :preferences do |t|
      t.string     :name, :limit => 100
      t.references :owner, :polymorphic => true
      t.text       :value
      t.string     :key
      t.string     :value_type
      t.timestamps
    end

    add_index :preferences, [:key], :name => 'index_preferences_on_key', :unique => true
  end

  def down
  end
end
