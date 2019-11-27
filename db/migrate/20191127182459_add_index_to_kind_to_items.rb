class AddIndexToKindToItems < ActiveRecord::Migration[5.2]
  def change
    add_index :items, :kind
  end
end
