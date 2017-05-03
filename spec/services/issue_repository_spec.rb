require 'rails_helper'

RSpec.describe IssueRepository do
  let(:entries_with_created_on_smaller_than_latest_import) do
    '{ "time_entries": [{"created_on": "2017-01-31T00:00:00Z"},
{"created_on": "2017-02-01T00:00:00Z"}, {"created_on": "2017-02-2T00:00:00Z"}] }'
  end

  let(:entries_with_created_on_greater_than_latest_import) do
    '{ "time_entries": [{"created_on": "2017-02-02T00:00:00Z"}, {"created_on": "2017-01-29T00:00:00Z"}] }'
  end

  subject { described_class.new }

  before(:each) do
    RedmineImport.create('created_at' => 'Mon, 30 Jan 2017 00:00:00 CEST +02:00')
  end

  describe '#entries_since_latest_import' do
    context 'latest import time is greater than any created on of each new time entry' do
      it 'makes the request once, takes the newest entries and sort them' do
        stub = stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
          '&limit=100&offset=0').to_return(body: entries_with_created_on_greater_than_latest_import)

        expect(subject.entries_since_latest_import)
          .to eq([{ 'created_on' => '2017-02-02T00:00:00Z' }])

        expect(stub).to have_been_requested
      end
    end

    context 'latest import time is smaller than any created on of each new time entry' do
      it 'makes the request once, takes the newest entries and sort them' do
        stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
          '&limit=100&offset=0').to_return(body: entries_with_created_on_smaller_than_latest_import)
        second_request = stub_request(:any, 'https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] +
          '&limit=100&offset=100').to_return(body: entries_with_created_on_greater_than_latest_import)

        expect(subject.entries_since_latest_import)
          .to eq([{ 'created_on' => '2017-02-2T00:00:00Z' }, { 'created_on' => '2017-02-01T00:00:00Z' },
                  { 'created_on' => '2017-01-31T00:00:00Z' }, { 'created_on' => '2017-02-02T00:00:00Z' }])

        expect(second_request).to have_been_requested
      end
    end
  end
end
