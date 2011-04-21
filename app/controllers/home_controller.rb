class HomeController < ApplicationController

  def index
    @posts = Post.all
    # TODO - get all initial topics instead of every individual post
    #@topics = Reply
  end

  def groups
    @groups = Group.all
  end

  def users
    @users = User.all
  end
  
end
