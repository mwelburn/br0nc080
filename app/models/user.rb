class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :full_name, :email, :password, :password_confirmation, :remember_me

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  validates_presence_of :username
  validates_uniqueness_of :username, :email
  validates_format_of :username, :with => /^[-\w_@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or -_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6, :allow_blank => true
  validates_exclusion_of :username, :in => %w(admin superuser), :message => "is not a valid username"

  has_many :posts, :dependent => :destroy
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :friendships
  has_many :friends, :through => :friendships

  def add_friend(friend)
    friendship = friendships.build(:friend_id => friend.id)
    if !friendship.save
      logger.debug "User '${friend.email}' already exists in the user's friendship list."
    end
  end

  def remove_friend(friend)
    friendship = Friendship.find(:first, :conditions => ["user_id = ? and friend_id = ?", self.id, friend.id])
    if friendship
      friendship.destroy
    end
  end

  def friends_of
    Friendship.find(:all, :conditions => ["friend_id = ?", self.id]).map{|f| f.user}
  end

  def is_friend?(friend)
    return self.friends.include? friend
  end

  def toggle_follow(friend)
    if (is_friend? friend)
      current_user.remove_friend(:friend => friend)
    else
      current_user.add_friend(:friend => friend)
    end
  end

  def all_posts
    Post.find(:all, :conditions => ["user_id in (?)", friends.map(&:id).push(self.id)], :order => "created_at desc")
  end

  def add_group(group)
    membership = memberships.build(:group_id => group.id)
    if !membership.save
      logger.debug "User already belongs in group '${group.group_name}'."
    end
  end

  def remove_group(group)
    membership = Membership.find(:first, :conditions => ["user_id = ? and group_id = ?", self.id, group.id])
    if membership
      membership.destroy
    end
  end

  def toggle_membership(group)
    if (group.member_of? current_user)
      current_user.remove_group(:group => group)
    else
      current_user.add_group(:group => group)
    end
  end

  def all_groups
    Membership.find(:all, :conditions => ["user_id = ?", self.id]).map{|f| f.group}
  end

  def self.find_by_search_query(q)
    User.find(:all, :conditions => ["username like ? OR email like ?", "%#{q}%", "%#{q}#"])
  end

  #protected methods below
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end

   # Attempt to find a user by it's email. If a record is found, send new
   # password instructions to it. If not user is found, returns a new user
   # with an email not found error.
   def self.send_reset_password_instructions(attributes={})
     recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
     recoverable.send_reset_password_instructions if recoverable.persisted?
     recoverable
   end
  
   def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
     (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

     attributes = attributes.slice(*required_attributes)
     attributes.delete_if { |key, value| value.blank? }

     if attributes.size == required_attributes.size
       if attributes.has_key?(:login)
          login = attributes.delete(:login)
          record = find_record(login)
       else
         record = where(attributes).first
       end
     end

     unless record
       record = new

       required_attributes.each do |key|
         value = attributes[key]
         record.send("#{key}=", value)
         record.errors.add(key, value.present? ? error : :invalid)
#         record.errors.add(key, value.present? ? error : :blank)
       end
     end
     record
   end

   def self.find_record(login)
     where(["username = :value OR email = :value", { :value => login }]).first
   end

end
