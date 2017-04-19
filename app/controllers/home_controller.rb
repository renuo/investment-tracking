class HomeController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASSWORD'], except: :check

  def index
    aggregate_json_time_entries.add_to_db
    combined_csv_and_db_data = collect_data_from_csv_and_db.merge
    @data_to_display = AddPercentOfProgressBar.new(combined_csv_and_db_data).add_percent
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  private

  def collect_data_from_csv_and_db
    CollectDataFromCsvAndDb.new(data_csv_service)
  end

  def data_csv_service
    AlterCsvData.new(csv_investment_entries, csv_total_entries).alter_csv_to_final_data
  end

  def csv_investment_entries
    RedmineRequestCsvIt.new.request_redmine_for_entries
  end

  def csv_total_entries
    RedmineRequestCsv.new.request_redmine_for_entries
  end

  def json_entries
    RedmineIssue.new.entries_since_latest_import
  end

  def aggregate_json_time_entries
    AddNewestTimeEntries.new(json_entries)
  end
end
