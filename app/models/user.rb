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
         
  has_attached_file :profile_image,
    styles: { medium: "200x200#", micro: "50x50#" }, 
    storage: :cloudinary,
    default_url: "/images/missing.png",
    path: ":id/:style/:filename",
    cloudinary_upload_options: {
      default: { tags: "profile_images" }
    }       

  # Validations
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/
  validates :username, presence: true, uniqueness: true
  validates :username, length: { in: 3..15 }
  
  # Associations
  has_many :links, dependent: :destroy
  
  has_many :approvals
  has_many :approved_links, through: :approvals, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  
  def should_generate_new_friendly_id?
    username_changed?  
  end
  
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
