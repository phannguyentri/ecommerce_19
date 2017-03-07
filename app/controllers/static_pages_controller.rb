class StaticPagesController < ApplicationController
  def home
    @list_products = Product.list_products_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def help
  end

  def about
  end

  def contact
  end

end
