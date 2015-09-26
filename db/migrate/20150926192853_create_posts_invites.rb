class CreatePostsInvites < ActiveRecord::Migration
  def change
    create_table :posts_invites do |t|
      t.integer :accepted_by
      t.integer :post_id
      t.integer :invite_status_id

      t.timestamps null: false
    end
  end
end
