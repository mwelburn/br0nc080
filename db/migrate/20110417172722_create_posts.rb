class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id, :null => false
      t.string :message, :null => false
      t.integer :group_id, :null => false
      t.integer :topic_id

      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
    end

    add_index :posts, :message
  end

  def self.down
    drop_table :posts
  end
end
