class TimeEntriesController < ApplicationController
  def index
    csv_worked_hours = RedmineRequest.new('/time_entries/report.csv?').request_redmine_for_entries
    @csv_investment_time = RedmineRequest.new('/projects/renuo-investments/time_entries/report.csv?')
                                         .request_redmine_for_entries

    parsed_worked_hours = CsvParser.new(csv_worked_hours).parse_to_hash
    parsed_investment_time = CsvParser.new(@csv_investment_time).parse_to_hash

    @aggregated_time_entries = RedmineTimeEntriesAggregator.new(parsed_worked_hours, parsed_investment_time)
                                                           .aggregate_time_entries
  end
end
