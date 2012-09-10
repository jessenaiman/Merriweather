class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string      :name
      t.string      :heading
      t.string      :image
      t.string      :content
      t.string      :gemm
      t.string      :permalink
      t.string      :meta_description
      t.string      :meta_keywords
      t.date        :available_on
      t.datetime    :deleted_at
      t.references  :band
      t.references  :genre
      t.references  :product_type
      
      t.timestamps
    end
    add_index :products, :band_id
    add_index :products, :genre_id
    add_index :products, :product_type_id

    add_index :spree_products, [:available_on], :name => 'index_spree_products_on_available_on'
    add_index :spree_products, [:deleted_at],   :name => 'index_spree_products_on_deleted_at'
    add_index :spree_products, [:name],         :name => 'index_spree_products_on_name'
    add_index :spree_products, [:permalink],    :name => 'index_spree_products_on_permalink'
  end
end
