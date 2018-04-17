class AddRoleToGroupsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :groups_users, :role, :integer
  end
end
