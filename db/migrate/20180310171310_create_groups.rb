class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :region
      t.string :profile_picture_url
      t.string :description
      t.string :cover_picture_url

      t.timestamps
    end
  end
end
