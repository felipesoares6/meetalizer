class AddIdToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :id, :primary_key
  end
end
