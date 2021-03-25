class GroupsController < ApplicationController
  def index
    @groups = Group.where(user_id: current_user)
    @group = Group.new
  end

  def create
    @group = Group.find_by(name: params[:group][:name],user_id: current_user)
    if @group == nil
      @group = Group.new(group_params)
      respond_to do |format|
      if @group.save
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    else
      @err={:msg => "group name already exists"}
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.js
    end
  end

  def group_params
    params.require(:group).permit(:name).merge!(
      user_id: current_user.id
    )
  end
end
