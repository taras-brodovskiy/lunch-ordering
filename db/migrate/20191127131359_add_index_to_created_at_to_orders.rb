class AddIndexToCreatedAtToOrders < ActiveRecord::Migration[5.2]
  def change
    add_index :orders, :created_at
    add_index :orders, :order_date
    add_index :orders, [:order_date, :user_id], unique: true
  end
end
