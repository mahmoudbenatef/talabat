class HomePagesController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @user_orders  = Order.where(user_id: @user).order('created_at desc')
    @friends = Friend.where('friends.user_id'=>@user)
    @real_user = @friends[0].friend
    # abort @real_user.inspect
  end
end
