class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  default_scope { order(created_at: :desc) }
  validates_presence_of :body, :author, :item_id, :user_id
end
