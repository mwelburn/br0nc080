class Post < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user_id, :message, :created_at, :group_id

  attr_accessible :user_id, :message, :created_at, :group_id, :reply_to_post_id

end
