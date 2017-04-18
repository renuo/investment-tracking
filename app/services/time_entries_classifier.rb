class TimeEntriesClassifier
  def initialize(newest_time_entries)
    @new_time_entries = newest_time_entries
    @investment_time_entries = []
    @total_time_entries = []

    # Investment projects
    @renuo_investments = 138
    @investments_elf = 129
    @redmine_communicator = 141
    @redmine_estimator = 130
    @investments_griffin = 139
    @investments_inters = 140
  end

  def group_entries_by_project
    classify_entries
    [@investment_time_entries, @total_time_entries]
  end

  private

  def classify_entries
    @new_time_entries.each do |entry|
      rename_total_time(entry)
      extract_investment_time(entry)
    end
  end

  def rename_total_time(entry)
    @total_time_entries << { 'employee_id' => entry['user']['id'],
                             'employee_name' => entry['user']['name'],
                             'worked_hours' => entry['hours'] }
  end

  def extract_investment_time(entry)
    if [@renuo_investments, @investments_elf, @redmine_communicator, @redmine_estimator,
        @investments_griffin, @investments_inters].include? entry['project']['id']
      @investment_time_entries << { 'employee_id' => entry['user']['id'],
                                    'employee_name' => entry['user']['name'],
                                    'used_investment_time' => entry['hours'] }
    end
  end
end
