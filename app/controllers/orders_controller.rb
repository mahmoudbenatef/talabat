class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
    # extension=@order.menuImage.split('.')
    # send_file Rails.root.join('public','uploads',@order.menuImage),
    # :type=>"application/#{extension[1]}", :x_send_file=>true
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
  
    #@order = Order.new(order_params)
    @order=Order.new
    @order.orderType=order_params[:orderType]
    @order.user_id=order_params[:user_id]
    @order.orderFrom=order_params[:orderFrom]
    @order.menuImage=order_params[:menuImage]
    notValidEmails=[]
    allUsers=User.all
    @order.save
    usersToAdd=order_params[:friendsToAdd].split(" ")
    
    usersToAdd.each do |user|
      if !user.match(/^[a-z]+[0-9\._a-z]+@[a-z]+\.com$/)
        notValidEmails.push(user)
        abort @user.inspect
      elsif @User.where(email: user).empty?
        abort @user.inspect

      end
      
      @currentFriend=User.find_by(email:user)
      @dict  =  { :user =>@currentFriend , :order => @order}
      @test=UserOrderJoin.new(@dict)
      @test.save
    end
  

    uploaded_io = params[:order][:menuImage]
File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  file.write(uploaded_io.read)
end
@order.menuImage=uploaded_io.original_filename

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:orderType, :orderFrom, :menuImage,:user_id,:friendsToAdd)
    end
end
