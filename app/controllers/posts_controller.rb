class PostsController < AuthorizedController

  def create
    post = current_user.posts.build(params[:post])
    #render :text => post.inspect
  end

  def destroy

  end
  
end
