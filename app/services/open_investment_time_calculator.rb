class OpenInvestmentTimeCalculator
  def initialize(time_entries)
    @time_entries = time_entries
    @updated_times_of_employees = nil

    @employee = { redmine_id: nil, entries: nil, investment_time: nil, employee_from_db: nil }

    @ratio_of_investment_time = InvestmentTracking::Application::PROPORTION_OF_INVESTMENT_TIME
    @limit_of_investment_time = InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME
  end

  def add_time_entries_to_employees
    @updated_times_of_employees = @time_entries.map do |time_entries_per_employee|
      extract_information(time_entries_per_employee)
      add_entries_to_existing_investment_time
      set_new_investment_time
      @employee[:employee_from_db]
    end
  end

  private

  def extract_information(employee_entries)
    employee_from_time_entries = employee_entries[0]
    @employee[:redmine_id] = employee_from_time_entries[:redmine_user_id]
    @employee[:entries] = employee_entries[1]

    employee_from_db = Employee.find_by(redmine_user_id: @employee[:redmine_id])
    @employee[:employee_from_db] = employee_from_db
    @employee[:investment_time] = employee_from_db.open_investment_time
  end

  def add_entries_to_existing_investment_time
    @employee[:entries].each do |time_entry|
      if entry_is_investment_time(time_entry)
        subtract_investment_time(time_entry['hours'])
      else
        add_investment_time(time_entry['hours'])
        if @employee[:investment_time] > @limit_of_investment_time
          @employee[:investment_time] = @limit_of_investment_time
        end
      end
    end
  end

  def entry_is_investment_time(time_entry)
    RedmineInvestmentProjects.new.ids.include? time_entry['project']['id']
  end

  def subtract_investment_time(investment_hours)
    @employee[:investment_time] -= investment_hours
  end

  def add_investment_time(worked_hours)
    @employee[:investment_time] += worked_hours / @ratio_of_investment_time
  end

  def set_new_investment_time
    @employee[:employee_from_db].open_investment_time = @employee[:investment_time]
  end
end
