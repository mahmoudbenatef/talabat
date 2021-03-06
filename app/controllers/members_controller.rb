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
    # abort 
    # abort current_user.email.inspect
    
    if  @my_friend_user == nil
      @err={:msg => "there is no user with this email"}
    elsif
      current_user.email ==  @my_friend_user.email
      @err={:msg => "This member is already the group admin"}
    else
      @existed_friend  = Friend.where(user_id: @user,friend_id: @my_friend_user)
      # if @existed_friend == nil
      if !@existed_friend.any?
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
          @notificationDict  =  { :body => @user.full_name+ " add you in group "+@group.name , :user => @my_friend_user , :notificationType => "member in group",:seen => false}
          @notification = Notification.new(@notificationDict)
          @notification.save
          ActionCable.server.broadcast("notification_channel", { body:  @user.full_name+ " add you in group "+@group.name , userId: @my_friend_user.id})

          format.js
          format.html { redirect_to group_members_url, notice: 'member was successfully added.' }
          format.json { render json: @user , status: :created, location: @member }
        else
          format.html { redirect_to groups_path, notice: 'friend was successfully created.' }
          format.js
          format.json { render json: @err, status: :created, location: @friend }    end
        @end
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
    @group = Group.find(@member[:group_id])
    @user = User.find(@group.user_id)
    @my_friend_user = User.find(@member.user_id)

    @notificationDict  =  { :body => @user.full_name+ " add you in group "+@group.name , :user => @my_friend_user , :notificationType => "member in group",:seen => false}
    @notification = Notification.new(@notificationDict)
    @notification.save
    ActionCable.server.broadcast("notification_channel", { body:  @user.full_name+ " reomved you from group "+@group.name , userId: @my_friend_user.id})

    @member.destroy
    # redirect_to friends_path
    respond_to do |format|
      format.js
      format.html { redirect_to friends_path, notice: 'Member was successfully created.'  }
      format.json { head :no_content }
    end

  end
end
