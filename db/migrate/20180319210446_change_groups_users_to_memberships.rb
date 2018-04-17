class ChangeGroupsUsersToMemberships < ActiveRecord::Migration[5.1]
  def change
    rename_table :groups_users, :memberships
  end
end
