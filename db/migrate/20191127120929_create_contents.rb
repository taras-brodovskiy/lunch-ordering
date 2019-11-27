class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.references :order, foreign_key: true
      t.integer :first_course_id
      t.integer :main_course_id
      t.integer :drink_id

      t.timestamps
    end
  end
end
