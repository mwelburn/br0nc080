class UsersController < ApplicationController
  before_filter :authentication_user!, :except => [:index, :posts, :groups]

  def index
    @user = User.find_by_username(params[:username])
    if @user
      @posts = @user.posts
      @groups = @user.all_groups
    else
      @posts = []
      @groups = []
    end
  end

  def posts
    @user = User.find_by_username(params[:username])
    @posts = @user.posts
  end

  def groups
    @user = User.find_by_username(params[:username])
    @groups = @user.all_groups
  end

end
