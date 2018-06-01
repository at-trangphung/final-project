class CreateProductOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :product_options do |t|
      t.belongs_to :products
      t.belongs_to :sizes
      t.belongs_to :types
      
      t.timestamps
    end
  end
end
