class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_order_user, only: [:edit, :update]
  before_action :create_cart
  before_action :check_cart, only: [:new, :create]
  before_action :load_cart, only: [:new, :create]
  before_action :load_order, only: [:show, :edit, :update]
  before_action :check_status, only: [:edit, :update]

  def index
    @orders = current_user.orders.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @order = Order.new
  end

  def show
    @orderitems = @order.orderitems.newest.paginate page: params[:page],
      per_page: Settings.per_page
    return if @orderitems
    flash[:warning] = t "view.orderitems.not_found"
    redirect_to orders_path
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

  def edit
  end

  def update
    if params[:status].to_i == Settings.reject_order
      if @order.update_attributes status: params[:status].to_i
        flash[:success] = t "view.orders.update.reject_ok"
      else
        flash[:danger] = t "view.orders.update.reject_fail"
      end
      redirect_to orders_path
    else
      if @order.update_attributes order_params
        flash[:success] = t "view.orders.update.success_msg"
        redirect_to @order
      else
        render :edit
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

  def load_order
    @order = current_user.orders.find_by id: params[:id]
    return if @order
    flash[:warning] = t "view.orders.not_found"
    redirect_to orders_path
  end

  def check_status
    return if @order.pending?
    flash[:warning] = t "view.orders.status_msg"
    redirect_to orders_path
  end
end
