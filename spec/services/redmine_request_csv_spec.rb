require 'rails_helper'

RSpec.describe RedmineRequestCsv, type: :service do
  describe '#execute_request' do
    context 'without investment params' do
      it 'makes a http request' do
        subject = described_class.new
        url = subject.instance_variable_get('@url')
        stub = stub_request(:any, url)
        subject.execute_request
        expect(stub).to have_been_requested
      end
    end

    context 'with investment params' do
      it 'makes a http request' do
        investment_params = RedmineRequestCsv::INVESTMENT_PARAMS
        subject = described_class.new(investment_params)
        url = subject.instance_variable_get('@url')
        stub = stub_request(:any, url)
        subject.execute_request
        expect(stub).to have_been_requested
      end
    end
  end
end
