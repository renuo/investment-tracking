class HomeController < ApplicationController
  def initialize
    @csv_it_hours = nil
    @csv_total_hours = nil
    @parsed_it_hours = nil
    @parsed_total_hours = nil
    @aggregated_time_entries = nil
    super
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  def index
    redmine_request
    parse_request_to_csv
    aggregated_time_entries
  end

  private

  def redmine_request
    @csv_it_hours = RedmineRequestIt.new.request_redmine_for_entries
    @csv_total_hours = RedmineRequest.new.request_redmine_for_entries
  end

  def parse_request_to_csv
    @parsed_it_hours = CsvParser.new(@csv_it_hours).parse_to_hash
    @parsed_total_hours = CsvParser.new(@csv_total_hours).parse_to_hash
  end

  def aggregated_time_entries
    aggregated_times = RedmineTimeEntriesAggregator.new(@parsed_total_hours, @parsed_it_hours)
                                                   .aggregate_time_entries
    added_proportion = CalculateProportion.new(aggregated_times).add_proportions
    sorted_times = SortTime.new(added_proportion).sort_by_proportion
    @times_per_users = DeleteTime.new(sorted_times).delete_total_time
  end
end
