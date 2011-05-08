class HomeController < ApplicationController

  #TODO - need to prevent private groups you aren't a part of from being returned...or just prevent submission and show the group
  #set :full => false if queries are running slowly due to contains search
  autocomplete :group, :name, :full => true

  def index
    @posts = Post.where("topic_id is ?", nil)
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
