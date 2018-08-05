class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.bigint :client_id
      t.bigint :seller_id
      t.float :order_price

      t.timestamps
    end
  end
end
