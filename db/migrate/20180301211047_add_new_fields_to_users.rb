class AddNewFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :profile_picture_url, :string
    add_column :users, :name, :string, null: false
    add_column :users, :bio, :string, limit: 140
    add_column :users, :date_of_birth, :date, null: false
  end
end
