class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :status
      t.integer :customer_id
      t.float :amount
      t.string :comment
      t.datetime :created
      
      t.timestamps
    end
  end
end
