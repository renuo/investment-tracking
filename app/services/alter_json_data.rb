class AlterJsonData
  def initialize(all_time_entries)
    @all_new_time_entries = all_time_entries
    @new_total_time_entries = nil
    @new_investment_time_entries = nil
    @grouped_total_entries = nil
    @grouped_investment_entries = nil
    @concatenated_entries = nil
  end

  def alter_json_to_final_data
    group_time_entries
    aggregate_entries_by_employee
    concatenate_entries
  end

  private

  def group_time_entries
    grouped_time_entries = TimeEntriesClassifier.new(@all_new_time_entries).group_entries_by_project
    @new_investment_time_entries = grouped_time_entries[0]
    @new_total_time_entries = grouped_time_entries[1]
  end

  def aggregate_entries_by_employee
    @grouped_total_entries = AggregateNewestEntries.new(@new_total_time_entries).aggregate
    @grouped_investment_entries = AggregateNewestEntries.new(@new_investment_time_entries).aggregate
  end

  def concatenate_entries
    @concatenated_entries = EntriesConcatenator.new(@grouped_total_entries, @grouped_investment_entries).merge_entries
  end
end
