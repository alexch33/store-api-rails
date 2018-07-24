class AddItemsAssociationToCategory < ActiveRecord::Migration[5.2]
  def self.up
    add_column :items, :category_id, :integer
    add_index 'items', ['category_id'], :name => 'index_category_id'
  end

  def self.down
    remove_column :items, :category_id
  end
end
