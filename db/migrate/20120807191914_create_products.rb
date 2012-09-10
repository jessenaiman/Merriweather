class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string      :name
      t.string      :heading
      t.string      :image
      t.string      :content
      t.string      :gemm
      t.references  :band
      t.references  :genre
      t.references  :product_type
      t.datetime    :available_on
      t.datetime    :deleted_at
      t.string      :permalink
      t.string      :meta_description
      t.string      :meta_keywords
      t.references  :tax_category
      t.references  :shipping_category
      t.integer     :count_on_hand,        :default => 0,  :null => false
      
      t.timestamps
    end
    add_index :products, :band_id
    add_index :products, :genre_id
    add_index :products, :product_type_id

    add_index :products, [:available_on], :name => 'index_products_on_available_on'
    add_index :products, [:deleted_at],   :name => 'index_products_on_deleted_at'
    add_index :products, [:name],         :name => 'index_products_on_name'
    add_index :products, [:permalink],    :name => 'index_products_on_permalink'
  end
end
