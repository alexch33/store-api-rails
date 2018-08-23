class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :category, uniqueness: true
  validates_presence_of :category
end
