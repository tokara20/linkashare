class RemoveSlugFromLinks < ActiveRecord::Migration[5.0]
  def change
    remove_index :links, column: :slug
    remove_column :links, :slug
  end
end
