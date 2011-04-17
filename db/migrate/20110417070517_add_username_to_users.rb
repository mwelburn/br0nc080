class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_column :users, :full_name, :string

    remove_index :users, :email
    add_index :users, :username,                :unique => true
    add_index :users, :full_name,               :unique => true
  end

  def self.down
#    remove_column :users, :full_name
#    remove_column :users, :username
  end
end
