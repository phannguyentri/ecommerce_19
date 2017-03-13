class SearchController < ApplicationController

  def index
    check_params params[:input_search], params[:input_min], params[:input_max]
  end

  private

  def check_params search, min, max
    case
    when search.present? && min.blank? && max.blank?
      @products = Product.search_name(search).list_products_desc.
        paginate page: params[:page], per_page: Settings.per_page
    when (search.present? || search.blank?) && min.blank? && max.present?
      @products = Product.search_name(search).max_price(max).
        list_products_desc.paginate page: params[:page],
        per_page: Settings.per_page
    when (search.present? || search.blank?) && max.blank? && min.present?
      @products = Product.search_name(search).min_price(min).
        list_products_desc.paginate page: params[:page],
        per_page: Settings.per_page
    when search.blank? && min.present? && max.present?
      @products = Product.min_price(min).max_price(max).
        list_products_desc.paginate page: params[:page],
        per_page: Settings.per_page
    when search.blank? && min.blank? && max.blank?
      @products = Product.search_name(search).list_products_desc.
        paginate page: params[:page],
        per_page: Settings.per_page
    else
      @products = Product.search_name(search).min_price(min).
        max_price(max).list_products_desc.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end
end
