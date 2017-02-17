class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_attached_file :profile_image, styles: { medium: "300x300>", 
      thumb: "100x100>", micro: "50x50>" }, 
      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/
end
