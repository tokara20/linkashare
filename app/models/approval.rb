class Approval < ApplicationRecord
  belongs_to :approver, class_name: "User", foreign_key: :user_id
  belongs_to :approved_link, class_name: "Link", foreign_key: :link_id
  
  validates_uniqueness_of :link_id, scope: :user_id
end
