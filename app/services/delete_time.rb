class DeleteTime
  def initialize(time_entries)
    @time_entries = time_entries
  end

  def delete_total_time
    @time_entries.delete_if { |hash| hash['name'] == 'Total time' }
  end
end
