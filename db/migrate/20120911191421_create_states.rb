class CreateStates < ActiveRecord::Migration
  def up
    create_table :state_changes do |t|
      t.string     :name
      t.string     :previous_state
      t.references :stateful
      t.references :user
      t.string     :stateful_type
      t.string     :next_state
      t.timestamps
    end

    create_table :states do |t|
      t.string     :name
      t.string     :abbr
      t.references :country
    end
  end

  def down
  end
end
