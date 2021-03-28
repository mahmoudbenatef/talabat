class NotificationsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @notifications = Notification.where(user: @user).order('created_at desc')
    # abort @notifications.inspect
  end
end
