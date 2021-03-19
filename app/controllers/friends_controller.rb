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
    end
    if @err == nil
    if @friend.save
      redirect_to @friend
      return
    else
      @err = { :msg => "unexpected error"}
    end
    end
    render :new, :locals => {:err => @err}

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
    @friend.destroy
    redirect_to friends_path

  end
end
