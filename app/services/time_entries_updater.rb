class TimeEntriesUpdater
  def initialize(time_entries)
    @new_time_entries = time_entries
    @grouped_time_entries = nil
    @employees = nil
  end

  def add_to_db
    sort_and_group_entries
    create_missing_employees_in_db
    add_time_entries_to_employees
    save_information_to_db
  end

  private

  def sort_and_group_entries
    @grouped_time_entries = TimeEntriesPreparator.new(@new_time_entries).sort_and_group
  end

  def create_missing_employees_in_db
    @grouped_time_entries.map do |time_entries_per_employee|
      user = time_entries_per_employee.first

      Employee.find_or_create_by!(redmine_user_id: user[:redmine_user_id]) do |employee|
        employee.name = user[:name]
        employee.open_investment_time = 0
      end
    end
  end

  def add_time_entries_to_employees
    @employees = OpenInvestmentTimeCalculator.new(@grouped_time_entries).add_time_entries_to_employees
  end

  def save_information_to_db
    update_times_of_each_employee
    save_current_time_to_db
  end

  def update_times_of_each_employee
    Employee.transaction do
      @employees.each(&:save!)
    end
  end

  def save_current_time_to_db
    SaveRedmineImportTime.new.save_current_time_to_db
  end
end
