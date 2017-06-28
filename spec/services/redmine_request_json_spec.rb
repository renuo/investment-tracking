require 'rails_helper'

RSpec.describe RedmineRequestJson do
  let(:offset) { 0 }
  subject { described_class.new(offset) }

  describe '#request_redmine_for_entries' do
    it 'makes a http request' do
      stub = stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
        '&limit=100&offset=0' + '&op%5Bissue.cf_20%5D=!&v%5Bissue.cf_20%5D%5B0%5D=0&f%5B%5D=issue.cf_20&')
             .to_return(body: '{"time_entries": {"user_name": "Max Meier"}}')

      expect(subject.fetch_json_from_redmine).to eq('user_name' => 'Max Meier')
      expect(stub).to have_been_requested
    end
  end
end
