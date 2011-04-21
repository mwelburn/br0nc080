class Group < ActiveRecord::Base

  validates_presence_of :group_name

  attr_accessible :user_id, :group_name, :group_description, :group_id

  has_many :posts

  has_many :memberships
  has_many :users, :through => :memberships

  def member_of?(user)
    return self.users.include? user
  end

  def posts
    Post.find(:all, :conditions => ["group_id = ?", self.id], :order => "created_at desc")
  end

  def self.find_by_search_query(q)
    Group.find(:all, :conditions => ["group_name like ?", "%#{q}%"])
  end

  def members
    Membership.find(:all, :conditions => ["group_id = ?", self.id]).map{|f| f.user}
  end

  def topics
    Post.find(:all, :conditions => ["group_id = ? and topic_id is null or topic_id = ''", self.id])
  end

end
