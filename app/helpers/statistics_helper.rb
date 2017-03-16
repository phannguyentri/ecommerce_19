module StatisticsHelper

  def data_statistics orders_last_month, orders_this_month, orders_two_month_ago,
    status = Settings.status_true
      if status
        total_last_month = total_money orders_last_month
        total_this_month = total_money orders_this_month
        total_two_month_ago = total_money orders_two_month_ago
        label = t "view.statistics.total_title"
      else
        total_last_month = orders_last_month.count
        total_this_month = orders_this_month.count
        total_two_month_ago = orders_two_month_ago.count
        label = t "view.statistics.quantity_order"
      end

      this_month = Date.today.strftime(Settings.format_month)
      last_month = Settings.one_month_ago.month.ago
        .strftime(Settings.format_month)
      two_month_ago = Settings.two_month_ago.month.ago
        .strftime(Settings.format_month)
      data = {
        labels: [two_month_ago, last_month, this_month],
        datasets: [
          {
            label: label,
            backgroundColor: [
              Settings.background_red,
              Settings.background_purple,
              Settings.background_blue
            ],
            borderColor: [
              Settings.border_red,
              Settings.border_purple,
              Settings.border_blue
            ],
            borderWidth: 1,
            data: [total_two_month_ago, total_last_month, total_this_month],
          }
        ]
      }
  end

  def total_money orders
    total = Settings.total
    orders.each do |order|
      total += order.total
    end
    return total
  end
end
