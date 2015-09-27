class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :status_id
      t.date    :date
      t.integer :max_people
      t.string  :location
      t.float   :location_lat
      t.float   :location_lng
      t.integer :user_id
      t.integer :post_status_id
      t.float   :user_lat
      t.float   :user_lng
      t.text    :description
      t.integer :min_people
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
