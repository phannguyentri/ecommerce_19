class OrderitemsController < ApplicationController
  before_action :load_orderitem, only: :update

  def update
    unless @orderitem.update_attributes status: params[:orderitem][:status]
      error_msg = t "view.admin.orderitems.change_fail"
      render json :error_msg
    end
  end

  private

  def load_orderitem
    @orderitem = Orderitem.find_by id: params[:id]
    return if @orderitem
    flash[:warning] = t "view.admin.products.not_found"
    redirect_to admin_orders_path
  end
end
