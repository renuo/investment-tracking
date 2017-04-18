class EntriesConcatenator
  def initialize(investment_time, total_time)
    @investment_time = investment_time
    @total_time = total_time
    @concatenated_entries = nil
  end

  def merge_entries
    merge_entries_by_employee
    add_absent_investment_time
    @concatenated_entries
  end

  private

  def merge_entries_by_employee
    @concatenated_entries = (@investment_time + @total_time).group_by { |entry| entry['employee_id'] }
                                                            .map { |_, values| values.reduce(:merge) }
  end

  def add_absent_investment_time
    @concatenated_entries.each do |entry|
      unless entry.key?('used_investment_time') || (entry['used_investment_time'])
        entry['used_investment_time'] = 0
      end
    end
  end
end
