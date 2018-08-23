class User < ApplicationRecord
  has_many :items
  has_secure_password
  validates_presence_of :nick, :password
  validates :email, format: { with: /\A\w+@\w+\.\w{2,5}\z/ }
end
