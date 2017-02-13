require 'rails_helper'

RSpec.describe MockRedmineTimeEntries, type: :service do
  subject { described_class.new }

  describe MockRedmineTimeEntries do
    before(:each) do
      @mock_redmine_time_entries = MockRedmineTimeEntries.new
      hash = [{ blub: 'gach' }]
    end

    it 'works' do
      allow(subject).to receive(:static_time_entries).and_return(hash)
      expect(subject.static_time_entries).to be(hash)
    end
  end
end
