class MembersController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @members = Member.where(group_id: @group)
    respond_to do |format|
        format.html { redirect_to @group, notice: 'all groups.' }
        format.js
        # {all_data: {data: @data, data1: @data1, data2: @data2}}
        format.json { render json:{all_data: {members: @members, group: @group}} , status: :created, location: @friend }
        # @members
    # abort @members.inspect
    end
    end

  def create
    @group = Group.find(params[:group_id])
    @err = nil
    @my_friend_user = User.find_by(email:params[:email])
    @user = User.find(current_user.id)
    if  @my_friend_user == nil
      @err={:msg => "there is no user with this email"}
    else
      @existed_friend  = Friend.where(user_id: @user,friend_id: @my_friend_user)
      if @existed_friend == nil
        @err={:msg => "you have no friend with this email"}
      else
        @existed_member = Member.where(:user_id => @my_friend_user,:group_id=> @group)
        if @existed_member.any?
          @err={:msg => "This member is already in this group"}
        else
          @memberDict  =  { :user =>@my_friend_user , :group => @group}
          @member= Member.new(@memberDict)

        end
      end

    end
    if @err == nil
      respond_to do |format|
        if @member.save
          format.js
          format.html { redirect_to groups_path, notice: 'member was successfully added.' }
          format.json { render json: @user , status: :created, location: @member }
        else

        end
      end
    else
      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'friend was successfully created.' }
        format.js
        format.json { render json: @err, status: :created, location: @friend }    end
      @end




    end

  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    # redirect_to friends_path
    respond_to do |format|
      format.js
      format.html { redirect_to friends_path, notice: 'Member was successfully created.'  }
      format.json { head :no_content }
    end

  end
end
