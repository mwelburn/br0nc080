class HomeController < ApplicationController

  def index
    @posts = Post.where("topic_id is ?", nil)
  end

  def groups
    @groups = Group.all
  end

  def users
    @users = User.all
  end
  
end
