require 'rails_helper'

RSpec.describe CsvService do
  subject { described_class.new }

  before(:each) do
    investment_params = RedmineRequestCsv::INVESTMENT_PARAMS

    @url_investment_time = RedmineRequestCsv.new(investment_params).instance_variable_get('@url')
    @url_total_time = RedmineRequestCsv.new.instance_variable_get('@url')

    http_response_total_time = "User,Total time\nMax Muller,8.00\nHans Meier,12.00\nTotal time,20.00"
    stub_request(:any, @url_total_time).to_return(body: http_response_total_time)
  end

  describe '#time_entries' do
    context 'investment time is taken' do
      it 'returns the time entries' do
        http_response_investment_time = "User,Total time\nMax Muller,4.00\nHans Meier,2.00\nTotal time,6.00"

        stub_request(:any, @url_investment_time).to_return(body: http_response_investment_time)

        expect(subject.time_entries).to eq([{ 'name' => 'Hans Meier', 'worked_total_hours' => 12.0,
                                              'worked_investment_hours' => 2.0 },
                                            { 'name' => 'Max Muller', 'worked_total_hours' => 8.0,
                                              'worked_investment_hours' => 4.0 }])
      end
    end

    context 'investment time is not ktane' do
      it 'returns the time entries' do
        http_response_investment_time = "User,Total time\nTotal time,0.00"

        stub_request(:any, @url_investment_time).to_return(body: http_response_investment_time)

        expect(subject.time_entries).to eq([{ 'name' => 'Hans Meier', 'worked_total_hours' => 12.0,
                                              'worked_investment_hours' => 0.0 },
                                            { 'name' => 'Max Muller', 'worked_total_hours' => 8.0,
                                              'worked_investment_hours' => 0.0 }])
      end
    end
  end
end
