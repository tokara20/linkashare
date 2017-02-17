class AddSlugToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :slug, :string
    add_index :links, :slug, unique: true
  end
end
