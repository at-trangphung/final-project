class AddColumnReceiverIdAndDeliveryTimeToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :receiver_id, :int
    add_column :transactions, :delivery_time, :datetime
  end
end
