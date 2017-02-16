require 'rails_helper'

RSpec.describe RedmineTimeEntriesAggregator, type: :service do
  let(:total_time_entries) { [{ 'User' => 'Max Muster', 'Total time' => '3.0' }] }
  let(:investment_time_entries) { [{ 'User' => 'Max Muster', 'Total time' => '0.6' }] }
  subject { described_class.new(total_time_entries, investment_time_entries) }

  describe 'aggregate time entries' do
    it 'aggregates the time entries' do
      expected_result = [{ 'investment_time_total' => 0.6,
                           'name' => 'Max Muster',
                           'worked_hours' => '3.0',
                           "worked_investment_hours"=>"0.6",
                           "open_investment_time"=>0.0,
                           "percent_used_to_worked"=>20.0,
                           "percent_used_to_open"=>0.0}]
      expect(subject.aggregate_time_entries).to eq(expected_result)
    end
  end
end
