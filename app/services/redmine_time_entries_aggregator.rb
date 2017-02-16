class RedmineTimeEntriesAggregator
  def initialize(total_time_entries, investment_time_entries)
    @hashes_total_times = total_time_entries
    @hashes_investment_times = investment_time_entries
    @add_investment_time_to_hashes = nil
    @renamed_hashes_total_times = nil
    @renamed_hashes_investment_time = nil
    @merged_hashes = nil
    @added_open_investment_time = nil
    @added_proportion_open_worked = nil
    @added_proportion_used_open = nil
    @sort_proportion_open_worked = nil
  end

  def aggregate_time_entries
    add_total_of_investment_time
    rename_hashes_time_entries
    rename_hashes_investment_time
    merge_both_hashed
    calculate_open_investment_time
    add_proportion_open_to_worked
    add_used_open_proportion
    sort_by_proportion
    delete_hash_total_time
  end

  private

  def add_total_of_investment_time
    @add_investment_time_to_hashes = @hashes_total_times.each do |hash|
      hash['investment_time_total'] = (hash['Total time'].to_f / 5).round(2)
    end
  end

  def rename_hashes_time_entries
    @renamed_hashes_total_times = @add_investment_time_to_hashes.each do |hash|
      hash['name'] = hash.delete('User')
      hash['worked_hours'] = hash.delete('Total time')
    end
  end

  def rename_hashes_investment_time
    @renamed_hashes_investment_time = @hashes_investment_times.each do |hash|
      hash['name'] = hash.delete('User')
      hash['worked_investment_hours'] = hash.delete('Total time')
    end
  end

  def merge_both_hashed
    @merged_hashes = @renamed_hashes_total_times.each do |total_hours|
      @renamed_hashes_investment_time.each do |used_hours|
        if total_hours['name'] == used_hours['name']
          total_hours.merge!(used_hours)
        end
      end
    end
  end

  def calculate_open_investment_time
    @added_open_investment_time = @merged_hashes.each do |hash|
      if hash.key?('worked_investment_hours')
        hash['open_investment_time'] = (hash['investment_time_total'].to_f - hash['worked_investment_hours'].to_f)
                                       .round(2)
      else
        hash['worked_investment_hours'] = 0
        hash['open_investment_time'] = hash['investment_time_total'].to_f.round(2)
      end
    end
  end

  def add_proportion_open_to_worked
    @added_proportion_open_worked = @added_open_investment_time.each do |hash|
      hash['percent_used_to_worked'] = (hash['worked_investment_hours'].to_f / hash['worked_hours'].to_f * 100).round(2)
    end
  end

  def add_used_open_proportion
    @added_proportion_used_open = @added_proportion_open_worked.each do |hash|
      hash['percent_used_to_open'] = (hash['open_investment_time'].to_f / hash['investment_time_total'].to_f * 100)
                                     .round(2)
    end
  end

  def sort_by_proportion
    @sort_proportion_open_worked = @added_proportion_used_open.sort_by { |k| k['percent_used_to_worked'] }
  end

  def delete_hash_total_time
    @sort_proportion_open_worked.delete_if {|hash| hash['name'] == 'Total time'}
  end
end
