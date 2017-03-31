class HomeController < ApplicationController
  def index
    new_time_entries = RedmineRequestJson.new.fetch_json_from_redmine
    investment_time_entries = RedmineRequestJsonInvestmentTime.new.fetch_json_from_redmine
    @concatenated_hashes = ConcatenateHashes.new(new_time_entries, investment_time_entries).concatenate
    @all_users = User.all
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end
end
