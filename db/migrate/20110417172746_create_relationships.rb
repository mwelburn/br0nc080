class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :follower_id, :null => false
      t.integer :followed_id, :null => false

      t.datetime :created_at, :null => false
    end
  end

  def self.down
    drop_table :friendships
  end
end
