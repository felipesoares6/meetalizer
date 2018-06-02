class RenameOrganizersToEventOrganizers < ActiveRecord::Migration[5.1]
  def change
    rename_table :organizers, :event_organizers
  end
end
