class Upload < ApplicationRecord
  belongs_to :item
  has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" },
                    :storage => :cloudinary,
                    :path => ':id/:style/:filename',
  :cloudinary_credentials => Rails.root.join("config/cloudinary.yml")

  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/

  def url_id
    id, url = self.id, self.file.url
    {id: id, url: url}
  end
end
