class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :user_id, :null => false
      t.string :group_name, :null => false
      t.string :group_description

      t.datetime :created_at, :null => false
    end

    add_index :groups, :group_name,    :unique => true
    add_index :groups, :group_description
  end

  def self.down
    drop_table :groups
  end
end
