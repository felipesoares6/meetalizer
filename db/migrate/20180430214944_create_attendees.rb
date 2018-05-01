class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.integer :role
      t.bigint :user_id, null: false
      t.bigint :event_id, null: false
      t.index [:user_id, :event_id]
    end
  end
end
