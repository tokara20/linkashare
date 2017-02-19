class Link < ApplicationRecord

  has_attached_file :website_image, styles: { medium: "200x200#", thumb: "100x100#" },
        default_url: "/images/missing.png"
  validates_attachment_content_type :website_image, content_type: /\Aimage\/.*\z/
  
  # Associations
  belongs_to :user
end
