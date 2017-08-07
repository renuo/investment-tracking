desc 'Fetches time entries every 10 minutes and updates the employees'

task time_entries_updater: :environment do
  EmployeeService.new.update_all_entries
end
