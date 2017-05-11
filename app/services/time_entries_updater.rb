class TimeEntriesUpdater
  def initialize(time_entries)
    @new_time_entries = time_entries
    @grouped_time_entries = nil
    @employees = nil
  end

  def update_user_and_save
    group_entries_by_employee
    create_missing_employees_in_db
    update_open_investment_time
    save_current_time_to_db
  end

  private

  def group_entries_by_employee
    @grouped_time_entries = @new_time_entries.group_by do |time_entry|
      { redmine_user_id: time_entry['user']['id'], name: time_entry['user']['name'] }
    end
  end

  def create_missing_employees_in_db
    @grouped_time_entries.map do |user, _time_entries|
      Employee.find_or_create_by!(redmine_user_id: user[:redmine_user_id]) do |employee|
        employee.name = user[:name]
        employee.open_investment_time = 0
      end
    end
  end

  def update_open_investment_time
    employees = OpenInvestmentTimeCalculator.new.sum_entries_rely_on_project_id(@grouped_time_entries)

    Employee.transaction do
      employees.each(&:save!)
    end
  end

  def save_current_time_to_db
    RedmineImport.new.save
  end
end
