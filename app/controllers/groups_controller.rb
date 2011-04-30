class GroupsController < ApplicationController

  #TODO - need to prevent private groups you aren't a part of from being returned...or just prevent submission and show the group
  #set :full => false if queries are running slowly due to contains search
  autocomplete :group, :name, :full => true

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to group_info_path(@group.name), :notice => "You have created the group '${group.name}'."
    else
      render :action => 'new'
    end
  end

  def edit
    @group = Group.find_by_id(params[:group])
  end

  def update
    @group = Group.find_by_id(params[:group])
    if @group.update_attributes(param[:group])
      redirect_to group_info_path(@group.group_name), :notice => "Group updated."
    else
      render :action => 'edit'
    end
  end

  def index
    @group = Group.find_by_id(params[:group_id])
    if @group
      @posts = @group.posts
      @members = @group.members
    else
      @posts = []
      @members = []
    end
  end

  def users
    @group = Group.find_by_id(params[:group_id])
    @members = @group.members
  end

  def posts
    @group = Group.find_by_id(params[:group_id])
    @posts = @group.posts
  end

end
