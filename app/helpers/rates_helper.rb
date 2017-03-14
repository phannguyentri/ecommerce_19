module RatesHelper
  def calculate_average_rate product, count_rate, rate
    total = Settings.average_total
    product.rates.each do |rate|
      total += rate.rate
    end
    average = total / count_rate
  end
end
