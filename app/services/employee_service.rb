class EmployeeService
  def update_all_entries
    TimeEntriesUpdater.new(new_time_entries).update_user_and_save
  end

  def all_with_totals
    append_open_investment_time(users_report.time_entries)
  end

  private

  def new_time_entries
    IssueRepository.new.entries_since_latest_import
  end

  def users_report
    @csv_service ||= CsvService.new
  end

  def append_open_investment_time(time_entries)
    time_entries.map do |entry|
      employee = Employee.find_by(name: entry['name'])
      entry.merge('open_investment_time' => employee.open_investment_time.round(2))
    end
  end
end
