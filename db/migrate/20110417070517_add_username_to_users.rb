class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string#, :unique => true
    add_column :users, :full_name, :string

    remove_index :users, :email
    add_index :users, :username
    add_index :users, :full_name
  end

  def self.down
#    remove_column :users, :full_name
#    remove_column :users, :username
  end
end
