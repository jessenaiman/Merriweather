class CreateShippingMethods < ActiveRecord::Migration
      def change

            create_table :shipping_categories do |t|
                  t.string   :name
                  t.timestamps
            end

            create_table :shipping_methods do |t|
                  t.string     :name
                  t.references :zone
                  t.string     :display_on
                  t.references :shipping_category
                  t.boolean    :match_none
                  t.boolean    :match_all
                  t.boolean    :match_one
                  t.datetime   :deleted_at
                  t.timestamps
            end
      end
end