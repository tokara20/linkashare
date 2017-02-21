class Link < ApplicationRecord

  has_attached_file :website_image, styles: { medium: "200x200#", thumb: "100x100#" },
        default_url: "/images/missing.png"
      
  # Validations
  validates_attachment_content_type :website_image, content_type: /\Aimage\/.*\z/
  validates :url, uniqueness: true
  
  # Associations
  belongs_to :user
  
  has_many :approvals
  has_many :approvers, through: :approvals
  
  def format_url_correctly(url)
    self.url = url
    unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end 
  end
  
  def get_link_data(url)
    if Link.where(url: url).any?
      self.errors.add(:url, "Link already exists.")
      return false  
    end
    
    begin
      return LinkThumbnailer.generate(url)
    rescue
      self.errors.add(:url, "Unable to reach link.")
      return false
    end
  end
  
  def fetch_website_image(link_data)
    unless link_data.images.empty?
      begin
        image_url = link_data.images.first.src.to_s
        image = open(image_url)
        filename = image.base_uri.to_s.split('/')[-1]
        image_path = Rails.root.join('tmp', filename)   
        IO.copy_stream(image, image_path)
        File.open(image_path, 'rb') do |file|
          self.website_image = file
        end
      rescue OpenURI::HTTPError
        logger.debug "Error fetching #{image_url}"
      end
    end
  end
  
  private

end
