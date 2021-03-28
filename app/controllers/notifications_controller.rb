class NotificationsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @notifications = Notification.where(user: @user)
    # abort @notifications.inspect
  end
end
