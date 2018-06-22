class AddDefaultColumnStatusToTransaction < ActiveRecord::Migration[5.1]
  def change
    change_column_default :transactions, :status, default: 0
  end
end
