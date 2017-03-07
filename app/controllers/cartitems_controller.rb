class CartitemsController < ApplicationController
  before_action :logged_in_user
  before_action :create_cart, only: [:index, :create]

  def index
    @cartitems = session[:cart]
  end

  def create
    if session[:cart][params[:id]].nil?
      session[:cart][params[:id]] = Settings.add_cartitem
      flash[:success] = t "view.cartitems.create.add-success"
    else
      session[:cart][params[:id]] = session[:cart][params[:id]].to_i
      session[:cart][params[:id]] += Settings.add_cartitem
      flash[:success] = t "view.cartitems.create.success_quantity"
    end
    redirect_to cartitems_path
  end

  def update
    if session[:cart][params[:id]].nil?
      error_msg = t "view.cartitems.update.change_fail"
      render json :error_msg
    else
      session[:cart][params[:id]] = params[:cartitem][:quantity]
    end
  end

  def destroy
    if session[:cart][params[:id]].nil?
      error_msg = t "view.cartitems.destroy.delete_fail"
      render json :error_msg
    else
      session[:cart].delete(params[:id])
    end
  end

end
