class Admin::OrdersController < ApplicationController
  before_action :verify_admin?
  before_action :load_order, except: [:index, :new, :create]

  def index
    @orders = Order.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @orderitems = @order.orderitems.newest.paginate page: params[:page],
      per_page: Settings.per_page
    return if @orderitems
    flash[:warning] = t "view.admin.orderitems.not_found"
    redirect_to admin_orders_path
  end

  def edit
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "view.admin.orders.update.success_msg"
      redirect_to admin_orders_path
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "view.admin.orders.destroy.success_msg"
    else
      flash[:danger] = t "view.admin.orders.destroy.error_msg"
    end
    redirect_to admin_orders_path
  end

  private

  def order_params
    params.require(:order).permit :name,
      :user_id, :address, :phone, :status, :total
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:warning] = t "view.admin.orders.not_found"
    redirect_to admin_orders_path
  end
end
