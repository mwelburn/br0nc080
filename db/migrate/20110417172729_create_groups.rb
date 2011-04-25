class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false#, :unique => true
      t.string :description
      t.boolean :private, :null => false, :default => false

      t.datetime :created_at, :null => false
      t.datetime :updated_at
    end

    add_index :groups, :name
    add_index :groups, :description
  end

  def self.down
    drop_table :groups
  end
end
