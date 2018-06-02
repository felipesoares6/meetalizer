class CreateOrganizers < ActiveRecord::Migration[5.1]
  def change
    create_table :organizers do |t|
      t.bigint :user_id, null: false
      t.bigint :event_id, null: false
      t.index ["user_id", "event_id"], name: "index_organizers_on_user_id_and_event_id"
    end
  end
end
