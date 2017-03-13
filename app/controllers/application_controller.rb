class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_categories
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "view.users.private.logged_in_user"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user == current_user
  end

  def create_cart
    session[:cart] = {} if session[:cart].nil?
  end

  def check_cart
    if session[:cart].empty?
      flash[:warning] = t "view.orders.new.not_found"
      redirect_to root_path
    end
  end

  def correct_order_user
    @order = Order.find_by id: params[:id]
    unless @order == (current_user.orders.find_by id: params[:id])
      redirect_to root_path
    end
  end

  def load_categories
    @all_categories = Category.all
    if @all_categories.empty?
      flash[:warning] = t "view.not_found_categories"
      redirect_to root_path
    end
  end
end
