class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
