module ApplicationHelper
  def full_title page_title
    base_title = t "app.helpers.base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def count_index index
    if params[:page].nil?
      page = 0
    else
      page = params[:page].to_i * Settings.per_page - Settings.per_page
    end
    index += page + 1
  end

  def get_products id
    @product = Product.find_by id: id
    return if @product
    flash[:warning] = t "view.cartitems.index.not_found"
    redirect_to root_path
  end

  def calculate_total price, quantity
    @total = Settings.total if @total.nil?
    @total += price * quantity.to_i
  end
end
