class HomeController < ApplicationController
  def index
    @final_entries_csv = data_csv_service.alter_csv_to_final_data
    @final_entries_json = altered_entries.save_to_db
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  private

  def data_csv_service
    AlterCsvData.new(csv_investment_entries, csv_total_entries)
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

  def alter_json_entries
    AlterJsonData.new(json_entries).alter_json_to_final_data
  end

  def altered_entries
    SaveEntries.new(alter_json_entries)
  end
end
