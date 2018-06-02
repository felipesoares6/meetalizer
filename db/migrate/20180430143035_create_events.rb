class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :address
      t.string :cover_picture_url
      t.belongs_to :group, index: true
    end
  end
end
