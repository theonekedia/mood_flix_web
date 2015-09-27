class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.text :token
      t.datetime :token_expiry_at
      t.string :token_secret
      t.string :string
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
