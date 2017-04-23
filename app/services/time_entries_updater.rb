class TimeEntriesUpdater
  def initialize(time_entries)
    @new_time_entries = time_entries
    @grouped_time_entries = nil
    @employees = nil
  end

  def add_to_db
    sort_and_group_entries
    ensure_all_employee_are_in_db
    add_time_entries_to_employees
    save_information_to_db
  end

  private

  def sort_and_group_entries
    @grouped_time_entries = TimeEntriesPreparator.new(@new_time_entries).sort_and_group
  end

  def ensure_all_employee_are_in_db
    @grouped_time_entries.map do |time_entries_per_employee|
      employee_credentials = time_entries_per_employee[0]

      Employee.find_or_create_by!(redmine_user_id: employee_credentials[:redmine_user_id]) do |employee|
        employee.name = employee_credentials[:name]
        employee.open_investment_time = 0
      end
    end
  end

  def add_time_entries_to_employees
    @employees = OpenInvestmentTimeCalculator.new(@grouped_time_entries).add_time_entries_to_employees
  end

  def save_information_to_db
    save_new_employees
    save_current_time_to_db
  end

  def save_new_employees
    Employee.transaction do
      @employees.each(&:save!)
    end
  end

  def save_current_time_to_db
    SaveRedmineImportTime.new.save_current_time_to_db
  end
end
