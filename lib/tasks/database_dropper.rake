desc 'This drops the database every sunday evening so that the times are recalculated once a week'

task database_dropper: :environment do
  Employee.delete_all
  RedmineImport.delete_all
  EmployeeService.new.update_all_entries
end
