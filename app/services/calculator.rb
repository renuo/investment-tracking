class Calculator
  def initialize(entries)
    @time_entries = entries
    @proportion_of_investment_time = 5.0
    @limit_of_investment_time = 80
  end

  def calculate
    add_total_investment_time
    add_open_investment_time
    add_proportion_used_to_worked
    add_calc_for_progress_bar
  end

  private

  def add_total_investment_time
    @time_entries.each do |entry|
      entry['investment_time_total'] = (entry['worked_total_hours'] / @proportion_of_investment_time)
    end
  end

  def add_open_investment_time
    @time_entries.each do |entry|
      if entry.key?('worked_investment_hours')
        entry['open_investment_time'] = (entry['investment_time_total'] - entry['worked_investment_hours'])
                                        .round(2)
      else
        entry['worked_investment_hours'] = 0
        entry['open_investment_time'] = entry['investment_time_total'].round(2)
      end
    end
  end

  def add_proportion_used_to_worked
    @time_entries.each do |entry|
      entry['proportion_used_to_worked'] = (entry['worked_investment_hours'] /
        entry['worked_total_hours'] * 100).round(2)
    end
  end

  def add_calc_for_progress_bar
    @time_entries.each do |entry|
      entry['reached_quota_percentage'] = (100.0 / @limit_of_investment_time * entry['open_investment_time']).round(2)
    end
  end
end