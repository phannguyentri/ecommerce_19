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

  def show_hot_product hot_products
    active = Settings.hot_active
    count = Settings.init_count
    html = ""
    hot_products.each do |product|
      count += Settings.increase_count
      if active == Settings.is_active && count == Settings.is_first
        active = Settings.not_active
        html << "<div class='item active'>"
        html << "<div class='row'>"
      else
        if count == Settings.is_first
          html << "<div class='item'>"
          html << "<div class='row'>"
        end
      end
        html << "<div class='col-md-4'>"
        html << "<a class='thumbnail' href='/products/#{product.id}'><img
            src='#{product.image.url}'></a>"
        html << "</div>"
      if count == Settings.is_last
        count = Settings.init_count
        html << "</div>"
        html << "</div>"
      end
    end
    return html
  end
end
