class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :link
  
  validates_presence_of :content
end
