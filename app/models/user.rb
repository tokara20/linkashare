class User < ApplicationRecord
  before_create :set_default_role
  after_create  :generate_profile_image
  
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  enum role: [:guest, :user, :admin]    
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_attached_file :profile_image, styles: { medium: "300x300>", 
      thumb: "100x100>", micro: "50x50>" }, 
      default_url: "/images/:style/missing.png"
      
  # Validations
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/
  validates :username, length: { in: 3..15 }
  
  # Associations
  has_many :links
  
  protected
  
  def set_default_role
    self.role = :user
  end
  
  def generate_profile_image
    img = Avatarly.generate_avatar(self.username, { size: 100 })
    
    temp = Tempfile.new(['tempimg', '.png'])
    temp.binmode
    temp.write img
    temp.rewind
    
    self.profile_image = temp
    self.save
    
    temp.close
  end
end
