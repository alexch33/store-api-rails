class AddOrderItemsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_items, :json, default: {}
  end
end
