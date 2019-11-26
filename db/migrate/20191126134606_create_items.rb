class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.string :type
      t.string :picture

      t.timestamps
    end
  end
end
