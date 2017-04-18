class HomeController < ApplicationController
  def index
    new_time_entries = RedmineRequestJson.new.fetch_json_from_redmine
    investment_time_entries = RedmineRequestJsonInvestmentTime.new.fetch_json_from_redmine
    @concatenated_hashes = ConcatenateHashes.new(new_time_entries, investment_time_entries).concatenate
    @final_entries = data_service.alter_csv_to_final_data
    @final_entries_csv = data_csv_service.alter_csv_to_final_data
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  private

  def data_service
    AlterCsvData.new(csv_investment_entries, csv_total_entries)
  end

  def csv_investment_entries
    RedmineRequestCsvIt.new.request_redmine_for_entries
  end

  def csv_total_entries
    RedmineRequestCsv.new.request_redmine_for_entries
  end
end
