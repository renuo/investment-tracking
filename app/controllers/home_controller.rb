class HomeController < ApplicationController
  def index
    RedmineRequestJson.new.fetch_json_from_redmine
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end
end
