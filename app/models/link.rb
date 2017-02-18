class Link < ApplicationRecord

  has_attached_file :website_image, styles: { medium: "300x300>", thumb: "100x100>" },
        default_url: "/images/:style/missing.png"
  validates_attachment_content_type :website_image, content_type: /\Aimage\/.*\z/
  
  # Associations
  belongs_to :user
end
