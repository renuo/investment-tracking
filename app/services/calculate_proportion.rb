class CalculateProportion
  def initialize(entries)
    @time_entries = entries
    @proportion_of_investment_time = 4.0
  end

  def calculate
    add_proportion_used_to_worked
  end

  private

  def add_proportion_used_to_worked
    @time_entries.each do |entry|
      entry['proportion_used_to_worked'] = (entry['worked_investment_hours'] /
        entry['worked_total_hours'] * 100).round(2)
    end
  end
end
