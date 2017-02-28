class SortTime
  def initialize(aggregated_times)
    @aggregated_time = aggregated_times
  end

  def sort_by_proportion
    @aggregated_time.sort_by { |key| key['percent_used_to_worked'] }
  end
end
