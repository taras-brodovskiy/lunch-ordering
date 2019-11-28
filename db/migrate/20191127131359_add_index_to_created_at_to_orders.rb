class AddIndexToCreatedAtToOrders < ActiveRecord::Migration[5.2]
  def change
    add_index :orders, :created_at
  end
end