class AddAttachmentWebsiteImageToLinks < ActiveRecord::Migration
  def self.up
    change_table :links do |t|
      t.attachment :website_image
    end
  end

  def self.down
    remove_attachment :links, :website_image
  end
end
