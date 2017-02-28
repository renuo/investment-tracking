class CalculateProportion
  def initialize(aggregated_times)
    @aggregated_times = aggregated_times
    @added_proportion_open_worked = nil
  end

  def add_proportions
    add_proportion_open_to_worked
    add_used_open_proportion
  end

  private

  def add_proportion_open_to_worked
    @added_proportion_open_worked = @aggregated_times.each do |hash|
      hash['percent_used_to_worked'] = (hash['worked_investment_hours'].to_f / hash['worked_hours'].to_f * 100).round(2)
    end
  end

  def add_used_open_proportion
    @added_proportion_open_worked.each do |hash|
      hash['percent_used_to_open'] = (hash['open_investment_time'].to_f / hash['investment_time_total'].to_f * 100)
                                     .round(2)
    end
  end
end
