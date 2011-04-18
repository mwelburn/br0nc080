class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to group_info_path(@group.group_name), :notice => "You have created the group '${group.group_name}'."
    else
      render :action => 'new'
    end
  end

  def edit
    @group = current_group
  end

  def update
    @group = current_group
    if @group.update_attributes(param[:group])
      redirect_to group_info_path(@group.group_name), :notice => "Group updated."
    else
      render :action => 'edit'
    end
  end

  def index
    @group = Group.find_by_id(params[:group_id])
    @posts = @group.posts
    @users = @group.all_users
  end

  def posts
    @group = Group.find_by_id(params[:group_id])
    @posts = @group.posts
  end

  def users
    @group = Group.find_by_id(params[:group_id])
    @users = @group.all_users
  end

end
