class Upload < ApplicationRecord
  has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png",
                    path: ":rails_root/public:url"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/
end
