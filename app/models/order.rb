class Order < ApplicationRecord
  def details
   customer = User.where(id: self[:client_id]).first
   seller = User.where(id: self[:seller_id]).first
   self.order_items.map do |item|
     original = Item.where(id: item['item_id']).first
     {
         id: item['item_id'],
         title: original[:title],
         item_raiting: original[:rating],
         price: item['price'],
         quantity: item['quantity'],
         customer_nick: customer[:nick],
         seller_nick: seller[:nick],
         customer_id: customer[:id],
         seller_id: seller[:id],
         created_at: original[:created_at],
         updated_at: original[:updated_at],
     }
   end
  end
end