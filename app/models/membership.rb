class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :group
  #validates_uniqueness_of :group_id, :scope => :group_id
  validates_presence_of :user_id, :group_id

end
