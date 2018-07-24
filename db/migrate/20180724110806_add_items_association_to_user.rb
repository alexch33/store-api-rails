class AddItemsAssociationToUser < ActiveRecord::Migration[5.2]
  def self.up
    add_column :items, :user_id, :integer
    add_index 'items', ['user_id'], :name => 'index_user_id'
  end

  def self.down
    remove_column :items, :user_id
  end
end
