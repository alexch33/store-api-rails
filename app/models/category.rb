class Category < ApplicationRecord
  has_many :items
  validates :category, uniqueness: true
end
