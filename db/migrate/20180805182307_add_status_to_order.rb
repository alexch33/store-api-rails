class AddStatusToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_status, :string, default: 'PENDING'
  end
end
