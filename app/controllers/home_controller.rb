class HomeController < ApplicationController
  def initialize
    @csv_investment_entries = nil
    @csv_total_entries = nil

    @hashes_investment_entries = nil
    @hashes_total_entries = nil

    @concatenated_entries = nil

    @entries_with_calculations = nil

    @leftover_of_deletion_entries = nil

    @sorted_entries = nil
    super
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  def index
    redmine_request_for_csv
    parse_csv_to_hash
    concatenate_hashes
    add_calculations_to_entries
    delete_total_time
    sort_time_entries
  end

  private

  def redmine_request_for_csv
    @csv_investment_entries = RedmineRequestCsvIt.new.request_redmine_for_entries
    @csv_total_entries = RedmineRequestCsv.new.request_redmine_for_entries
  end

  def parse_csv_to_hash
    @hashes_investment_entries = CsvParser.new(@csv_investment_entries).parse_to_hash
    @hashes_total_entries = CsvParser.new(@csv_total_entries).parse_to_hash
  end

  def concatenate_hashes
    @concatenated_entries = HashConcatenator.new(@hashes_investment_entries, @hashes_total_entries).concatenate
  end

  def add_calculations_to_entries
    @entries_with_calculations = Calculator.new(@concatenated_entries).calculate
  end

  def delete_total_time
    @leftover_of_deletion_entries = DeleteTime.new(@entries_with_calculations).delete_total_time
  end

  def sort_time_entries
    @sorted_entries = SortByProportion.new(@leftover_of_deletion_entries).sort_by_proportion
  end
end
