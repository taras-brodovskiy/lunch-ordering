class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :price, precision: 8, scale: 2
      t.date  :order_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  
  end
end
