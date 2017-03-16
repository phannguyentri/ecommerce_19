class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_categories
  before_action :load_hot_products

  include SessionsHelper
  include RatesHelper
  include StatisticsHelper

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

  def correct_rating_user
    @rate = Rate.find_by id: params[:id]
    unless @rate == (current_user.rates.find_by id: params[:id])
      redirect_to root_path
    end
  end

  def correct_comment_user
    @comment = Comment.find_by id: params[:id]
    unless @comment == (current_user.comments.find_by id: params[:id])
      redirect_to root_path
    end
  end

  def correct_suggest_user
    @suggest = Suggest.find_by id: params[:id]
    unless @suggest == (current_user.suggests.find_by id: params[:id])
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

  def load_hot_products
    @hot_products = Product.hot_rate
    if @hot_products.empty?
      flash[:warning] = t "view.not_found"
      redirect_to root_path
    end
  end
end
