class CreateDeviceRegistrations < ActiveRecord::Migration
  def change
    create_table :device_registrations do |t|
      t.string :device_id
      t.string :email
      t.text :registration_key
      t.integer :user_id
      t.string :platform

      t.timestamps null: false
    end
  end
end
