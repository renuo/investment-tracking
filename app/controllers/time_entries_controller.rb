class TimeEntriesController < ApplicationController
  def index
    csv_worked_hours = RedmineRequest.new.retrieve_time_entries
    csv_investment_time = RedmineRequest.new.retrieve_investment_time

    parsed_worked_hours = CsvParser.new.parse_to_hash(csv_worked_hours)
    parsed_investment_time = CsvParser.new.parse_to_hash(csv_investment_time)

    @aggregated_datas = RedmineTimeEntriesAggregator.new
                                                    .generate_aggregated_data(parsed_worked_hours,
                                                                              parsed_investment_time)
  end
end
