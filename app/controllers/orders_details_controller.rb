class OrdersDetailsController < ApplicationController
  def index
    @orderUsersIds = UserOrderJoin.where(order_id: params[:order_id])

    if @orderUsersIds.pluck(:user_id).include? current_user.id


      # @filtered = UserOrderJoin.joins(:order_detail).where(order_id: params[:order_id])

      # UserOrderJoin.joins("INNER JOIN order_details ON order_details.user_order_joins_id = user_order_joins.id AND books.out_of_print = FALSE")
      

      abort @filtered[0].inspect


    else
      redirect_to orders_path
    end

  




    
       
  end

  def create
    abort params.inspect
  end
end
