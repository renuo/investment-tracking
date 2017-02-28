class DeleteTime
  def initialize(sortes_times)
    @sortes_times = sortes_times
  end

  def delete_total_time
    @sortes_times.delete_if { |hash| hash['name'] == 'Total time' }
  end
end
