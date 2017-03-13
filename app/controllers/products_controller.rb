class ProductsController < ApplicationController
  def show
    @product = Product.find_by id: params[:id]
    if @product.nil?
      flash[:warning] = t "view.products.not_found"
      redirect_to root_path
    end
    if logged_in?
      @rate = current_user.rates.find_by product_id: params[:id]
      @new_comment = Comment.new
    end
    @rating = @rate.nil? ? Settings.rating : @rate.rate
    @comments = @product.comments.comments_newest.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
