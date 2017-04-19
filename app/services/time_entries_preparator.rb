class TimeEntriesPreparator
  def initialize(newest_time_entries)
    @new_time_entries = newest_time_entries
    @sorted_time_entries = nil
    @grouped_time_entries = nil
  end

  def sort_and_group
    sort_entries_by_created_on
    group_entries_by_employee
  end

  private

  def sort_entries_by_created_on
    @sorted_time_entries = @new_time_entries.sort_by { |key| key['created_on'] }
  end

  def group_entries_by_employee
    @grouped_time_entries = @sorted_time_entries
                            .group_by do |time_entry|
      { redmine_user_id: time_entry['user']['id'],
        name: time_entry['user']['name'] }
    end
  end
end
