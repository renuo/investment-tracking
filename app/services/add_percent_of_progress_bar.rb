class AddPercentOfProgressBar
  def initialize(entries)
    @time_entries = entries
    @proportion_of_investment_time = 4.0
    @limit_of_investment_time = InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME
  end

  def add_percent
    @time_entries.each do |entry|
      entry['reached_quota_percentage'] = (100.0 / @limit_of_investment_time * entry['open_investment_time']).round(2)
    end
  end
end
