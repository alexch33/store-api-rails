class Order < ApplicationRecord
  def details
   customer = User.where(id: self[:client_id]).first
   seller = User.where(id: self[:seller_id]).first
   self.order_items.map do |item|
     original = Item.where(id: item['item_id']).first
     {
         item_id: item['item_id'],
         item_title: original[:title],
         item_raiting: original[:rating],
         item_price: item['price'],
         item_quantity: item['quantity'],
         customer_nick: customer[:nick],
         seller_nick: seller[:nick],
         customer_id: customer[:id],
         seller_id: seller[:id],
         item_created_at: original[:created_at],
         item_updated_at: original[:updated_at],
         order_created_at: self[:created_at],
         order_updated_at: self[:updated_at],
         order_id: self[:id],
     }
   end
  end
end