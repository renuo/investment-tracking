require 'rails_helper'

RSpec.describe RedmineTimeEntriesAggregator, type: :service do
  let(:total_time_entries) { [{ 'User' => 'Max Muster', 'Total time' => '3.0' }] }

  describe 'aggregate time entries' do
    it 'aggregates the time entries if has investment time' do
      investment_time_entries = [{ 'User' => 'Max Muster', 'Total time' => '0.6' }]
      expected_result = [{ 'investment_time_total' => 0.6, 'name' => 'Max Muster', 'worked_hours' => '3.0',
                           'worked_investment_hours' => '0.6', 'open_investment_time' => 0.0 }]
      expect(described_class.new(total_time_entries, investment_time_entries).aggregate_time_entries)
        .to eq(expected_result)
    end

    it 'aggregates the time entries if has no time' do
      investment_time_entries = []
      expected_result = [{ 'investment_time_total' => 0.6, 'name' => 'Max Muster', 'worked_hours' => '3.0',
                           'worked_investment_hours' => 0, 'open_investment_time' => 0.6 }]
      expect(described_class.new(total_time_entries, investment_time_entries).aggregate_time_entries)
        .to eq(expected_result)
    end
  end
end
