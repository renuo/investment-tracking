class TimeEntriesController < ApplicationController
  def index
    csv_it_hours = RedmineRequestIt.new.request_redmine_for_entries
    csv_total_hours = RedmineRequest.new.request_redmine_for_entries

    parsed_it_hours = CsvParser.new(csv_it_hours).parse_to_hash
    parsed_total_hours = CsvParser.new(csv_total_hours).parse_to_hash

    @aggregated_time_entries = RedmineTimeEntriesAggregator.new(parsed_total_hours, parsed_it_hours)
                                                           .aggregate_time_entries
  end
end
