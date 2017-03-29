class HomeController < ApplicationController
  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  def index
    @final_entries = data_service.alter_csv_to_final_data
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
