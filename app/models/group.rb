class Group < ActiveRecord::Base

  validates_presence_of :group_name

  attr_accessible :user_id, :group_name, :group_description, :group_id

  has_many :posts
  has_many :users

  def member_of?(user)
    return self.users.include? user
  end

  def all_posts
    Post.find(:all, :conditions => ["group_id in (?)", groups.map(&:id).push(self.id)], :order => "created_at desc")
  end

  def all_groups
    Group.find(:all, :order => "created_at desc")
  end

  def self.find_by_search_query(q)
    Group.find(:all, :conditions => ["group_name like ?", "%#{q}%"])
  end

  def all_users
    Membership.find(:all, :conditions => ["group_id = ?", self.id]).map{|f| f.user}
  end

end
