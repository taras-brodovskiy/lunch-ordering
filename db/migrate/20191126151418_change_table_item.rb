class ChangeTableItem < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.remove :type
    end
  end
end
