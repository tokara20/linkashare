class Link < ApplicationRecord

  has_attached_file :website_image, styles: { medium: "200x200#", thumb: "100x100#" },
        default_url: "/images/missing.png"
  validates_attachment_content_type :website_image, content_type: /\Aimage\/.*\z/
  
  # Associations
  belongs_to :user
  
  def get_link_data(url)
    begin
      return LinkThumbnailer.generate(url)
    rescue
      self.errors.add(:url, "Unable to reach link.")
      return false
    end
  end
  
  def fetch_website_image(link_data)
    unless link_data.images.empty?
      image = open(link_data.images.first.src.to_s)
      filename = image.base_uri.to_s.split('/')[-1]
      image_path = Rails.root.join('tmp', filename)   
      IO.copy_stream(image, image_path)
      File.open(image_path, 'rb') do |file|
        self.website_image = file
      end
    end
  end
end
