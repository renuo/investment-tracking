require 'rails_helper'

RSpec.describe RedmineTimeEntriesAggregator, type: :service do
  let(:total_time_entries) { [{ 'Benutzer' => 'Max Muster', 'Gesamtzeit' => '3.0' }] }
  let(:investment_time_entries) { [{ 'Benutzer' => 'Max Muster', 'Gesamtzeit' => '0' }] }
  subject { described_class.new(total_time_entries, investment_time_entries) }

  describe 'aggregate time entries' do
    it 'aggregates the time entries' do
      expected_result = [{ 'investment_time_total' => 0.6,
                           'name' => 'Max Muster',
                           'worked_hours' => '3.0',
                           + 'worked_investment_hours' => '0',
                           'open_investment_time' => 0.6 }]
      expect(subject.aggregate_time_entries).to eq(expected_result)
    end
  end
end
