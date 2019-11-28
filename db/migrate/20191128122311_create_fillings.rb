class CreateFillings < ActiveRecord::Migration[5.2]
  def change
    create_table :fillings do |t|
      t.references :menu, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
    add_index :fillings, [:menu_id, :item_id], unique: true
  end
end
