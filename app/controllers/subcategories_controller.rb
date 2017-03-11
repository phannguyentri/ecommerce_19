class SubcategoriesController < ApplicationController

  def show
    @subcategory = Subcategory.find_by id: params[:id]
    if @subcategory.nil?
      flash[:warning] = t "view.subcategories.not_found"
      return redirect_to root_path
    end
    @products = @subcategory.products.list_products_desc
      .paginate page: params[:page], per_page: Settings.per_page
    if @products.empty?
      flash[:warning] = t "view.subcategories.not_found_product"
      redirect_to :back
    end
  end
end
