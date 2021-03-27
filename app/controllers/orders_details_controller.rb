class OrdersDetailsController < ApplicationController
  def index
    
       @order_id = params[:order_id];
  end

  def create
    abort params.inspect
  end
end
