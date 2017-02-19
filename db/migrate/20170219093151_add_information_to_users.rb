class AddInformationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :information, :text
  end
end
