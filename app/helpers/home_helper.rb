module HomeHelper
  def progress_bar_calculator(entry)
    limit_of_investment_time = InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME
    (100.0 / limit_of_investment_time * entry['open_investment_time']).round(2)
  end

  def progress_bar_status(entry)
    open_investment_time_in_hours = entry['open_investment_time']
    if open_investment_time_in_hours >= 60
      'progress-bar-danger'
    elsif open_investment_time_in_hours >= 40 && open_investment_time_in_hours < 60
      'progress-bar-warning'
    else
      'progress-bar-success'
    end
  end
end
