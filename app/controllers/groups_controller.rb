class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        format.js
        format.html { redirect_to @user, notice: 'Group was successfully created.'  }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to groups_url, notice: 'Group was successfully created.'  }
      format.json { head :no_content }
    end
  end

  def group_params
    params.require(:group).permit(:name) 
  end
end

# format.json { render json: @group, status: :created, location: @group }