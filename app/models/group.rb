class Group < ActiveRecord::Base

  validates_presence_of :name

  attr_accessible :user_id, :name, :description, :group_id, :private

  has_many :posts

  has_many :memberships
  has_many :users, :through => :memberships

  def member_of?
    return self.users.include? current_user
  end

  def member_of?(user)
    return self.users.include? user
  end

  def posts
    Post.where("group_id = ? and topic_id is null", self.id).order("created_at desc")
  end

  def comments
    Post.where("group_id = ? and topic_id is not null", self.id).order("created_at desc")
  end

  def self.find_by_search_query(q)
    Group.find_all_by_name("%#{q}%")
  end

  def members
    Membership.find_all_by_group_id(self.id).map{|f| f.user}
  end

end
