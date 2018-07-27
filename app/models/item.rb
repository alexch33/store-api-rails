class Item < ApplicationRecord
  has_many :uploads, dependent: :destroy
  belongs_to :user
  belongs_to :category

  def as_json(options = {})
    urls_arr = self.uploads.map {|upload| upload.file.url}
    options = options.merge({urls: urls_arr})
    super.as_json.merge(options)
  end
end
