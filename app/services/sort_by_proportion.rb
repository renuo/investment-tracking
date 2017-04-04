class SortByProportion
  def initialize(time_entries)
    @time_entries = time_entries
  end

  def sort_by_proportion
    @time_entries.sort_by { |key| key['proportion_used_to_worked'] }
  end
end
