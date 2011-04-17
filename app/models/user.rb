class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :password, :password_confirmation, :remember_me

  #validates_presence_of :username
  #validates_uniqueness_of :username, :email
  #validates_format_of :username, :with => /^[-\w_@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or -_@"
  #validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  #validates_presence_of :password, :on => :create
  #validates_confirmation_of :password
  #validates_length_of :password, :minimum => 6, :allow_blank => true
  #validates_exclusion_of :username, :in => %w(admin superuser following login logout flits users sessions applications), :message => "is not a valid username"

end
