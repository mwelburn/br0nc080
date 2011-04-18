class HomeController < ApplicationController

  def index
    @posts = Post.all
  end

  def groups
    @groups = Group.all
  end

  def users
    @users = User.all
  end
  
end
