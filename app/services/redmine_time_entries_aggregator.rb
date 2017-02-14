class RedmineTimeEntriesAggregator
  def generate_aggregated_data(csv_time_entries, csv_investment_time)
    calculated_time_entries = calculate_investment_time_user(csv_time_entries)
    add_difference = difference_taken_and_open(calculated_time_entries, csv_investment_time)
    add_no_investment_time_user(add_difference)
  end

  private

  def calculate_investment_time_user(csv_datas)
    csv_datas.each do |data|
      data['Investment_time_sum'] = data['Gesamtzeit'].to_f / 5
    end
  end

  def difference_taken_and_open(csv_time_datas, csv_investment_datas)
    # [{
    #   name: 'Alicia',
    #   worked_hours: 120,
    #   worked_investment_hours: 8
    # }]
    #
    # worked_hours = csv_time_datas.map do |row|
    #   { name: row['Benutzer'], worked_hours: row['Gesamtzeit'] }
    # end
    #
    # worked_investment_hours = csv_time_datas.map do |row|
    #   { name: row['Benutzer'], worked_investment_hours: row['Gesamtzeit'] }
    # end
    #
    # (worked_hours + worked_investment_hours).group_by do |hour_person_pair|
    #   hour_person_pair[:name]
    # end.map{|k,v| v.reduce(:merge)}
    #
    # users = []

    csv_time_datas.each do |all|
      csv_investment_datas.each do |taken|
        taken_investment_time = taken['Gesamtzeit']
        if all['Benutzer'] == taken['Benutzer']
          all['Investment_time_used'] = taken_investment_time
          all['Difference_investment_time'] = (all['Investment_time_sum'].to_f - taken_investment_time.to_f).round(2)
        end
      end
    end
  end

  def add_no_investment_time_user(difference_data)
    difference_data.each do |data|
      unless data.key?('Investment_time_used')
        data['Investment_time_used'] = 0
        data['Difference_investment_time'] = data['Investment_time_sum']
      end
    end
  end
end
