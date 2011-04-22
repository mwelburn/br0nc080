class PostsController < ApplicationController

  def index
    @post = Post.where("id = ? and topic_id IS NULL", params[:post_id]).first
  end

  def create
    post = current_user.posts.build(params[:post])
    #render :text => post.inspect
  end

  def destroy

  end
  
end
