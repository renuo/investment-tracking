class CsvAndDbEntriesCombiner
  def initialize(time_entries_csv)
    @time_entries_csv = time_entries_csv
    @concatenated_entries = []
    @employee = nil
  end

  def combine_csv_and_db_entries
    @time_entries_csv.each do |entry|
      @employee = Employee.find_by(name: entry['name'])
      @concatenated_entries << { 'name' => @employee.name,
                                 'worked_total_hours' => entry['worked_total_hours'],
                                 'worked_investment_hours' => entry['worked_investment_hours'],
                                 'proportion_used_to_worked' => entry['proportion_used_to_worked'],
                                 'open_investment_time' => @employee.open_investment_time.round(2) }
    end

    @concatenated_entries
  end
end
