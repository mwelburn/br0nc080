class PostsController < ApplicationController

  def index
    @post = Post.find_by_id(params[:post_id])
    @group = Group.find_by_id(@post.group_id)
  end

  def create
    post = current_user.posts.build(params[:post])

    post.save!
    #render :text => post.inspect
  end

  def destroy

  end
  
end
