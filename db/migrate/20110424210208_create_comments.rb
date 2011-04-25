class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :user_id, :null => false
      t.string :message, :null => false
      t.string :post_id, :null => false
      t.string :group_id

      t.datetime :created_at, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
