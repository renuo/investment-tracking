class AggregateNewestEntries
  def initialize(time_entries)
    @new_time_entries = time_entries
    @grouped_entries_by_employee = nil
  end

  def aggregate
    group_entries_by_employee
    @grouped_entries_by_employee
  end

  private

  def group_entries_by_employee
    @grouped_entries_by_employee = @new_time_entries.group_by { |time_entry| time_entry['employee_id'] }
                                                    .map do |_id, time_entries_per_employee|
      time_entries_per_employee.reduce do |hash, next_hash|
        merge_hashes(hash, next_hash)
      end
    end
  end

  def merge_hashes(hash, next_hash)
    hash.merge(next_hash) do |key, hash_value, next_hash_value|
      if (key == 'employee_id') || (key == 'employee_name')
        hash_value
      else
        (hash_value + next_hash_value)
      end
    end
  end
end
