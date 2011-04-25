class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  validates_presence_of :user_id, :message, :post_id

  attr_accessible :user_id, :message, :created_at, :post_id, :group_id

end
