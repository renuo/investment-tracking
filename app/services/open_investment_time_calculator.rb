class OpenInvestmentTimeCalculator
  def initialize
    @updated_times_of_employees = nil

    @ratio_of_investment_time = InvestmentTracking::Application::PROPORTION_OF_INVESTMENT_TIME
    @limit_of_investment_time = InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME
  end

  def sum_entries_rely_on_project_id(grouped_time_entries)
    grouped_time_entries.map do |user, entries|
      employee = Employee.find_by(redmine_user_id: user[:redmine_user_id])

      calculate_open_investment_time(employee, entries)
    end
  end

  private

  def calculate_open_investment_time(employee, time_entries)
    time_entries.each do |time_entry|
      open_investment_time = employee.open_investment_time
      if investment_project(time_entry)
        open_investment_time -= time_entry['hours']
      else
        open_investment_time += new_investment_time(time_entry)
      end

      employee.open_investment_time = [open_investment_time, @limit_of_investment_time].min
    end
    employee
  end

  def new_investment_time(time_entry)
    if !time_entry.key?('issue')
      time_entry['hours'] / @ratio_of_investment_time
    elsif !(excluded_tickets.ticket_nrs.include? time_entry['issue']['id'])
      time_entry['hours'] / @ratio_of_investment_time
    else
      0
    end
  end

  def investment_project(time_entry)
    investment_projects.ids.include? time_entry['project']['id']
  end

  def investment_projects
    @redmine_investment_project ||= RedmineInvestmentProjects.new
  end

  def excluded_tickets
    @redmine_excluded_tickets ||= RedmineExcludedTickets.new
  end
end
