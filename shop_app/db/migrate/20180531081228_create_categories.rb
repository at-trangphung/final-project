class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :sort_order
      
      t.timestamps
    end
  end
end
