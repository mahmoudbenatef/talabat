class OrderMembersController < ApplicationController
  def create

    if !params[:email].match(/^[a-z]+[0-9\._a-z]+@[a-z]+\.com$/)
      ActionCable.server.broadcast("notification_channel", {header: "validate email", body: "email is not valid" , userId: current_user.id})


    # elsif !User.where(email: params[:email]).any?
    #   ActionCable.server.broadcast("notification_channel", {header: "validate email", body: "no user with this email" , userId: current_user.id})

    elsif User.where(email: params[:email]).take!= nil && User.where(email: params[:email]).take.id ==current_user.id
      ActionCable.server.broadcast("notification_channel", {header: "validate email", body: "you can't add yourself" , userId: current_user.id})

    else
      @my_friend_user = User.find_by(email:params[:email])
      @user = User.find(current_user.id)
      @existed_friend  = Friend.where(user_id: @user,friend_id: @my_friend_user)

      if @existed_friend == []
        ActionCable.server.broadcast("notification_channel", {header: "validate email", body: "you don't have this friend " , userId: current_user.id , email:params[:email]})
      else
        ActionCable.server.broadcast("notification_channel", {header: "validate email", body: "valid" , userId: current_user.id , email:params[:email] , friend: @existed_friend} )
      end


    end

    # ActionCable.server.broadcast("notification_channel", {header: "validate email", body: params[:email] , userId: current_user.id})
  end
end
