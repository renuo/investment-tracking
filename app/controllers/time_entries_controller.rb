class TimeEntriesController < ApplicationController
  def index
    @count_times = RedmineTimeEntriesAggregator.new.count_entries
    @name_and_id = RedmineTimeEntriesAggregator.new.id_and_user
    @aggregated_values = RedmineTimeEntriesAggregator.new.all_investment_time_per_user
  end
end
