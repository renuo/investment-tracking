desc 'This drops the database every sunday evening so that the times are recalculated once a week'

task database_dropper: :environment do
  Employee.delete_all
  RedmineImport.delete_all
  RedmineImport.create(created_at: 'Mon, 30 Jan 2017 02:00:00 CEST +02:00')
  EmployeeService.new.update_all_entries
end
