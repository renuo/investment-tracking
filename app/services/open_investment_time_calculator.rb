class OpenInvestmentTimeCalculator
  def initialize(time_entries)
    @newest_time_entries = time_entries
    @aggregated_times_per_employee = nil

    @employee_credentials = nil
    @employee_id = nil
    @employee_time_entries = nil
    @employee = nil
    @employee_investment_time = nil

    @ratio_of_investment_time = 4
  end

  def add_time_entries_to_employees
    @aggregated_times_per_employee = @newest_time_entries.map do |time_entries_per_employee|
      extract_information(time_entries_per_employee)
      add_entries_to_investment_time
      set_new_investment_time
      @employee
    end
  end

  private

  def extract_information(employee_entries)
    @employee_credentials = employee_entries[0]
    @employee_id = @employee_credentials[:redmine_user_id]
    @employee_time_entries = employee_entries[1]
    @employee = Employee.find_by(redmine_user_id: @employee_id)
    @employee_investment_time = @employee.open_investment_time
  end

  def add_entries_to_investment_time
    @employee_time_entries.each do |time_entry|
      if entry_is_investment_time(time_entry)
        subtract_investment_time(time_entry['hours'])
      else
        add_investment_time(time_entry['hours'])
        if @employee_investment_time > InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME
          @employee_investment_time = InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME
        end
      end
    end
  end

  def entry_is_investment_time(time_entry)
    renuo_investments = 138
    investments_elf = 129
    redmine_communicator = 141
    redmine_estimator = 130
    investments_griffin = 139
    investments_inters = 140

    [renuo_investments, investments_elf, redmine_communicator, redmine_estimator,
     investments_griffin, investments_inters].include? time_entry['project']['id']
  end

  def subtract_investment_time(investment_hours)
    @employee_investment_time -= investment_hours
  end

  def add_investment_time(worked_hours)
    @employee_investment_time += worked_hours / @ratio_of_investment_time
  end

  def set_new_investment_time
    @employee.open_investment_time = @employee_investment_time
  end
end
