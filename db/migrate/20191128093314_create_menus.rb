class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.date :menu_date

      t.timestamps
    end
    add_index :menus, :menu_date
  end
end
