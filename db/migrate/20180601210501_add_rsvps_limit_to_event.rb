class AddRsvpsLimitToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :rsvps_limit, :integer
  end
end
