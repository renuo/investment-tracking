class RedmineTimeEntriesAggregator
  def redmine_response
    RedmineRequest.new.login[:api_key]
  end

  def count_entries
    redmine_response.count
  end

  def brutto_hours_per_user
    sum_entries(redmine_response)
  end

  def id_and_user
    find_name_of_id(redmine_response)
  end

  def all_investment_time_per_user
    calculate_investment_time_user(brutto_hours_per_user)
  end

  def find_name_of_id(redmine_data)
    redmine_data.group_by { |data_id| data_id['user']['id'] }.map do |k, v|
      Hash[:id, k, :name, v.group_by { |data_name| data_name['user']['name'] }.map { |key, _value| key } .reduce(:+)]
    end
  end

  def sum_entries(redmine_data)
    redmine_data.group_by { |data_id| data_id['user']['id'] }.map do |k, v|
      Hash[:id, k, :hours, v.group_by { |data_hours| data_hours['hours'] }.map { |key, _value| key } .reduce(:+), :name, v.group_by { |data_name| data_name['user']['name'] }.map { |key, _value| key } .reduce(:+)]
    end
  end

  def calculate_investment_time_user(grouped_redmine_data)
    grouped_redmine_data.each do |data|
      data[:all_investment_time] = data[:hours] / 5
    end
  end
end
