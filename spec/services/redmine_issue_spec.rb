require 'rails_helper'

RSpec.describe RedmineIssue do
  let(:time_entries) do
    '{ "time_entries": [{"created_on": "2017-01-29T00:00:00Z"},
{"created_on": "2017-02-01T00:00:00Z"}, {"created_on": "2017-01-30T00:00:01Z"}] }'
  end
  subject { described_class.new }

  before(:each) do
    Import.create('latest_import' => '2017-01-30T00:00:00Z')
  end

  it 'takes the newest entries and sort them' do
    stub_request(:any, /redmine.renuo.ch/).to_return(body: time_entries)

    expect(subject.entries_since_latest_import)
      .to eq([{ 'created_on' => '2017-02-01T00:00:00Z' }, { 'created_on' => '2017-01-30T00:00:01Z' }])
  end
end
