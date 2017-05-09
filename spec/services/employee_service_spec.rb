require 'rails_helper'

RSpec.describe EmployeeService do
  subject { described_class.new }

  before(:each) do
    investment_params = RedmineRequestCsv::INVESTMENT_PARAMS

    @url_investment_time = RedmineRequestCsv.new(investment_params).instance_variable_get('@url')
    @url_total_time = RedmineRequestCsv.new.instance_variable_get('@url')

    http_response_total_time = "User,Total time\nMax Muller,8.00\nHans Meier,12.00\nTotal time,20.00"
    http_response_investment_time = "User,Total time\nMax Muller,4.00\nHans Meier,2.00\nTotal time,6.00"

    stub_request(:any, @url_total_time).to_return(body: http_response_total_time)
    stub_request(:any, @url_investment_time).to_return(body: http_response_investment_time)

    Employee.create!('name' => 'Max Muller', 'redmine_user_id' => 1, 'open_investment_time' => 3)
    Employee.create!('name' => 'Hans Meier', 'redmine_user_id' => 2, 'open_investment_time' => 4)
  end

  describe '#all_with_totals' do
    it 'gets all employee with totals' do
      expect(subject.all_with_totals).to eq [{ 'name' => 'Hans Meier',
                                               'worked_total_hours' => 12.0,
                                               'worked_investment_hours' => 2.0,
                                               'open_investment_time' => 4.0 },
                                             { 'name' => 'Max Muller',
                                               'worked_total_hours' => 8.0,
                                               'worked_investment_hours' => 4.0,
                                               'open_investment_time' => 3.0 }]
    end
  end
end
