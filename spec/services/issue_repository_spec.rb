require 'rails_helper'

RSpec.describe IssueRepository do
  let(:time_entries_smaller_than_latest_import) do
    '{ "time_entries": [{"created_on": "2017-01-30T00:00:02Z"},
{"created_on": "2017-02-01T00:00:00Z"}, {"created_on": "2017-01-30T00:00:01Z"}] }'
  end

  let(:time_entries_greater_than_latest_import) do
    '{ "time_entries": [{"created_on": "2017-02-01T00:00:00Z"}, {"created_on": "2017-01-29T00:00:00Z"}] }'
  end

  subject { described_class.new }

  before(:each) do
    RedmineImport.create('latest_import' => '2017-01-30T00:00:00Z')
  end

  describe '#entries_since_latest_import' do
    context 'latest import time is greater than any new time entry' do
      it 'makes the request once, takes the newest entries and sort them' do
        stub = stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
          '&limit=100&offset=0').to_return(body: time_entries_greater_than_latest_import)

        expect(subject.entries_since_latest_import)
          .to eq([{ 'created_on' => '2017-02-01T00:00:00Z' }])

        expect(stub).to have_been_requested
      end
    end

    context 'latest import time is greater than any new time entry' do
      it 'makes the request once, takes the newest entries and sort them' do
        stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
          '&limit=100&offset=0').to_return(body: time_entries_smaller_than_latest_import)
        second_request = stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
          '&limit=100&offset=100').to_return(body: time_entries_greater_than_latest_import)

        subject.entries_since_latest_import
        expect(second_request).to have_been_requested
      end
    end
  end
end
