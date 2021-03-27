class OrdersDetailsController < ApplicationController
  def index
    @newItem = OrderDetail.new
    @orderUsersIds = UserOrderJoin.where(order_id: params[:order_id])
   
    if @orderUsersIds.pluck(:user_id).include? current_user.id
      @order_id = params[:order_id]
      @order = Order.find(params[:order_id])
    else
      redirect_to orders_path
    end    
  end

  def create
      @newItem = OrderDetail.new(details_params)
      # {:item_name=>"ay 7aga",:amount=>2,:price=>3,:comment=>"",:user_order_join=>2}
      # abort @newItem.inspect
      if @newItem.save
        redirect_to orders_path
      else
        # redirect_to orders_path
      end
  end

  private
  def details_params
    @joinsId = UserOrderJoin.where(order_id: params[:order_id],user_id: current_user.id ).take.id
    params.require(:item).permit(:item_name,:amount,:price,:comment)
  end
end
