class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string :name
      t.float :price
      t.integer :quantity
      t.text :description
      t.integer :discount
      t.string :image_link
      t.integer :view
      
      t.timestamps
    end
    add_index :products, :name
    add_index :products, :price
  end
 end
