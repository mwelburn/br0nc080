class HomeController < ApplicationController

  def index
    @posts = Post.where("topic_id IS NULL").order("created_at desc")
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
