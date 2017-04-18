class SaveNewEntries
  def initialize(time_entries)
    @time_entries = time_entries
    @db_is_empty = Employee.all.empty?
  end

  def save_new_entries_to_db
    check_if_employee_exists
    fill_db_with_new_entries
  end

  private

  def check_if_employee_exists
    @time_entries.each do |entry|
      next if Employee.exists?(employee_name: entry['employee_name'])
      Employee.create(employee_name: entry['employee_name'],
                      employee_id: entry['employee_id'],
                      open_investment_time: 0)
    end
  end

  def fill_db_with_new_entries
    @time_entries.each do |entry|
      current_employee = Employee.find_by(employee_name: entry['employee_name'])
      current_employee_investment = current_employee.open_investment_time
      new_investment_time = calculate_new_investment_time(entry, current_employee_investment)
      current_employee.open_investment_time = setting_new_open_investment_time(new_investment_time)
      current_employee.save
    end
  end

  def setting_new_open_investment_time(new_investment_time)
    if new_investment_time > 80
      80
    else
      new_investment_time
    end
  end

  def calculate_new_investment_time(entry, current_employee_investment)
    entry['worked_hours'] / 5 - entry['used_investment_time'] + current_employee_investment
  end
end
