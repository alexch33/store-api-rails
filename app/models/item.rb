class Item < ApplicationRecord
  default_scope { order(created_at: :desc) }
  has_many :uploads, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category

  def as_json(options = {})
    urls_arr = self.uploads.map {|upload| upload.file.url}
    options = options.merge({ urls: urls_arr, category: self.category.category })
    super.as_json.merge(options)
  end

  def owner? (user)
    user && user.id === self.user_id
  end
end
