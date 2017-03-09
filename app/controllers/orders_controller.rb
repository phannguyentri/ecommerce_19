class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :create_cart
  before_action :check_cart, only: [:new, :create]
  before_action :load_cart, only: [:new, :create]

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new order_params
    @order.transaction do
      if @order.save!
        @cartitems.each do |key, value|
          @orderitem = @order.orderitems.new product_id: key, quantity: value
          @orderitem.transaction do
            raise t "view.orders.create.trans_fail" unless @orderitem.save!
          end
        end
        flash[:success] = t "view.orders.create.success_msg"
        redirect_to root_path
      else
        render :new
      end
    end
  end

  private

  def order_params
    params.require(:order).permit :name, :email, :address, :phone, :total
  end

  def load_cart
    @cartitems = session[:cart]
  end
end
