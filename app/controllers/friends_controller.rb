class FriendsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @friends =Friend.all
    @friends = @friends.where(user: @user)
    # abort @friends.inspect
  end
  def new
    @friend = Friend.new
  end

  def create
    @my_friend = User.find_by(email:friend_params[:email])
    @user = User.find(current_user.id)
    @userDict  =  { :user =>@user , :friend => @my_friend}
    @friend = Friend.new(@userDict)
    @err = nil
    if  @my_friend == nil
      @err = { :msg => "there is no user with this email "}
    elsif @my_friend.id == current_user.id
      @err = { :msg => "you can't send friend request to yourself "}
    elsif Friend.find_by user_id: current_user.id, friend_id: @my_friend.id
      @err = { :msg => "you already have this friend "}
      @testawy = ""
    end



    if @err == nil
    respond_to do |format|
      if @friend.save
        ActionCable.server.broadcast("notification_channel", { body: @user.full_name+ " add you in friend list" , userId: @my_friend.id})
        @notificationDict  =  { :body => @user.full_name+ " add you in friend list", :user => @my_friend , :notificationType => "new friend",:seen => false}

        @notification = Notification.new(@notificationDict)
        @notification.save
        format.html { redirect_to @friend, notice: 'friend was successfully created.' }
        format.js
        format.json { render json: @err, status: :created, location: @friend }
      else

      end
    end
    else
      respond_to do |format|
      format.html { redirect_to @friend, notice: 'friend was successfully created.' }
      format.js
      format.json { render json: @err, status: :created, location: @friend }    end
      @end


    # if @err == nil
    # if @friend.save
    #   redirect_to @friend
    #   return
    # else
    #   @err = { :msg => "unexpected error"}
    # end
    # end
    # render :new, :locals => {:err => @err}

  end
    end
  def show
    @friend = Friend.find(params[:id])
  end
  # private
  def friend_params
    params.require(:friend).permit(:email)
  end

  def destroy
    @friend = Friend.find(params[:id])
    @user = User.find(current_user.id)
    @friend_user =  User.find(@friend["friend_id"])


    @notificationDict  =  { :body => @user.full_name+ " deleted you from friend list", :user => @friend_user , :notificationType => "deleted from friends",:seen => false}
    @notification = Notification.new(@notificationDict)
    @notification.save

    @friend.destroy
    ActionCable.server.broadcast("notification_channel", { body: @user.full_name+ " deleted you from friend list" , userId: @friend_user.id})

    # redirect_to friends_path
    respond_to do |format|
      format.js
      format.html { redirect_to friends_path, notice: 'Group was successfully created.'  }
      format.json { head :no_content }
    end

  end
end
