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

  def create_via_ajax
    message = params[:message]
    group_id = params[:group_id]
    topic_id = params[:topic_id]

    if (group_id)
      post = Post.new
      post.group_id = group_id
      post.message = message
      post.user_id = current_user.id
      if (topic_id)
        post.topic_id = topic_id
      end

      if post.save!
        render :text => post.id
      else
        render :text => "-1"
      end
    else
      render :text => "-2"
    end
  end

  def destroy

  end
  
end
