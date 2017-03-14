class RatesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_rating_user, only: :update

  def create
    rate = current_user.rates.new rate_params
    if rate.save
      product = Product.find_by id: params[:rate][:product_id]
      count_rate = product.rates.count
      product.update_attributes average_rate: calculate_average_rate(product,
        count_rate, rate)
      render json: {rate: rate, product: product}
    else
      error_msg = t "view.rates.error_msg"
      render json: error_msg
    end
  end

  def update
    rate = Rate.find_by id: params[:id]
    if rate.update_attributes rate_params
      product = Product.find_by id: params[:rate][:product_id]
      count_rate = product.rates.count
      product.update_attributes average_rate: calculate_average_rate(product,
        count_rate, rate)
      render json: {rate: rate, product: product}
    else
      error_msg = t "view.rates.error_msg"
      render json: error_msg
    end
  end

  private

  def rate_params
    params.require(:rate).permit :rate, :product_id
  end
end
