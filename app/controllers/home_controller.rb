class HomeController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASSWORD'], except: :check

  def index
    @employee = employee_service.all_with_totals
  end

  def check
    val = ActiveRecord::Base.connection.execute('select 1+2 as val').first['val']
    render plain: "1+2=#{val}"
  end

  private

  def employee_service
    @employee_service ||= EmployeeService.new
  end
end
